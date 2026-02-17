import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/api_service.dart';

class AppProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}

class ActivitiesProvider extends AppProvider {
  List<Activity> _activities = [];
  List<Activity> get activities => _activities;

  Future<void> fetchActivities() async {
    setLoading(true);
    try {
      final data = await ActivitiesService.getActivities();
      _activities = data.map((item) => Activity.fromJson(item)).toList();
    } catch (e) {
      print('Error fetching activities: $e');
    } finally {
      setLoading(false);
    }
  }
}

class TasksProvider extends AppProvider {
  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;

  Future<void> fetchTasks() async {
    setLoading(true);
    try {
      final data = await TasksService.getTasks();
      _tasks = data.map((item) => Task.fromJson(item)).toList();
    } catch (e) {
      print('Error fetching tasks: $e');
    } finally {
      setLoading(false);
    }
  }
}

class UserProvider extends AppProvider {
  User? _user;
  User? get user => _user;

  Future<void> fetchProfile() async {
    setLoading(true);
    try {
      final data = await UserService.getProfile();
      if (data != null) {
        _user = User.fromJson(data);
      }
    } catch (e) {
      print('Error fetching profile: $e');
    } finally {
      setLoading(false);
    }
  }
}
