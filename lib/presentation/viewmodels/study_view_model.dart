import 'package:flutter/foundation.dart';

import '../../data/repositories/study_repository.dart';
import '../../domain/models/study_task.dart';

class StudyViewModel extends ChangeNotifier {
  StudyViewModel({StudyRepository repository = const StudyRepository()})
      : _tasks = repository.getInitialTasks();

  final List<StudyTask> _tasks;
  String _selectedSubject = 'Tất cả';
  int _nextTaskId = 6;

  List<StudyTask> get tasks => List.unmodifiable(_tasks);
  String get selectedSubject => _selectedSubject;

  int get totalTasks => _tasks.length;
  int get completedTasks => _tasks.where((task) => task.isDone).length;
  double get progress =>
      totalTasks == 0 ? 0 : completedTasks / totalTasks;

  List<String> get subjects {
    final names = _tasks.map((task) => task.subject).toSet().toList()..sort();
    return ['Tất cả', ...names];
  }

  List<StudyTask> get visibleTasks {
    if (_selectedSubject == 'Tất cả') return tasks;
    return List.unmodifiable(
      _tasks.where((task) => task.subject == _selectedSubject),
    );
  }

  void selectSubject(String subject) {
    if (!subjects.contains(subject) || _selectedSubject == subject) return;
    _selectedSubject = subject;
    notifyListeners();
  }

  void toggleTask(String id) {
    final index = _tasks.indexWhere((task) => task.id == id);
    if (index == -1) return;

    _tasks[index] = _tasks[index].copyWith(
      isDone: !_tasks[index].isDone,
    );
    notifyListeners();
  }

  bool addTask({
    required String title,
    required String subject,
    String dueLabel = 'Mới thêm',
  }) {
    final cleanTitle = title.trim();
    final cleanSubject = subject.trim();
    if (cleanTitle.isEmpty || cleanSubject.isEmpty) return false;

    _tasks.add(
      StudyTask(
        id: 'task-${_nextTaskId++}',
        title: cleanTitle,
        subject: cleanSubject,
        dueLabel: dueLabel.trim().isEmpty ? 'Mới thêm' : dueLabel.trim(),
      ),
    );

    // Return to "Tất cả" so the newly created task is always visible.
    _selectedSubject = 'Tất cả';
    notifyListeners();
    return true;
  }
  void deleteTask(String id) {
    final before = _tasks.length;
    _tasks.removeWhere((task) => task.id == id);
    if (_tasks.length == before) return;

    if (_selectedSubject != 'Tất cả' &&
        !_tasks.any((task) => task.subject == _selectedSubject)) {
      _selectedSubject = 'Tất cả';
    }
    notifyListeners();
  }

}
