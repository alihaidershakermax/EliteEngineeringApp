import { Injectable } from '@nestjs/common';
import { FirebaseService } from '../firebase/firebase.service';
import * as bcrypt from 'bcrypt';

@Injectable()
export class SeedService {
  constructor(private firebaseService: FirebaseService) {}

  async seedAll() {
    console.log('🌱 بدء إضافة البيانات التجريبية...');

    await this.seedUsers();
    await this.seedActivities();
    await this.seedAnnouncements();
    await this.seedEvents();

    console.log('✅ تم إضافة جميع البيانات التجريبية بنجاح!');
  }

  private async seedUsers() {
    console.log('👥 إضافة المستخدمين...');

    const users = [
      {
        name: 'أحمد محمد',
        email: 'ahmed@example.com',
        password: await bcrypt.hash('123456', 10),
        phone: '0501234567',
        role: 'admin',
        avatar: '',
        bio: 'مهندس برمجيات ومطور تطبيقات',
        committees: ['اللجنة التقنية', 'لجنة التطوير'],
        projects: ['مشروع التطبيق', 'مشروع الموقع'],
        statistics: {
          tasksCompleted: 15,
          activitiesJoined: 8,
          completionRate: 92,
        },
        achievements: ['أفضل مطور', 'مشارك نشط'],
        certificates: ['شهادة Flutter', 'شهادة NestJS'],
      },
      {
        name: 'فاطمة علي',
        email: 'fatima@example.com',
        password: await bcrypt.hash('123456', 10),
        phone: '0509876543',
        role: 'member',
        avatar: '',
        bio: 'مهندسة تصميم UI/UX',
        committees: ['لجنة التصميم'],
        projects: ['مشروع التطبيق'],
        statistics: {
          tasksCompleted: 10,
          activitiesJoined: 5,
          completionRate: 85,
        },
        achievements: ['مصممة متميزة'],
        certificates: ['شهادة Figma'],
      },
    ];

    for (const user of users) {
      await this.firebaseService.createDocument('users', user);
    }

    console.log(`✅ تم إضافة ${users.length} مستخدم`);
  }

  private async seedActivities() {
    console.log('🎯 إضافة الأنشطة...');

    const activities = [
      {
        title: 'ورشة عمل Flutter المتقدمة',
        description: 'تعلم تقنيات Flutter المتقدمة وبناء تطبيقات احترافية',
        category: 'ورشة عمل',
        date: '2024-12-25',
        time: '10:00 صباحاً',
        location: 'قاعة المؤتمرات - الدور الثاني',
        instructor: 'م. أحمد محمد',
        maxParticipants: 30,
        participants: 15,
        image: '',
      },
      {
        title: 'ندوة الذكاء الاصطناعي',
        description: 'مستقبل الذكاء الاصطناعي وتطبيقاته في الهندسة',
        category: 'ندوة',
        date: '2024-12-20',
        time: '6:00 مساءً',
        location: 'القاعة الكبرى',
        instructor: 'د. محمد السعيد',
        maxParticipants: 100,
        participants: 45,
        image: '',
      },
      {
        title: 'دورة تطوير الويب الشاملة',
        description: 'دورة كاملة في تطوير تطبيقات الويب باستخدام React و Node.js',
        category: 'دورة',
        date: '2025-01-05',
        time: '4:00 مساءً',
        location: 'معمل الحاسوب',
        instructor: 'م. سارة أحمد',
        maxParticipants: 25,
        participants: 20,
        image: '',
      },
      {
        title: 'مؤتمر المهندسين السنوي',
        description: 'المؤتمر السنوي لتجمع المهندسين النخبة',
        category: 'مؤتمر',
        date: '2025-02-15',
        time: '9:00 صباحاً',
        location: 'مركز المؤتمرات الدولي',
        instructor: 'فريق التنظيم',
        maxParticipants: 200,
        participants: 120,
        image: '',
      },
    ];

    for (const activity of activities) {
      await this.firebaseService.createDocument('activities', activity);
    }

    console.log(`✅ تم إضافة ${activities.length} نشاط`);
  }

  private async seedAnnouncements() {
    console.log('📢 إضافة الإعلانات...');

    const announcements = [
      {
        title: 'افتتاح التسجيل في الأنشطة الجديدة',
        content:
          'يسرنا أن نعلن عن افتتاح التسجيل في مجموعة من الأنشطة والورش الجديدة. سارعوا بالتسجيل قبل امتلاء المقاعد!',
        type: 'عام',
        author: 'الإدارة',
        views: 0,
        image: '',
      },
      {
        title: 'تحديث مهم في التطبيق',
        content:
          'تم إطلاق تحديث جديد للتطبيق يتضمن مميزات جديدة وتحسينات في الأداء. يرجى تحديث التطبيق للحصول على أفضل تجربة.',
        type: 'تقني',
        author: 'فريق التطوير',
        views: 0,
        image: '',
      },
      {
        title: 'موعد الاجتماع الشهري',
        content:
          'يعقد الاجتماع الشهري للأعضاء يوم الخميس القادم الساعة 7 مساءً في القاعة الرئيسية. حضوركم مهم!',
        type: 'اجتماع',
        author: 'الإدارة',
        views: 0,
        image: '',
      },
    ];

    for (const announcement of announcements) {
      await this.firebaseService.createDocument('announcements', announcement);
    }

    console.log(`✅ تم إضافة ${announcements.length} إعلان`);
  }

  private async seedEvents() {
    console.log('📅 إضافة الفعاليات...');

    const events = [
      {
        title: 'يوم المهندس المفتوح',
        description: 'يوم مفتوح للتعريف بالتجمع وأنشطته',
        date: '2024-12-30',
        time: '10:00 صباحاً',
        location: 'الحديقة العامة',
        organizer: 'تجمع المهندسين النخبة',
        image: '',
      },
      {
        title: 'معرض المشاريع الهندسية',
        description: 'معرض لعرض مشاريع الأعضاء وإنجازاتهم',
        date: '2025-01-15',
        time: '2:00 مساءً',
        location: 'قاعة المعارض',
        organizer: 'لجنة المشاريع',
        image: '',
      },
      {
        title: 'حفل التخرج السنوي',
        description: 'حفل تكريم الخريجين والمتميزين',
        date: '2025-03-01',
        time: '6:00 مساءً',
        location: 'قاعة الاحتفالات الكبرى',
        organizer: 'الإدارة',
        image: '',
      },
    ];

    for (const event of events) {
      await this.firebaseService.createDocument('events', event);
    }

    console.log(`✅ تم إضافة ${events.length} فعالية`);
  }
}
