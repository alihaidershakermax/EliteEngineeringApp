# Elite Engineering Gathering App - Backend Integration Guide

## 📋 نظرة عامة

هذا التطبيق جاهز للربط مع Backend API. جميع الخدمات والنماذج موجودة في المجلدات التالية:

```
lib/
├── services/
│   └── api_service.dart    # جميع خدمات API
├── models/
│   └── models.dart          # نماذج البيانات
├── main.dart                # الشاشة الرئيسية
├── tasks_screen.dart        # شاشة المهام
└── profile_settings.dart    # شاشة الملف الشخصي والإعدادات
```

## 🔧 خطوات الربط مع Backend

### 1. تثبيت المكتبات المطلوبة

أضف هذه المكتبات إلى `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0              # للاتصال بالـ API
  shared_preferences: ^2.2.2 # لحفظ البيانات محلياً
  provider: ^6.1.1          # لإدارة الحالة
```

ثم نفذ الأمر:
```bash
flutter pub get
```

### 2. تحديث عنوان API

في ملف `lib/services/api_service.dart`، قم بتحديث:

```dart
static const String baseUrl = 'https://your-api-url.com/api';
```

إلى عنوان السيرفر الخاص بك.

### 3. تفعيل HTTP Requests

في ملف `api_service.dart`، قم بإلغاء التعليق عن الكود الموجود في الدوال:
- `get()`
- `post()`
- `put()`
- `delete()`

وأضف:
```dart
import 'package:http/http.dart' as http;
import 'dart:convert';
```

### 4. مثال على استخدام الخدمات

#### تسجيل الدخول:
```dart
import 'package:my_test_app/services/api_service.dart';

// في الدالة
bool success = await AuthService.login('email@example.com', 'password');
if (success) {
  // تم تسجيل الدخول بنجاح
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainScreen()));
}
```

#### جلب الأنشطة:
```dart
List<Map<String, dynamic>> activities = await ActivitiesService.getActivities();
```

#### إنشاء مهمة جديدة:
```dart
bool success = await TasksService.createTask({
  'title': 'مهمة جديدة',
  'description': 'وصف المهمة',
  'priority': 'عالية',
  'due_date': '2024-12-31',
});
```

## 📊 API Endpoints المطلوبة

### Authentication
- `POST /api/auth/login` - تسجيل الدخول
- `POST /api/auth/register` - التسجيل
- `POST /api/auth/logout` - تسجيل الخروج

### User
- `GET /api/user/profile` - جلب الملف الشخصي
- `PUT /api/user/update` - تحديث الملف الشخصي

### Activities
- `GET /api/activities` - جلب جميع الأنشطة
- `GET /api/activities/:id` - جلب تفاصيل نشاط
- `POST /api/activities/register` - التسجيل في نشاط

### Tasks
- `GET /api/tasks` - جلب جميع المهام
- `POST /api/tasks/create` - إنشاء مهمة جديدة
- `PUT /api/tasks/update/:id` - تحديث مهمة
- `DELETE /api/tasks/delete/:id` - حذف مهمة

### Announcements
- `GET /api/announcements` - جلب جميع الإعلانات

### Events
- `GET /api/events` - جلب جميع الفعاليات

## 🔐 Authentication Headers

جميع الطلبات المحمية يجب أن تحتوي على:

```dart
headers: {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer ${AuthService.getToken()}',
}
```

## 📝 نماذج البيانات (Models)

جميع النماذج موجودة في `lib/models/models.dart`:

- `User` - بيانات المستخدم
- `Activity` - بيانات النشاط
- `Task` - بيانات المهمة
- `Announcement` - بيانات الإعلان
- `Event` - بيانات الفعالية
- `Statistics` - الإحصائيات

### مثال على استخدام النماذج:

```dart
// تحويل JSON إلى Object
Activity activity = Activity.fromJson(jsonData);

// تحويل Object إلى JSON
Map<String, dynamic> json = activity.toJson();
```

## 🎨 الشاشات المتوفرة

1. **HomeScreen** - الشاشة الرئيسية
   - عرض الإعلانات
   - عرض الفعاليات القادمة
   - إحصائيات سريعة

2. **ActivitiesScreen** - شاشة الأنشطة
   - عرض جميع الأنشطة
   - تصنيف الأنشطة
   - التسجيل في الأنشطة

3. **TasksScreen** - شاشة المهام
   - عرض المهام
   - إنشاء مهام جديدة
   - تحديث حالة المهام

4. **ProfileScreen** - الملف الشخصي والإعدادات
   - عرض بيانات المستخدم
   - الإعدادات
   - تسجيل الخروج

## 🚀 خطوات التشغيل

1. تأكد من تثبيت Flutter:
```bash
flutter doctor
```

2. تثبيت المكتبات:
```bash
flutter pub get
```

3. تشغيل التطبيق:
```bash
flutter run
```

## 📱 المنصات المدعومة

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

## 🔄 إدارة الحالة (State Management)

يمكنك استخدام Provider لإدارة الحالة:

```dart
// إنشاء Provider
class AppState extends ChangeNotifier {
  List<Activity> _activities = [];
  
  List<Activity> get activities => _activities;
  
  Future<void> loadActivities() async {
    final data = await ActivitiesService.getActivities();
    _activities = data.map((e) => Activity.fromJson(e)).toList();
    notifyListeners();
  }
}

// استخدام Provider
Provider.of<AppState>(context).loadActivities();
```

## 📞 الدعم

للمساعدة أو الاستفسارات، يرجى التواصل مع فريق التطوير.

## 📄 الترخيص

هذا المشروع مملوك لـ Elite Engineering Gathering.
