# ⚡ البدء السريع - Elite Engineering API

## 🎯 خطوات سريعة للتشغيل

### 1. تثبيت المكتبات
```bash
cd backend-api
npm install
```

### 2. إعداد Firebase
- أنشئ مشروع في [Firebase Console](https://console.firebase.google.com/)
- فعّل Firestore Database
- حمّل Service Account Key واحفظه كـ `firebase-adminsdk.json`

### 3. إعداد البيئة
```bash
copy .env.example .env
```

عدّل `.env` بمعلومات Firebase الخاصة بك.

### 4. تشغيل السيرفر
```bash
npm run start:dev
```

السيرفر يعمل على: http://localhost:3000/api

### 5. إضافة بيانات تجريبية
```bash
curl -X POST http://localhost:3000/api/seed
```

أو افتح في المتصفح: http://localhost:3000/api/seed

---

## 🧪 اختبار سريع

### تسجيل مستخدم جديد
```bash
curl -X POST http://localhost:3000/api/auth/register \
  -H "Content-Type: application/json" \
  -d "{\"name\":\"Test User\",\"email\":\"test@example.com\",\"password\":\"123456\"}"
```

### تسجيل الدخول
```bash
curl -X POST http://localhost:3000/api/auth/login \
  -H "Content-Type: application/json" \
  -d "{\"email\":\"ahmed@example.com\",\"password\":\"123456\"}"
```

احفظ الـ `token` من الاستجابة واستخدمه في الطلبات التالية.

### الحصول على الأنشطة
```bash
curl http://localhost:3000/api/activities
```

---

## 📱 ربط مع Flutter

في `lib/services/api_service.dart`:

```dart
static const String baseUrl = 'http://localhost:3000/api';
```

للاختبار على جهاز حقيقي، استخدم IP جهازك:

```dart
static const String baseUrl = 'http://192.168.1.100:3000/api';
```

---

## 🔑 بيانات الدخول التجريبية

بعد تشغيل Seed:

**Admin:**
- Email: `ahmed@example.com`
- Password: `123456`

**Member:**
- Email: `fatima@example.com`
- Password: `123456`

---

## 📚 المزيد من التفاصيل

- [دليل الإعداد الكامل](./SETUP_GUIDE.md)
- [توثيق API](./README.md)
- [Postman Collection](./postman-collection.json)

---

**تم التطوير بـ ❤️ بواسطة Elite Engineering Team**
