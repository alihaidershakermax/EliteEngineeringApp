# 🚀 Elite Engineering Gathering - Backend API

Backend API كامل مبني بـ NestJS مع Firebase Firestore كقاعدة بيانات.

## 📋 المميزات

- ✅ Authentication مع JWT
- ✅ إدارة المستخدمين
- ✅ إدارة الأنشطة والتسجيل فيها
- ✅ إدارة المهام الشخصية
- ✅ الإعلانات والفعاليات
- ✅ Firebase Firestore Integration
- ✅ Validation & Error Handling
- ✅ CORS Support

## 🛠️ التقنيات المستخدمة

- **NestJS** - Framework
- **TypeScript** - اللغة البرمجية
- **Firebase Admin SDK** - قاعدة البيانات
- **JWT** - Authentication
- **Passport** - Authentication Strategy
- **Class Validator** - Validation
- **Bcrypt** - Password Hashing

## 📦 التثبيت

### 1. تثبيت المكتبات

```bash
cd backend-api
npm install
```

### 2. إعداد Firebase

1. اذهب إلى [Firebase Console](https://console.firebase.google.com/)
2. أنشئ مشروع جديد أو استخدم مشروع موجود
3. اذهب إلى Project Settings > Service Accounts
4. اضغط على "Generate New Private Key"
5. احفظ الملف باسم `firebase-adminsdk.json` في مجلد `backend-api`

### 3. إعداد المتغيرات البيئية

انسخ ملف `.env.example` إلى `.env`:

```bash
copy .env.example .env
```

ثم قم بتعديل الملف `.env`:

```env
# Firebase Configuration
FIREBASE_PROJECT_ID=your-project-id
FIREBASE_PRIVATE_KEY="-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----\n"
FIREBASE_CLIENT_EMAIL=firebase-adminsdk-xxxxx@your-project.iam.gserviceaccount.com

# JWT Configuration
JWT_SECRET=your-super-secret-jwt-key-change-this-in-production
JWT_EXPIRATION=7d

# Server Configuration
PORT=3000
NODE_ENV=development

# CORS Configuration
CORS_ORIGIN=http://localhost:3000,http://localhost:8080
```

## 🚀 التشغيل

### Development Mode

```bash
npm run start:dev
```

### Production Mode

```bash
npm run build
npm run start:prod
```

السيرفر سيعمل على: `http://localhost:3000/api`

## 📚 API Endpoints

### Authentication

#### تسجيل مستخدم جديد
```http
POST /api/auth/register
Content-Type: application/json

{
  "name": "أحمد محمد",
  "email": "ahmed@example.com",
  "password": "123456",
  "phone": "0501234567"
}
```

#### تسجيل الدخول
```http
POST /api/auth/login
Content-Type: application/json

{
  "email": "ahmed@example.com",
  "password": "123456"
}
```

#### الحصول على الملف الشخصي
```http
GET /api/auth/profile
Authorization: Bearer {token}
```

#### تسجيل الخروج
```http
POST /api/auth/logout
Authorization: Bearer {token}
```

---

### Users

#### الحصول على الملف الشخصي
```http
GET /api/users/profile
Authorization: Bearer {token}
```

#### تحديث الملف الشخصي
```http
PUT /api/users/profile
Authorization: Bearer {token}
Content-Type: application/json

{
  "name": "أحمد محمد الجديد",
  "phone": "0509876543",
  "bio": "مهندس برمجيات"
}
```

#### الحصول على مستخدم بالـ ID
```http
GET /api/users/:id
Authorization: Bearer {token}
```

---

### Activities

#### الحصول على جميع الأنشطة
```http
GET /api/activities
```

#### الحصول على الأنشطة حسب الفئة
```http
GET /api/activities?category=ورشة عمل
```

#### الحصول على أنشطتي
```http
GET /api/activities/my-activities
Authorization: Bearer {token}
```

#### الحصول على نشاط محدد
```http
GET /api/activities/:id
```

#### إنشاء نشاط جديد
```http
POST /api/activities
Authorization: Bearer {token}
Content-Type: application/json

{
  "title": "ورشة عمل Flutter",
  "description": "تعلم أساسيات Flutter",
  "category": "ورشة عمل",
  "date": "2024-12-25",
  "time": "10:00 صباحاً",
  "location": "قاعة المؤتمرات",
  "instructor": "م. أحمد",
  "maxParticipants": 30
}
```

#### التسجيل في نشاط
```http
POST /api/activities/:id/register
Authorization: Bearer {token}
Content-Type: application/json

{
  "notes": "متحمس للمشاركة"
}
```

#### تحديث نشاط
```http
PUT /api/activities/:id
Authorization: Bearer {token}
Content-Type: application/json

{
  "title": "ورشة عمل Flutter المتقدمة"
}
```

#### حذف نشاط
```http
DELETE /api/activities/:id
Authorization: Bearer {token}
```

---

### Tasks

#### الحصول على جميع المهام
```http
GET /api/tasks
Authorization: Bearer {token}
```

#### الحصول على المهام حسب الحالة
```http
GET /api/tasks?status=نشطة
```

#### الحصول على إحصائيات المهام
```http
GET /api/tasks/statistics
Authorization: Bearer {token}
```

#### الحصول على مهمة محددة
```http
GET /api/tasks/:id
Authorization: Bearer {token}
```

#### إنشاء مهمة جديدة
```http
POST /api/tasks
Authorization: Bearer {token}
Content-Type: application/json

{
  "title": "إنهاء المشروع",
  "description": "إكمال جميع المتطلبات",
  "priority": "عالية",
  "dueDate": "2024-12-31",
  "progress": 0
}
```

#### تحديث مهمة
```http
PUT /api/tasks/:id
Authorization: Bearer {token}
Content-Type: application/json

{
  "progress": 50,
  "status": "نشطة"
}
```

#### حذف مهمة
```http
DELETE /api/tasks/:id
Authorization: Bearer {token}
```

---

### Announcements

#### الحصول على جميع الإعلانات
```http
GET /api/announcements
```

#### الحصول على آخر الإعلانات
```http
GET /api/announcements/recent
```

#### الحصول على إعلان محدد
```http
GET /api/announcements/:id
```

#### إنشاء إعلان جديد
```http
POST /api/announcements
Authorization: Bearer {token}
Content-Type: application/json

{
  "title": "إعلان مهم",
  "content": "محتوى الإعلان",
  "type": "عام",
  "author": "الإدارة"
}
```

#### تحديث إعلان
```http
PUT /api/announcements/:id
Authorization: Bearer {token}
```

#### حذف إعلان
```http
DELETE /api/announcements/:id
Authorization: Bearer {token}
```

---

### Events

#### الحصول على جميع الفعاليات
```http
GET /api/events
```

#### الحصول على الفعاليات القادمة
```http
GET /api/events/upcoming
```

#### الحصول على فعالية محددة
```http
GET /api/events/:id
```

#### إنشاء فعالية جديدة
```http
POST /api/events
Authorization: Bearer {token}
Content-Type: application/json

{
  "title": "مؤتمر المهندسين",
  "description": "مؤتمر سنوي للمهندسين",
  "date": "2024-12-20",
  "time": "9:00 صباحاً",
  "location": "مركز المؤتمرات",
  "organizer": "تجمع المهندسين النخبة"
}
```

#### تحديث فعالية
```http
PUT /api/events/:id
Authorization: Bearer {token}
```

#### حذف فعالية
```http
DELETE /api/events/:id
Authorization: Bearer {token}
```

---

## 🗄️ هيكل قاعدة البيانات (Firebase Collections)

### users
```json
{
  "id": "auto-generated",
  "name": "string",
  "email": "string",
  "password": "hashed-string",
  "phone": "string",
  "role": "string",
  "avatar": "string",
  "bio": "string",
  "committees": ["array"],
  "projects": ["array"],
  "statistics": {
    "tasksCompleted": "number",
    "activitiesJoined": "number",
    "completionRate": "number"
  },
  "achievements": ["array"],
  "certificates": ["array"],
  "createdAt": "timestamp",
  "updatedAt": "timestamp"
}
```

### activities
```json
{
  "id": "auto-generated",
  "title": "string",
  "description": "string",
  "category": "string",
  "date": "string",
  "time": "string",
  "location": "string",
  "instructor": "string",
  "maxParticipants": "number",
  "participants": "number",
  "image": "string",
  "createdAt": "timestamp",
  "updatedAt": "timestamp"
}
```

### tasks
```json
{
  "id": "auto-generated",
  "userId": "string",
  "title": "string",
  "description": "string",
  "priority": "string",
  "dueDate": "string",
  "progress": "number",
  "status": "string",
  "category": "string",
  "createdAt": "timestamp",
  "updatedAt": "timestamp"
}
```

### announcements
```json
{
  "id": "auto-generated",
  "title": "string",
  "content": "string",
  "type": "string",
  "image": "string",
  "author": "string",
  "views": "number",
  "createdAt": "timestamp",
  "updatedAt": "timestamp"
}
```

### events
```json
{
  "id": "auto-generated",
  "title": "string",
  "description": "string",
  "date": "string",
  "time": "string",
  "location": "string",
  "image": "string",
  "organizer": "string",
  "createdAt": "timestamp",
  "updatedAt": "timestamp"
}
```

### activity_registrations
```json
{
  "id": "auto-generated",
  "activityId": "string",
  "userId": "string",
  "notes": "string",
  "status": "string",
  "createdAt": "timestamp",
  "updatedAt": "timestamp"
}
```

## 🔐 Authentication

جميع الـ endpoints المحمية تحتاج إلى JWT Token في الـ Header:

```http
Authorization: Bearer {your-jwt-token}
```

## 🧪 الاختبار

```bash
# Unit tests
npm run test

# E2E tests
npm run test:e2e

# Test coverage
npm run test:cov
```

## 📝 ملاحظات مهمة

1. تأكد من إعداد Firebase بشكل صحيح
2. غيّر `JWT_SECRET` في الـ production
3. قم بتفعيل Firestore في Firebase Console
4. تأكد من إعداد CORS بشكل صحيح

## 🔄 ربط مع Flutter App

في تطبيق Flutter، قم بتحديث `baseUrl` في `api_service.dart`:

```dart
static const String baseUrl = 'http://localhost:3000/api';
// أو في Production
static const String baseUrl = 'https://your-domain.com/api';
```

## 📞 الدعم

للمساعدة أو الاستفسارات، يرجى التواصل مع فريق التطوير.

## 📄 الترخيص

هذا المشروع مملوك لـ Elite Engineering Gathering.

---

**تم التطوير بـ ❤️ بواسطة Elite Engineering Team**
