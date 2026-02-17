# 🎓 Elite Engineering Gathering - Full Stack Project

مشروع متكامل لإدارة الأنشطة والمهام للمهندسين النخبة

---

## 📋 نظرة عامة

هذا المشروع يتكون من جزئين رئيسيين:

### 1. Frontend - Flutter App
تطبيق متعدد المنصات (Android, iOS, Web, Desktop) مبني بـ Flutter

### 2. Backend - NestJS API
Backend API كامل مبني بـ NestJS مع Firebase Firestore

---

## 🏗️ بنية المشروع

```
my_test_app/
├── lib/                          # Flutter App
│   ├── main.dart                 # الشاشة الرئيسية
│   ├── tasks_screen.dart         # شاشة المهام
│   ├── profile_settings.dart     # الملف الشخصي
│   ├── services/
│   │   └── api_service.dart      # خدمات API
│   └── models/
│       └── models.dart           # نماذج البيانات
│
├── backend-api/                  # NestJS Backend
│   ├── src/
│   │   ├── auth/                 # Authentication
│   │   ├── users/                # إدارة المستخدمين
│   │   ├── activities/           # إدارة الأنشطة
│   │   ├── tasks/                # إدارة المهام
│   │   ├── announcements/        # الإعلانات
│   │   ├── events/               # الفعاليات
│   │   ├── firebase/             # Firebase Integration
│   │   └── seed/                 # بيانات تجريبية
│   ├── package.json
│   └── README.md
│
├── README.md                     # Flutter App README
├── BACKEND_INTEGRATION.md        # دليل ربط Backend
├── FLUTTER_INTEGRATION.md        # دليل ربط Flutter
└── PROJECT_OVERVIEW.md           # هذا الملف
```

---

## ✨ المميزات

### Frontend (Flutter)
- ✅ واجهة مستخدم عصرية وسهلة الاستخدام
- ✅ دعم اللغة العربية (RTL)
- ✅ إدارة الأنشطة والتسجيل فيها
- ✅ إدارة المهام الشخصية
- ✅ الملف الشخصي والإعدادات
- ✅ الإعلانات والفعاليات
- ✅ متعدد المنصات (Android, iOS, Web, Desktop)

### Backend (NestJS)
- ✅ RESTful API كامل
- ✅ Authentication مع JWT
- ✅ Firebase Firestore Integration
- ✅ Validation & Error Handling
- ✅ CORS Support
- ✅ بيانات تجريبية جاهزة
- ✅ Docker Support

---

## 🚀 البدء السريع

### المتطلبات
- Node.js (18+)
- Flutter SDK (3.11.0+)
- Firebase Account
- Git

### 1️⃣ تشغيل Backend

```bash
# الانتقال لمجلد Backend
cd backend-api

# تثبيت المكتبات
npm install

# إعداد Firebase (راجع backend-api/SETUP_GUIDE.md)
# انسخ .env.example إلى .env وأضف بيانات Firebase

# تشغيل السيرفر
npm run start:dev

# إضافة بيانات تجريبية
curl -X POST http://localhost:3000/api/seed
```

السيرفر يعمل على: http://localhost:3000/api

### 2️⃣ تشغيل Flutter App

```bash
# العودة للمجلد الرئيسي
cd ..

# تثبيت المكتبات
flutter pub get

# تحديث عنوان API في lib/services/api_service.dart
# baseUrl = 'http://localhost:3000/api'

# تشغيل التطبيق
flutter run
```

---

## 📚 التوثيق

### Backend Documentation
- [دليل الإعداد الكامل](./backend-api/SETUP_GUIDE.md)
- [البدء السريع](./backend-api/QUICK_START.md)
- [توثيق API](./backend-api/README.md)
- [Postman Collection](./backend-api/postman-collection.json)

### Flutter Documentation
- [README الرئيسي](./README.md)
- [دليل ربط Backend](./BACKEND_INTEGRATION.md)
- [دليل ربط Flutter](./FLUTTER_INTEGRATION.md)

---

## 🔑 بيانات الدخول التجريبية

بعد تشغيل Seed في Backend:

**Admin:**
- Email: `ahmed@example.com`
- Password: `123456`

**Member:**
- Email: `fatima@example.com`
- Password: `123456`

---

## 🛠️ التقنيات المستخدمة

### Frontend
- **Flutter** - Framework
- **Dart** - اللغة البرمجية
- **HTTP** - للاتصال بالـ API
- **Provider** - إدارة الحالة
- **SharedPreferences** - التخزين المحلي

### Backend
- **NestJS** - Framework
- **TypeScript** - اللغة البرمجية
- **Firebase Firestore** - قاعدة البيانات
- **JWT** - Authentication
- **Passport** - Authentication Strategy
- **Bcrypt** - Password Hashing
- **Class Validator** - Validation

