# 🔗 دليل ربط Flutter App مع NestJS Backend

## 📋 نظرة عامة

هذا الدليل يشرح كيفية ربط تطبيق Flutter الموجود مع Backend API المبني بـ NestJS.

---

## 🚀 خطوات الربط

### 1️⃣ تشغيل Backend API

أولاً، تأكد من تشغيل Backend:

```bash
cd backend-api
npm run start:dev
```

تأكد من أن السيرفر يعمل على: http://localhost:3000/api

---

### 2️⃣ تحديث عنوان API في Flutter

افتح ملف `lib/services/api_service.dart` وحدّث `baseUrl`:

```dart
class ApiService {
  // للاختبار على المحاكي
  static const String baseUrl = 'http://localhost:3000/api';
  
  // للاختبار على جهاز Android حقيقي
  // static const String baseUrl = 'http://10.0.2.2:3000/api';
  
  // للاختبار على جهاز iOS حقيقي أو أي جهاز آخر
  // static const String baseUrl = 'http://192.168.1.100:3000/api';
  // (استبدل 192.168.1.100 بـ IP جهازك)
```

#### كيفية معرفة IP جهازك:

**Windows:**
```bash
ipconfig
```
ابحث عن "IPv4 Address"

**Mac/Linux:**
```bash
ifconfig | grep "inet "
```

---

### 3️⃣ تفعيل HTTP Requests

في ملف `lib/services/api_service.dart`, قم بإلغاء التعليق عن الكود:

#### قبل:
```dart
Future<dynamic> get(String endpoint) async {
  // TODO: Uncomment when backend is ready
  // final response = await http.get(
  //   Uri.parse('$baseUrl/$endpoint'),
  //   headers: await _getHeaders(),
  // );
  // return _handleResponse(response);
  
  // Temporary mock data
  return {};
}
```

#### بعد:
```dart
Future<dynamic> get(String endpoint) async {
  final response = await http.get(
    Uri.parse('$baseUrl/$endpoint'),
    headers: await _getHeaders(),
  );
  return _handleResponse(response);
}
```

قم بنفس الشيء لـ `post`, `put`, `delete`.

---

### 4️⃣ إضافة بيانات تجريبية

لإضافة بيانات تجريبية للاختبار:

```bash
curl -X POST http://localhost:3000/api/seed
```

أو افتح في المتصفح: http://localhost:3000/api/seed

---

### 5️⃣ اختبار التطبيق

#### أ. تسجيل الدخول

استخدم بيانات الدخول التجريبية:

- **Email:** `ahmed@example.com`
- **Password:** `123456`

أو:

- **Email:** `fatima@example.com`
- **Password:** `123456`

#### ب. تسجيل مستخدم جديد

يمكنك إنشاء حساب جديد من شاشة التسجيل في التطبيق.

---

## 🔧 تحديثات مطلوبة في Flutter

### 1. تحديث AuthService

في `lib/services/api_service.dart`:

```dart
class AuthService {
  static Future<bool> login(String email, String password) async {
    try {
      final response = await ApiService().post('auth/login', {
        'email': email,
        'password': password,
      });
      
      if (response['token'] != null) {
        await _saveToken(response['token']);
        await _saveUser(response['user']);
        return true;
      }
      return false;
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }

  static Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  static Future<void> _saveUser(Map<String, dynamic> user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_data', jsonEncode(user));
  }

  static Future<Map<String, dynamic>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user_data');
    if (userData != null) {
      return jsonDecode(userData);
    }
    return null;
  }

  static Future<bool> register(Map<String, dynamic> userData) async {
    try {
      final response = await ApiService().post('auth/register', userData);
      
      if (response['token'] != null) {
        await _saveToken(response['token']);
        await _saveUser(response['user']);
        return true;
      }
      return false;
    } catch (e) {
      print('Register error: $e');
      return false;
    }
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('user_data');
  }
}
```

### 2. تحديث ActivitiesService

