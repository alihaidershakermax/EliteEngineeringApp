import { Injectable, NotFoundException } from '@nestjs/common';
import { FirebaseService } from '../firebase/firebase.service';
import { CreateAnnouncementDto } from './dto/announcement.dto';

@Injectable()
export class AnnouncementsService {
  private readonly collectionName = 'announcements';

  constructor(private firebaseService: FirebaseService) {}

  async create(createAnnouncementDto: CreateAnnouncementDto) {
    return this.firebaseService.createDocument(this.collectionName, {
      ...createAnnouncementDto,
      views: 0,
    });
  }

  async findAll() {
    const announcements = await this.firebaseService.getCollection(this.collectionName);
    // Sort by createdAt descending
    return announcements.sort((a: any, b: any) => {
      const dateA = a.createdAt?._seconds || 0;
      const dateB = b.createdAt?._seconds || 0;
      return dateB - dateA;
    });
  }

  async getRecent(limit: number) {
    const all = await this.findAll();
    return all.slice(0, limit);
  }

  async findById(id: string) {
    const announcement = await this.firebaseService.getDocument(
      this.collectionName,
      id,
    );
    if (!announcement) {
      throw new NotFoundException('الإعلان غير موجود');
    }
    
    // Increment views
    await this.firebaseService.updateDocument(this.collectionName, id, {
      views: (announcement.views || 0) + 1,
    });

    return announcement;
  }

  async update(id: string, updateData: any) {
    return this.firebaseService.updateDocument(this.collectionName, id, updateData);
  }

  async delete(id: string) {
    return this.firebaseService.deleteDocument(this.collectionName, id);
  }
}
