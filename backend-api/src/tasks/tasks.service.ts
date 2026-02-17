import { Injectable, NotFoundException } from '@nestjs/common';
import { FirebaseService } from '../firebase/firebase.service';
import { CreateTaskDto, UpdateTaskDto } from './dto/task.dto';

@Injectable()
export class TasksService {
  private readonly collectionName = 'tasks';

  constructor(private firebaseService: FirebaseService) {}

  async create(userId: string, createTaskDto: CreateTaskDto) {
    return this.firebaseService.createDocument(this.collectionName, {
      ...createTaskDto,
      userId,
      status: 'نشطة',
      progress: createTaskDto.progress || 0,
    });
  }

  async findAll(userId: string) {
    return this.firebaseService.queryCollection(
      this.collectionName,
      'userId',
      '==',
      userId,
    );
  }

  async findById(id: string, userId: string) {
    const task = await this.firebaseService.getDocument(this.collectionName, id);
    if (!task) {
      throw new NotFoundException('المهمة غير موجودة');
    }
    if (task.userId !== userId) {
      throw new NotFoundException('ليس لديك صلاحية للوصول لهذه المهمة');
    }
    return task;
  }

  async findByStatus(userId: string, status: string) {
    const userTasks = await this.findAll(userId);
    return userTasks.filter((task: any) => task.status === status);
  }

  async update(id: string, userId: string, updateTaskDto: UpdateTaskDto) {
    await this.findById(id, userId); // Check if task exists and belongs to user
    
    const updateData: any = { ...updateTaskDto };
    
    // Auto-update status based on progress
    if (updateTaskDto.progress !== undefined) {
      if (updateTaskDto.progress >= 100) {
        updateData.status = 'مكتملة';
      } else if (updateTaskDto.progress > 0) {
        updateData.status = 'نشطة';
      }
    }

    return this.firebaseService.updateDocument(this.collectionName, id, updateData);
  }

  async delete(id: string, userId: string) {
    await this.findById(id, userId); // Check if task exists and belongs to user
    return this.firebaseService.deleteDocument(this.collectionName, id);
  }

  async getStatistics(userId: string) {
    const tasks = await this.findAll(userId);
    
    const active = tasks.filter((t: any) => t.status === 'نشطة').length;
    const completed = tasks.filter((t: any) => t.status === 'مكتملة').length;
    const overdue = tasks.filter((t: any) => {
      if (t.status === 'مكتملة') return false;
      const dueDate = new Date(t.dueDate);
      return dueDate < new Date();
    }).length;

    const totalProgress = tasks.reduce((sum: number, t: any) => sum + (t.progress || 0), 0);
    const averageProgress = tasks.length > 0 ? Math.round(totalProgress / tasks.length) : 0;

    return {
      total: tasks.length,
      active,
      completed,
      overdue,
      averageProgress,
    };
  }
}
