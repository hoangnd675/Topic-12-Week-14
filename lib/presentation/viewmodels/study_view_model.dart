import 'package:flutter/foundation.dart';
import '../../data/repositories/study_repository.dart';
import '../../domain/models/study_task.dart';
class StudyViewModel extends ChangeNotifier {
  StudyViewModel({StudyRepository repository = const StudyRepository()}) : _tasks = repository.getInitialTasks();
  final List<StudyTask> _tasks;
  String _selectedSubject = 'Tất cả';
  List<StudyTask> get tasks => List.unmodifiable(_tasks);
  String get selectedSubject => _selectedSubject;
  int get totalTasks => _tasks.length;
  int get completedTasks => _tasks.where((task) => task.isDone).length;
  double get progress => totalTasks == 0 ? 0 : completedTasks / totalTasks;
  List<String> get subjects => ['Tất cả', ...{..._tasks.map((task) => task.subject)}];
  List<StudyTask> get visibleTasks => _selectedSubject == 'Tất cả' ? tasks : _tasks.where((task) => task.subject == _selectedSubject).toList();
  void selectSubject(String subject) {
    if (_selectedSubject == subject) return;
    _selectedSubject = subject;
    notifyListeners();
  }
  void toggleTask(String id) {
    final index = _tasks.indexWhere((task) => task.id == id);
    if (index == -1) return;
    _tasks[index] = _tasks[index].copyWith(isDone: !_tasks[index].isDone);
    notifyListeners();
  }
  void addTask({required String title, required String subject}) {
    final cleanTitle = title.trim();
    final cleanSubject = subject.trim();
    if (cleanTitle.isEmpty || cleanSubject.isEmpty) return;
    _tasks.add(StudyTask(id: DateTime.now().microsecondsSinceEpoch.toString(), title: cleanTitle, subject: cleanSubject, dueLabel: 'Mới thêm'));
    notifyListeners();
  }
}
