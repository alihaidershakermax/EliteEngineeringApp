# 🚀 دليل الإعداد السريع - Elite Engineering API

## خطوات الإعداد

### 1️⃣ تثبيت Node.js

تأكد من تثبيت Node.js (الإصدار 18 أو أحدث):

```bash
node --version
npm --version
```

إذا لم يكن مثبتاً، قم بتحميله من: https://nodejs.org/

---

### 2️⃣ تثبيت المكتبات

```bash
cd backend-api
npm install
```

---

### 3️⃣ إعداد Firebase

#### أ. إنشاء مشروع Firebase

1. اذهب إلى [Firebase Console](https://console.firebase.google.com/)
2. اضغط على "Add project" أو "إضافة مشروع"
3. أدخل اسم المشروع (مثل: elite-engineering)
4. اتبع الخطوات حتى يتم إنشاء المشروع

#### ب. تفعيل Firestore Database

1. من القائمة الجانبية، اختر "Firestore Database"
2. اضغط على "Create database"
3. اختر "Start in test mode" (للتطوير)
4. اختر الموقع الجغرافي الأقرب لك

#### ج. الحصول على Service Account Key

1. اذهب إلى Project Settings (⚙️ أعلى اليسار)
2. اختر تبويب "Service accounts"
3. اضغط على "Generate new private key"
4. سيتم تحميل ملف JSON
5. احفظ الملف في مجلد `backend-api` باسم `firebase-adminsdk.json`

⚠️ **مهم جداً:** لا تشارك هذا الملف مع أحد ولا ترفعه على Git!

---

### 4️⃣ إعداد ملف .env

انسخ ملف `.env.example` إلى `.env`:

```bash
copy .env.example .env
```

افتح ملف `firebase-adminsdk.json` وانسخ القيم التالية إلى `.env`:

```env
# من ملف firebase-adminsdk.json
FIREBASE_PROJECT_ID=your-project-id
FIREBASE_CLIENT_EMAIL=firebase-adminsdk-xxxxx@your-project.iam.gserviceaccount.com
FIREBASE_PRIVATE_KEY="-----BEGIN PRIVATE KEY-----\nYour-Private-Key-Here\n-----END PRIVATE KEY-----\n"

# قم بتوليد JWT Secret عشوائي
JWT_SECRET=your-super-secret-jwt-key-change-this-in-production
JWT_EXPIRATION=7d

# إعدادات السيرفر
PORT=3000
NODE_ENV=development

# CORS - عناوين التطبيقات المسموح لها بالوصول
CORS_ORIGIN=http://localhost:3000,http://localhost:8080
```

#### كيفية نسخ Private Key:

افتح `firebase-adminsdk.json` وانسخ قيمة `private_key` كاملة (مع علامات الاقتباس والـ \n).

مثال:
```json
{
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC...\n-----END PRIVATE KEY-----\n"
}
```

---

### 5️⃣ تشغيل السيرفر

#### Development Mode (مع Hot Reload)

```bash
npm run start:dev
```

#### Production Mode

```bash
npm run build
npm run start:prod
```

السيرفر سيعمل على: **http://localhost:3000/api**

---

### 6️⃣ اختبار API

#### أ. باستخدام المتصفح

افتح: http://localhost:3000/api

يجب أن ترى رسالة الترحيب:
```json
{
  "message": "Welcome to Elite Engineering Gathering API",
  "version": "1.0.0",
  "endpoints": {
    "auth": "/api/auth",
    "users": "/api/users",
    "activities": "/api/activities",
    "tasks": "/api/tasks",
    "announcements": "/api/announcements",
    "events": "/api/events"
  }
}
```

#### ب. باستخدام Postman

1. افتح Postman
2. اذهب إلى File > Import
3. اختر ملف `postman-collection.json`
4. ستجد جميع الـ endpoints جاهزة للاختبار

#### ج. اختبار التسجيل

```bash
curl -X POST http://localhost:3000/api/auth/register \
  -H "Content-Type: application/json" \
  -d "{\"name\":\"أحمد محمد\",\"email\":\"ahmed@example.com\",\"password\":\"123456\",\"phone\":\"0501234567\"}"
```

---

### 7️⃣ ربط مع Flutter App

في تطبيق Flutter، افتح ملف `lib/services/api_service.dart` وحدّث:

```dart
static const String baseUrl = 'http://localhost:3000/api';
```

إذا كنت تختبر على جهاز حقيقي، استخدم IP الجهاز:

```dart
static const String baseUrl = 'http://192.168.1.100:3000/api';
```

لمعرفة IP جهازك:

**Windows:**
```bash
ipconfig
```

**Mac/Linux:**
```bash
ifconfig
```

---

## 🔧 حل المشاكل الشائعة

### مشكلة: Firebase Authentication Error

**الحل:**
- تأكد من صحة بيانات Firebase في `.env`
- تأكد من وجود ملف `firebase-adminsdk.json`
- تأكد من تفعيل Firestore في Firebase Console

### مشكلة: Port 3000 is already in use

**الحل:**
- غيّر PORT في `.env` إلى رقم آخر (مثل 3001)
- أو أوقف البرنامج الذي يستخدم Port 3000

**Windows:**
```bash
netstat -ano | findstr :3000
taskkill /PID <PID> /F
```

### مشكلة: CORS Error

**الحل:**
- أضف عنوان تطبيق Flutter إلى `CORS_ORIGIN` في `.env`

```env
CORS_ORIGIN=http://localhost:3000,http://localhost:8080,http://192.168.1.100:8080
```

---

## 📱 الخطوات التالية

1. ✅ قم بإنشاء بعض البيانات التجريبية
2. ✅ اختبر جميع الـ endpoints
3. ✅ ربط Flutter App مع API
4. ✅ اختبر التطبيق كاملاً

---

## 🎯 نصائح مهمة

1. **للتطوير:** استخدم `npm run start:dev` للحصول على Hot Reload
2. **للإنتاج:** استخدم `npm run build` ثم `npm run start:prod`
3. **الأمان:** غيّر `JWT_SECRET` في الإنتاج إلى قيمة عشوائية قوية
4. **Firebase Rules:** في الإنتاج، غيّر Firestore rules من test mode إلى production mode

---

## 📞 الدعم

إذا واجهت أي مشكلة، تواصل مع فريق التطوير.

---

**تم التطوير بـ ❤️ بواسطة Elite Engineering Team**
