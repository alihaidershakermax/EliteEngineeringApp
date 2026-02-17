import { Injectable, NotFoundException } from '@nestjs/common';
import { FirebaseService } from '../firebase/firebase.service';
import { CreateEventDto } from './dto/event.dto';

@Injectable()
export class EventsService {
  private readonly collectionName = 'events';

  constructor(private firebaseService: FirebaseService) {}

  async create(createEventDto: CreateEventDto) {
    return this.firebaseService.createDocument(this.collectionName, createEventDto);
  }

  async findAll() {
    return this.firebaseService.getCollection(this.collectionName);
  }

  async getUpcoming() {
    const events = await this.findAll();
    const now = new Date();
    
    return events
      .filter((event: any) => new Date(event.date) >= now)
      .sort((a: any, b: any) => {
        return new Date(a.date).getTime() - new Date(b.date).getTime();
      });
  }

  async findById(id: string) {
    const event = await this.firebaseService.getDocument(this.collectionName, id);
    if (!event) {
      throw new NotFoundException('الفعالية غير موجودة');
    }
    return event;
  }

  async update(id: string, updateData: any) {
    return this.firebaseService.updateDocument(this.collectionName, id, updateData);
  }

  async delete(id: string) {
    return this.firebaseService.deleteDocument(this.collectionName, id);
  }
}
