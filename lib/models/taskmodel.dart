// taskmodel.dart
enum TaskStatus { notStarted, inProgress, completed }
enum TaskPriority { low, medium, high }

class TaskModel {
  final String title;
  final String deadline;
  final String project;
  final String description;
  TaskStatus status;
  TaskPriority priority;
  double progress;
  DateTime dueDate;

  TaskModel({
    required this.title,
    required this.deadline,
    required this.project,
    required this.description,
    required this.status,
    required this.priority,
    required this.progress,
    required this.dueDate,
  });
}