```dart
class ActivitiesService {
  static Future<List<Map<String, dynamic>>> getActivities() async {
    try {
      final response = await ApiService().get('activities');
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print('Get activities error: $e');
      return [];
    }
  }

  static Future<bool> registerInActivity(String activityId, {String? notes}) async {
    try {
      await ApiService().post('activities/$activityId/register', {
        'notes': notes ?? '',
      });
      return true;
    } catch (e) {
      print('Register in activity error: $e');
      return false;
    }
  }

  static Future<List<Map<String, dynamic>>> getMyActivities() async {
    try {
      final response = await ApiService().get('activities/my-activities');
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print('Get my activities error: $e');
      return [];
    }
  }
}
```

### 3. تحديث TasksService

```dart
class TasksService {
  static Future<List<Map<String, dynamic>>> getTasks() async {
    try {
      final response = await ApiService().get('tasks');
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print('Get tasks error: $e');
      return [];
    }
  }

  static Future<Map<String, dynamic>> getStatistics() async {
    try {
      return await ApiService().get('tasks/statistics');
    } catch (e) {
      print('Get statistics error: $e');
      return {
        'total': 0,
        'active': 0,
        'completed': 0,
        'overdue': 0,
        'averageProgress': 0,
      };
    }
  }

  static Future<bool> createTask(Map<String, dynamic> taskData) async {
    try {
      await ApiService().post('tasks', taskData);
      return true;
    } catch (e) {
      print('Create task error: $e');
      return false;
    }
  }

  static Future<bool> updateTask(String taskId, Map<String, dynamic> updates) async {
    try {
      await ApiService().put('tasks/$taskId', updates);
      return true;
    } catch (e) {
      print('Update task error: $e');
      return false;
    }
  }

  static Future<bool> deleteTask(String taskId) async {
    try {
      await ApiService().delete('tasks/$taskId');
      return true;
    } catch (e) {
      print('Delete task error: $e');
      return false;
    }
  }
}
```

---

## 🧪 اختبار الربط

### 1. اختبار تسجيل الدخول

```dart
// في شاشة تسجيل الدخول
final success = await AuthService.login(
  'ahmed@example.com',
  '123456',
);

if (success) {
  // الانتقال للشاشة الرئيسية
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => MainScreen()),
  );
} else {
  // عرض رسالة خطأ
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('فشل تسجيل الدخول')),
  );
}
```

### 2. اختبار جلب الأنشطة

```dart
// في الشاشة الرئيسية
final activities = await ActivitiesService.getActivities();
setState(() {
  _activities = activities;
});
```

### 3. اختبار إنشاء مهمة

```dart
final success = await TasksService.createTask({
  'title': 'مهمة جديدة',
  'description': 'وصف المهمة',
  'priority': 'عالية',
  'dueDate': '2024-12-31',
  'progress': 0,
});

if (success) {
  // تحديث القائمة
  _loadTasks();
}
```

---

## 🔍 حل المشاكل

### مشكلة: Connection refused

**الحل:**
- تأكد من تشغيل Backend API
- تأكد من صحة عنوان IP
- للمحاكي Android استخدم `10.0.2.2` بدلاً من `localhost`

### مشكلة: 401 Unauthorized

**الحل:**
- تأكد من حفظ Token بعد تسجيل الدخول
- تأكد من إرسال Token في الـ Headers

### مشكلة: CORS Error

**الحل:**
- أضف عنوان التطبيق إلى `CORS_ORIGIN` في `.env` الخاص بالـ Backend

---

## 📱 نصائح للتطوير

1. استخدم `print()` لطباعة الأخطاء أثناء التطوير
2. استخدم Postman لاختبار API قبل الربط
3. تأكد من تطابق أسماء الحقول بين Flutter و Backend
4. استخدم `try-catch` لمعالجة الأخطاء

---

## 🎯 الخطوات التالية

1. ✅ اختبر جميع الوظائف
2. ✅ أضف معالجة أخطاء أفضل
3. ✅ أضف Loading indicators
4. ✅ أضف Offline support
5. ✅ أضف Push Notifications

---

**تم التطوير بـ ❤️ بواسطة Elite Engineering Team**
