import { Injectable, OnModuleInit } from '@nestjs/common';
import * as admin from 'firebase-admin';
import { ConfigService } from '@nestjs/config';

@Injectable()
export class FirebaseService implements OnModuleInit {
  private firestore: admin.firestore.Firestore;
  private auth: admin.auth.Auth;

  constructor(private configService: ConfigService) {}

  onModuleInit() {
    // Initialize Firebase Admin SDK
    if (!admin.apps.length) {
      admin.initializeApp({
        credential: admin.credential.cert({
          projectId: this.configService.get<string>('FIREBASE_PROJECT_ID'),
          privateKey: this.configService
            .get<string>('FIREBASE_PRIVATE_KEY')
            ?.replace(/\\n/g, '\n'),
          clientEmail: this.configService.get<string>('FIREBASE_CLIENT_EMAIL'),
        }),
      });
    }

    this.firestore = admin.firestore();
    this.auth = admin.auth();
  }

  getFirestore(): admin.firestore.Firestore {
    return this.firestore;
  }

  getAuth(): admin.auth.Auth {
    return this.auth;
  }

  // Helper methods for Firestore operations
  async getCollection(collectionName: string) {
    const snapshot = await this.firestore.collection(collectionName).get();
    return snapshot.docs.map((doc) => ({ id: doc.id, ...doc.data() }));
  }

  async getDocument(collectionName: string, docId: string) {
    const doc = await this.firestore.collection(collectionName).doc(docId).get();
    if (!doc.exists) {
      return null;
    }
    return { id: doc.id, ...doc.data() };
  }

  async createDocument(collectionName: string, data: any) {
    const docRef = await this.firestore.collection(collectionName).add({
      ...data,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });
    return { id: docRef.id, ...data };
  }

  async updateDocument(collectionName: string, docId: string, data: any) {
    await this.firestore
      .collection(collectionName)
      .doc(docId)
      .update({
        ...data,
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    return this.getDocument(collectionName, docId);
  }

  async deleteDocument(collectionName: string, docId: string) {
    await this.firestore.collection(collectionName).doc(docId).delete();
    return { success: true };
  }

  async queryCollection(
    collectionName: string,
    field: string,
    operator: admin.firestore.WhereFilterOp,
    value: any,
  ) {
    const snapshot = await this.firestore
      .collection(collectionName)
      .where(field, operator, value)
      .get();
    return snapshot.docs.map((doc) => ({ id: doc.id, ...doc.data() }));
  }
}
