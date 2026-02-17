# 🎓 Elite Engineering Gathering App

تطبيق شامل لإدارة الأنشطة والمهام والفعاليات للمهندسين النخبة.

## ✨ المميزات

### 📱 الشاشات الرئيسية

1. **الشاشة الرئيسية (Home)**
   - عرض الإعلانات الحديثة
   - الفعاليات القادمة
   - بطاقة الانضمام للتجمع
   - إحصائيات سريعة

2. **شاشة الأنشطة (Activities)**
   - عرض جميع الأنشطة
   - تصنيف الأنشطة (ورش عمل، ندوات، دورات، مؤتمرات)
   - التسجيل في الأنشطة
   - عرض عدد المشاركين

3. **شاشة المهام (Tasks)**
   - عرض المهام اليومية والمستقبلية
   - إحصائيات المهام (نشطة، مكتملة، متأخرة)
   - شريط التقدم لكل مهمة
   - أولويات ملونة (عالية، متوسطة، منخفضة)

4. **الإعدادات (Settings)**
   - **قسم الملف الشخصي:**
     - معلومات المستخدم مع الصورة
     - الإحصائيات الشخصية (15 مهمة، 8 نشاط، 92% إنجاز)
     - المعلومات الشخصية
     - اللجان والمشاريع
     - الإحصائيات والإنجازات
     - الشهادات والجوائز
   - **قسم الإعدادات:**
     - الإشعارات
     - اللغة
     - المظهر
     - الخصوصية والأمان
   - **قسم الدعم:**
     - المساعدة والدعم
     - حول التطبيق
   - **أزرار الإجراءات:**
     - تعديل الملف الشخصي
     - مشاركة الملف الشخصي
     - تسجيل الخروج

## 🎨 التصميم

- ✅ تصميم iOS Modern Light Mode
- ✅ ألوان احترافية ومتناسقة
- ✅ واجهة سهلة الاستخدام
- ✅ دعم اللغة العربية (RTL)
- ✅ Animations سلسة

## 🛠️ التقنيات المستخدمة

- **Flutter** - Framework
- **Dart** - اللغة البرمجية
- **Material Design** - نظام التصميم
- **Cupertino Icons** - الأيقونات

## 📦 المكتبات

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  http: ^1.1.0              # للاتصال بالـ API
  shared_preferences: ^2.2.2 # لحفظ البيانات
  provider: ^6.1.1          # إدارة الحالة
```

## 🚀 التشغيل

### المتطلبات
- Flutter SDK (3.11.0 أو أحدث)
- Dart SDK
- Android Studio / VS Code
- Git

### خطوات التشغيل

1. **استنساخ المشروع**
```bash
git clone <repository-url>
cd my_test_app
```

2. **تثبيت المكتبات**
```bash
flutter pub get
```

3. **تشغيل التطبيق**
```bash
flutter run
```

أو للويب:
```bash
flutter run -d chrome
```

## 📁 هيكل المشروع

```
lib/
├── main.dart                 # الشاشة الرئيسية والأنشطة
├── tasks_screen.dart         # شاشة المهام
├── profile_settings.dart     # الإعدادات (الملف الشخصي + الإعدادات مدمجة)
├── services/
│   └── api_service.dart      # خدمات API
└── models/
    └── models.dart           # نماذج البيانات
```

## 🔌 ربط Backend

راجع ملف [BACKEND_INTEGRATION.md](BACKEND_INTEGRATION.md) للحصول على دليل شامل لربط التطبيق بالـ Backend.

### نقاط النهاية (Endpoints) المطلوبة:

#### Authentication
- `POST /api/auth/login`
- `POST /api/auth/register`
- `POST /api/auth/logout`

#### Activities
- `GET /api/activities`
- `POST /api/activities/register`

#### Tasks
- `GET /api/tasks`
- `POST /api/tasks/create`
- `PUT /api/tasks/update/:id`

#### User
- `GET /api/user/profile`
- `PUT /api/user/update`

## 🎯 الميزات القادمة

- [ ] نظام الإشعارات Push Notifications
- [ ] التقويم التفاعلي
- [ ] الدردشة الجماعية
- [ ] مشاركة الملفات
- [ ] التقارير والإحصائيات المتقدمة
- [ ] الوضع الليلي (Dark Mode)

## 📱 المنصات المدعومة

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

## 🎨 نظام الألوان

```dart
Primary Green: #728156
Secondary Green: #9CAF88
Blue: #3B82F6
Purple: #8B5CF6
Orange: #F59E0B
Light Green: #10B981
Red: #EF4444
Background: #F5F5F5
```

## 📸 لقطات الشاشة

(يمكن إضافة لقطات الشاشة هنا)

## 👥 الفريق

- **المطور**: Elite Engineering Team
- **التصميم**: UI/UX Team
- **Backend**: API Development Team

## 📄 الترخيص

هذا المشروع مملوك لـ Elite Engineering Gathering.

## 📞 الدعم

للمساعدة أو الاستفسارات:
- Email: support@elite-engineering.com
- Website: www.elite-engineering.com

---

**تم التطوير بـ ❤️ بواسطة Elite Engineering Team**