---

## 📊 API Endpoints

### Authentication
- `POST /api/auth/register` - تسجيل مستخدم جديد
- `POST /api/auth/login` - تسجيل الدخول
- `GET /api/auth/profile` - الملف الشخصي
- `POST /api/auth/logout` - تسجيل الخروج

### Users
- `GET /api/users/profile` - الحصول على الملف الشخصي
- `PUT /api/users/profile` - تحديث الملف الشخصي
- `GET /api/users/:id` - الحصول على مستخدم

### Activities
- `GET /api/activities` - جميع الأنشطة
- `GET /api/activities/my-activities` - أنشطتي
- `POST /api/activities` - إنشاء نشاط
- `POST /api/activities/:id/register` - التسجيل في نشاط
- `PUT /api/activities/:id` - تحديث نشاط
- `DELETE /api/activities/:id` - حذف نشاط

### Tasks
- `GET /api/tasks` - جميع المهام
- `GET /api/tasks/statistics` - إحصائيات المهام
- `POST /api/tasks` - إنشاء مهمة
- `PUT /api/tasks/:id` - تحديث مهمة
- `DELETE /api/tasks/:id` - حذف مهمة

### Announcements
- `GET /api/announcements` - جميع الإعلانات
- `GET /api/announcements/recent` - آخر الإعلانات
- `POST /api/announcements` - إنشاء إعلان

### Events
- `GET /api/events` - جميع الفعاليات
- `GET /api/events/upcoming` - الفعاليات القادمة
- `POST /api/events` - إنشاء فعالية

---

## 🗄️ قاعدة البيانات (Firebase Collections)

- **users** - بيانات المستخدمين
- **activities** - الأنشطة
- **activity_registrations** - تسجيلات الأنشطة
- **tasks** - المهام
- **announcements** - الإعلانات
- **events** - الفعاليات

---

## 🧪 الاختبار

### Backend Testing
```bash
cd backend-api

# Unit tests
npm run test

# E2E tests
npm run test:e2e

# Test coverage
npm run test:cov
```

### Flutter Testing
```bash
# Unit tests
flutter test

# Integration tests
flutter test integration_test
```

---

## 🐳 Docker Deployment

### Backend
```bash
cd backend-api

# Build image
docker build -t elite-engineering-api .

# Run container
docker-compose up -d
```

---

## 🔧 التطوير

### إضافة ميزة جديدة في Backend

1. أنشئ Module جديد:
```bash
cd backend-api
nest g module feature-name
nest g controller feature-name
nest g service feature-name
```

2. أضف الـ DTOs في `src/feature-name/dto/`
3. أضف الـ Module إلى `app.module.ts`

### إضافة شاشة جديدة في Flutter

1. أنشئ ملف جديد في `lib/`
2. أضف الـ Route في `main.dart`
3. أضف الـ Service في `lib/services/`

---

## 📱 المنصات المدعومة

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

---

## 🎯 الميزات القادمة

- [ ] Push Notifications
- [ ] Real-time Chat
- [ ] File Sharing
- [ ] Advanced Analytics
- [ ] Dark Mode
- [ ] Multi-language Support
- [ ] Offline Mode
- [ ] Social Features

---

## 🤝 المساهمة

نرحب بالمساهمات! يرجى:

1. Fork المشروع
2. إنشاء Branch جديد (`git checkout -b feature/amazing-feature`)
3. Commit التغييرات (`git commit -m 'Add amazing feature'`)
4. Push إلى Branch (`git push origin feature/amazing-feature`)
5. فتح Pull Request

---

## 📞 الدعم

للمساعدة أو الاستفسارات:
- Email: support@elite-engineering.com
- Website: www.elite-engineering.com

---

## 📄 الترخيص

هذا المشروع مملوك لـ Elite Engineering Gathering.

---

## 👥 الفريق

- **Frontend Development**: Flutter Team
- **Backend Development**: NestJS Team
- **UI/UX Design**: Design Team
- **Project Management**: PM Team

---

## 🙏 شكر وتقدير

شكراً لجميع المساهمين في هذا المشروع!

---

**تم التطوير بـ ❤️ بواسطة Elite Engineering Team**

---

## 📸 لقطات الشاشة

(يمكن إضافة لقطات الشاشة هنا)

---

## 🔗 روابط مفيدة

- [Flutter Documentation](https://flutter.dev/docs)
- [NestJS Documentation](https://docs.nestjs.com/)
- [Firebase Documentation](https://firebase.google.com/docs)
- [TypeScript Documentation](https://www.typescriptlang.org/docs/)
- [Dart Documentation](https://dart.dev/guides)
