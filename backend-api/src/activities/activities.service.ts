import { Injectable, NotFoundException, BadRequestException } from '@nestjs/common';
import { FirebaseService } from '../firebase/firebase.service';
import { CreateActivityDto, RegisterActivityDto } from './dto/activity.dto';

@Injectable()
export class ActivitiesService {
  private readonly collectionName = 'activities';
  private readonly registrationsCollection = 'activity_registrations';

  constructor(private firebaseService: FirebaseService) {}

  async create(createActivityDto: CreateActivityDto) {
    return this.firebaseService.createDocument(this.collectionName, {
      ...createActivityDto,
      participants: 0,
      registeredUsers: [],
    });
  }

  async findAll() {
    return this.firebaseService.getCollection(this.collectionName);
  }

  async findById(id: string) {
    const activity = await this.firebaseService.getDocument(this.collectionName, id);
    if (!activity) {
      throw new NotFoundException('النشاط غير موجود');
    }
    return activity;
  }

  async findByCategory(category: string) {
    return this.firebaseService.queryCollection(
      this.collectionName,
      'category',
      '==',
      category,
    );
  }

  async register(activityId: string, userId: string, registerDto: RegisterActivityDto) {
    const activity = await this.findById(activityId);

    // Check if already registered
    const existingRegistration = await this.firebaseService.queryCollection(
      this.registrationsCollection,
      'activityId',
      '==',
      activityId,
    );

    const userRegistered = existingRegistration.find(
      (reg: any) => reg.userId === userId,
    );

    if (userRegistered) {
      throw new BadRequestException('أنت مسجل بالفعل في هذا النشاط');
    }

    // Check capacity
    if (activity.maxParticipants && activity.participants >= activity.maxParticipants) {
      throw new BadRequestException('النشاط ممتلئ');
    }

    // Create registration
    const registration = await this.firebaseService.createDocument(
      this.registrationsCollection,
      {
        activityId,
        userId,
        ...registerDto,
        status: 'confirmed',
      },
    );

    // Update activity participants count
    await this.firebaseService.updateDocument(this.collectionName, activityId, {
      participants: activity.participants + 1,
    });

    return {
      message: 'تم التسجيل في النشاط بنجاح',
      registration,
    };
  }

  async getUserActivities(userId: string) {
    const registrations = await this.firebaseService.queryCollection(
      this.registrationsCollection,
      'userId',
      '==',
      userId,
    );

    const activities = await Promise.all(
      registrations.map(async (reg: any) => {
        const activity = await this.findById(reg.activityId);
        return {
          ...activity,
          registrationStatus: reg.status,
          registeredAt: reg.createdAt,
        };
      }),
    );

    return activities;
  }

  async update(id: string, updateData: any) {
    return this.firebaseService.updateDocument(this.collectionName, id, updateData);
  }

  async delete(id: string) {
    return this.firebaseService.deleteDocument(this.collectionName, id);
  }
}
