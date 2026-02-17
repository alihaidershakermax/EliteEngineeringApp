import { Injectable, NotFoundException } from '@nestjs/common';
import { FirebaseService } from '../firebase/firebase.service';

@Injectable()
export class UsersService {
  private readonly collectionName = 'users';

  constructor(private firebaseService: FirebaseService) {}

  async create(userData: any) {
    const user = await this.firebaseService.createDocument(this.collectionName, {
      name: userData.name,
      email: userData.email,
      password: userData.password,
      phone: userData.phone || '',
      role: userData.role || 'member',
      avatar: userData.avatar || '',
      bio: userData.bio || '',
      committees: userData.committees || [],
      projects: userData.projects || [],
      statistics: {
        tasksCompleted: 0,
        activitiesJoined: 0,
        completionRate: 0,
      },
      achievements: [],
      certificates: [],
    });
    return user;
  }

  async findByEmail(email: string) {
    const users = await this.firebaseService.queryCollection(
      this.collectionName,
      'email',
      '==',
      email,
    );
    return users.length > 0 ? users[0] : null;
  }

  async findById(id: string) {
    const user = await this.firebaseService.getDocument(this.collectionName, id);
    if (!user) {
      throw new NotFoundException('المستخدم غير موجود');
    }
    // Remove password from response
    const { password, ...userWithoutPassword } = user;
    return userWithoutPassword;
  }

  async update(id: string, updateData: any) {
    const user = await this.firebaseService.updateDocument(
      this.collectionName,
      id,
      updateData,
    );
    const { password, ...userWithoutPassword } = user;
    return userWithoutPassword;
  }

  async updateStatistics(userId: string, statistics: any) {
    return this.update(userId, { statistics });
  }
}
