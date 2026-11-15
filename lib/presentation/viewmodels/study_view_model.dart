import 'package:flutter/foundation.dart';

import '../../data/repositories/study_repository.dart';
import '../../domain/models/study_task.dart';

class StudyViewModel extends ChangeNotifier {
  StudyViewModel({required StudyRepository repository}) : _repository = repository;

  final StudyRepository _repository;
  final List<StudyTask> _tasks = [];
  String _selectedSubject = 'Tất cả';
  bool _isLoading = false;
  String? _error;

  List<StudyTask> get tasks => List.unmodifiable(_tasks);
  String get selectedSubject => _selectedSubject;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get totalTasks => _tasks.length;
  int get completedTasks => _tasks.where((task) => task.isDone).length;
  double get progress => totalTasks == 0 ? 0 : completedTasks / totalTasks;

  List<String> get subjects {
    final names = _tasks.map((task) => task.subject).toSet().toList()..sort();
    return ['Tất cả', ...names];
  }

  List<StudyTask> get visibleTasks {
    if (_selectedSubject == 'Tất cả') return tasks;
    return List.unmodifiable(_tasks.where((task) => task.subject == _selectedSubject));
  }

  Future<void> loadTasks() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final loaded = await _repository.getTasks();
      _tasks
        ..clear()
        ..addAll(loaded);
    } catch (error) {
      _error = 'Không thể tải nhiệm vụ từ Supabase: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectSubject(String subject) {
    if (!subjects.contains(subject) || _selectedSubject == subject) return;
    _selectedSubject = subject;
    notifyListeners();
  }

  Future<void> toggleTask(String id) async {
    final index = _tasks.indexWhere((task) => task.id == id);
    if (index == -1) return;
    final previous = _tasks[index];
    final updated = previous.copyWith(isDone: !previous.isDone);
    _tasks[index] = updated;
    notifyListeners();
    try {
      await _repository.updateTask(updated);
    } catch (error) {
      _tasks[index] = previous;
      _error = 'Không thể cập nhật nhiệm vụ: $error';
      notifyListeners();
    }
  }

  Future<bool> addTask({required String title, required String subject, String dueLabel = 'Mới thêm'}) async {
    final cleanTitle = title.trim();
    final cleanSubject = subject.trim();
    if (cleanTitle.isEmpty || cleanSubject.isEmpty) return false;
    final task = StudyTask(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: cleanTitle,
      subject: cleanSubject,
      dueLabel: dueLabel.trim().isEmpty ? 'Mới thêm' : dueLabel.trim(),
    );
    try {
      await _repository.addTask(task);
      _tasks.add(task);
      _selectedSubject = 'Tất cả';
      _error = null;
      notifyListeners();
      return true;
    } catch (error) {
      _error = 'Không thể lưu nhiệm vụ: $error';
      notifyListeners();
      return false;
    }
  }

  Future<void> deleteTask(String id) async {
    final index = _tasks.indexWhere((task) => task.id == id);
    if (index == -1) return;
    final removed = _tasks.removeAt(index);
    notifyListeners();
    try {
      await _repository.deleteTask(id);
    } catch (error) {
      _tasks.insert(index, removed);
      _error = 'Không thể xóa nhiệm vụ: $error';
      notifyListeners();
    }
  }
}
