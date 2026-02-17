// User Model
class User {
  final int id;
  final String name;
  final String email;
  final String? phone;
  final String? position;
  final String? avatar;
  final DateTime createdAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.position,
    this.avatar,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      position: json['position'],
      avatar: json['avatar'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'position': position,
      'avatar': avatar,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

// Activity Model
class Activity {
  final int id;
  final String title;
  final String description;
  final String date;
  final String time;
  final String location;
  final String committee;
  final int participants;
  final String category;
  final String? image;
  final bool isRegistered;

  Activity({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.location,
    required this.committee,
    required this.participants,
    required this.category,
    this.image,
    this.isRegistered = false,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: json['date'],
      time: json['time'],
      location: json['location'],
      committee: json['committee'],
      participants: json['participants'],
      category: json['category'],
      image: json['image'],
      isRegistered: json['is_registered'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'time': time,
      'location': location,
      'committee': committee,
      'participants': participants,
      'category': category,
      'image': image,
      'is_registered': isRegistered,
    };
  }
}

// Task Model
class Task {
  final int id;
  final String title;
  final String description;
  final String assignee;
  final String priority;
  final String status;
  final String dueDate;
  final String dueTime;
  final int progress;
  final bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.assignee,
    required this.priority,
    required this.status,
    required this.dueDate,
    required this.dueTime,
    required this.progress,
    this.isCompleted = false,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      assignee: json['assignee'],
      priority: json['priority'],
      status: json['status'],
      dueDate: json['due_date'],
      dueTime: json['due_time'],
      progress: json['progress'],
      isCompleted: json['is_completed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'assignee': assignee,
      'priority': priority,
      'status': status,
      'due_date': dueDate,
      'due_time': dueTime,
      'progress': progress,
      'is_completed': isCompleted,
    };
  }
}

// Announcement Model
class Announcement {
  final int id;
  final String title;
  final String description;
  final String category;
  final String date;
  final String? image;
  final bool isImportant;

  Announcement({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.date,
    this.image,
    this.isImportant = false,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      date: json['date'],
      image: json['image'],
      isImportant: json['is_important'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'date': date,
      'image': image,
      'is_important': isImportant,
    };
  }
}

// Event Model
class Event {
  final int id;
  final String title;
  final String description;
  final String date;
  final String time;
  final String location;
  final String type;
  final int attendees;
  final String? image;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.location,
    required this.type,
    required this.attendees,
    this.image,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: json['date'],
      time: json['time'],
      location: json['location'],
      type: json['type'],
      attendees: json['attendees'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'time': time,
      'location': location,
      'type': type,
      'attendees': attendees,
      'image': image,
    };
  }
}

// Statistics Model
class Statistics {
  final int activeTasks;
  final int completedTasks;
  final int overdueTasks;
  final int totalActivities;
  final int registeredActivities;
  final int completionRate;

  Statistics({
    required this.activeTasks,
    required this.completedTasks,
    required this.overdueTasks,
    required this.totalActivities,
    required this.registeredActivities,
    required this.completionRate,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) {
    return Statistics(
      activeTasks: json['active_tasks'],
      completedTasks: json['completed_tasks'],
      overdueTasks: json['overdue_tasks'],
      totalActivities: json['total_activities'],
      registeredActivities: json['registered_activities'],
      completionRate: json['completion_rate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'active_tasks': activeTasks,
      'completed_tasks': completedTasks,
      'overdue_tasks': overdueTasks,
      'total_activities': totalActivities,
      'registered_activities': registeredActivities,
      'completion_rate': completionRate,
    };
  }
}
