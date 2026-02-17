// API Service for Backend Integration
class ApiService {
  // Base URL - يجب تغييره إلى عنوان السيرفر الحقيقي
  static const String baseUrl = 'http://localhost:3000/api';
  
  // Authentication Endpoints
  static const String loginEndpoint = '$baseUrl/auth/login';
  static const String registerEndpoint = '$baseUrl/auth/register';
  static const String logoutEndpoint = '$baseUrl/auth/logout';
  
  // User Endpoints
  static const String userProfileEndpoint = '$baseUrl/users/profile';
  static const String updateProfileEndpoint = '$baseUrl/users/profile';
  
  // Activities Endpoints
  static const String activitiesEndpoint = '$baseUrl/activities';
  static const String activityDetailsEndpoint = '$baseUrl/activities/';
  static const String registerActivityEndpoint = '$baseUrl/activities/register';
  
  // Tasks Endpoints
  static const String tasksEndpoint = '$baseUrl/tasks';
  static const String createTaskEndpoint = '$baseUrl/tasks';
  static const String updateTaskEndpoint = '$baseUrl/tasks';
  static const String deleteTaskEndpoint = '$baseUrl/tasks';
  
  // Announcements Endpoints
  static const String announcementsEndpoint = '$baseUrl/announcements';
  
  // Events Endpoints
  static const String eventsEndpoint = '$baseUrl/events';
  
  // Helper methods (Mocked for now)
  static Future<Map<String, dynamic>> get(String endpoint) async {
    await Future.delayed(const Duration(milliseconds: 800)); // Simulate network delay
    
    if (endpoint == userProfileEndpoint) {
      return {
        'success': true,
        'data': {
          'id': 1,
          'name': 'م. أحمد خالد',
          'email': 'ahmed@example.com',
          'phone': '0501234567',
          'position': 'مهندس برمجيات • لجنة الابتكار',
          'avatar': null,
          'created_at': DateTime.now().subtract(const Duration(days: 30)).toIso8601String(),
        }
      };
    }
    
    if (endpoint == activitiesEndpoint) {
      return {
        'success': true,
        'data': [
          {
            'id': 1,
            'title': 'هاكاثون الطاقة المستدامة',
            'description': 'تحدي تطوير حلول هندسية مبتكرة للطاقة النظيفة',
            'date': '1 مارس 2026',
            'time': '09:00 AM',
            'location': 'قاعة الابتكار الرئيسي',
            'committee': 'لجنة الابتكار',
            'participants': 45,
            'category': 'هاكاثون',
            'is_registered': true,
          },
          {
            'id': 2,
            'title': 'معرض مشاريع التخرج',
            'description': 'عرض مشاريع الطلبة أمام شركات هندسية رائدة',
            'date': '12 مارس 2026',
            'time': '10:00 AM',
            'location': 'مركز المؤتمرات',
            'committee': 'اللجنة الأكاديمية',
            'participants': 120,
            'category': 'معارض',
            'is_registered': false,
          },
          {
            'id': 3,
            'title': 'ورشة الذكاء الاصطناعي',
            'description': 'تعلم أساسيات التعلم الآلي وتطبيقاته الهندسية',
            'date': '20 فبراير 2026',
            'time': '04:00 PM',
            'location': 'مختبر التقنية',
            'committee': 'لجنة التدريب',
            'participants': 30,
            'category': 'ورش عمل',
            'is_registered': false,
          },
        ]
      };
    }

    if (endpoint == tasksEndpoint) {
      return {
        'success': true,
        'data': [
          {
            'id': 1,
            'title': 'مراجعة المخططات الهندسية',
            'description': 'مراجعة التصاميم الإنشائية للمرحلة الثانية من المشروع',
            'assignee': 'أحمد خالد',
            'priority': 'عالية',
            'status': 'قيد التنفيذ',
            'due_date': '2026-02-25',
            'due_time': '02:00 PM',
            'progress': 65,
            'is_completed': false,
          },
          {
            'id': 2,
            'title': 'تجهيز تقرير الاستدامة',
            'description': 'جمع البيانات المطلوبة لتقرير الأثر البيئي السنوي',
            'assignee': 'أحمد خالد',
            'priority': 'متوسطة',
            'status': 'مكتمل',
            'due_date': '2026-02-15',
            'due_time': '11:00 AM',
            'progress': 100,
            'is_completed': true,
          },
        ]
      };
    }

    return {'success': false, 'message': 'Endpoint not found'};
  }
  
  static Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> data) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return {'success': true, 'data': data, 'message': 'Success'};
  }
  
  static Future<Map<String, dynamic>> put(String endpoint, Map<String, dynamic> data) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return {'success': true, 'data': data, 'message': 'Updated'};
  }
  
  static Future<Map<String, dynamic>> delete(String endpoint) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return {'success': true, 'message': 'Deleted'};
  }
}

// Authentication Service
class AuthService {
  static String? _token = "mock-token-123";
  static Map<String, dynamic>? _currentUser;
  
  static Future<bool> login(String email, String password) async {
    final response = await ApiService.post(ApiService.loginEndpoint, {'email': email, 'password': password});
    if (response['success']) {
      _token = "mock-token-login";
      _currentUser = {'name': 'Ahmed', 'email': email};
      return true;
    }
    return false;
  }
  
  static Future<void> logout() async {
    _token = null;
    _currentUser = null;
  }
  
  static bool isLoggedIn() => _token != null;
  static Map<String, dynamic>? getCurrentUser() => _currentUser;
  static String? getToken() => _token;
}

// Activities Service
class ActivitiesService {
  static Future<List<Map<String, dynamic>>> getActivities() async {
    final response = await ApiService.get(ApiService.activitiesEndpoint);
    if (response['success'] == true) {
      return List<Map<String, dynamic>>.from(response['data']);
    }
    return [];
  }
}

// Tasks Service
class TasksService {
  static Future<List<Map<String, dynamic>>> getTasks() async {
    final response = await ApiService.get(ApiService.tasksEndpoint);
    if (response['success'] == true) {
      return List<Map<String, dynamic>>.from(response['data']);
    }
    return [];
  }
}

// User Service
class UserService {
  static Future<Map<String, dynamic>?> getProfile() async {
    final response = await ApiService.get(ApiService.userProfileEndpoint);
    if (response['success'] == true) {
      return response['data'];
    }
    return null;
  }
}
