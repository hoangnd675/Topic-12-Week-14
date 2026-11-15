import 'package:flutter_test/flutter_test.dart';
import 'package:topic12_provider_demo/data/repositories/study_repository.dart';
import 'package:topic12_provider_demo/domain/models/study_task.dart';
import 'package:topic12_provider_demo/presentation/viewmodels/study_view_model.dart';

class FakeStudyRepository implements StudyRepository {
  final List<StudyTask> data = [
    const StudyTask(id: '1', title: 'Bài A', subject: 'Toán', dueLabel: 'Thứ 2'),
    const StudyTask(id: '2', title: 'Bài B', subject: 'Lý', dueLabel: 'Thứ 3', isDone: true),
  ];
  @override
  Future<List<StudyTask>> getTasks() async => List.of(data);
  @override
  Future<void> addTask(StudyTask task) async => data.add(task);
  @override
  Future<void> updateTask(StudyTask task) async {
    final i = data.indexWhere((e) => e.id == task.id);
    if (i >= 0) data[i] = task;
  }
  @override
  Future<void> deleteTask(String id) async => data.removeWhere((e) => e.id == id);
}

void main() {
  group('StudyViewModel + Supabase repository contract', () {
    late FakeStudyRepository repository;
    late StudyViewModel model;
    setUp(() { repository = FakeStudyRepository(); model = StudyViewModel(repository: repository); });
    test('loads tasks and calculates progress', () async {
      await model.loadTasks();
      expect(model.totalTasks, 2);
      expect(model.completedTasks, 1);
      expect(model.progress, 0.5);
    });
    test('adds task with weekday and persists it', () async {
      await model.loadTasks();
      final added = await model.addTask(title: 'Ôn tập', subject: 'Toán', dueLabel: 'Thứ 5');
      expect(added, isTrue);
      expect(repository.data.last.dueLabel, 'Thứ 5');
      expect(model.totalTasks, 3);
    });
    test('rejects empty task', () async {
      await model.loadTasks();
      expect(await model.addTask(title: ' ', subject: 'Toán'), isFalse);
      expect(model.totalTasks, 2);
    });
    test('toggles completion and persists', () async {
      await model.loadTasks();
      await model.toggleTask('1');
      expect(repository.data.first.isDone, isTrue);
      expect(model.progress, 1);
    });
    test('deletes task and recalculates progress', () async {
      await model.loadTasks();
      await model.deleteTask('2');
      expect(repository.data, hasLength(1));
      expect(model.completedTasks, 0);
      expect(model.progress, 0);
    });
    test('filters tasks by subject', () async {
      await model.loadTasks();
      model.selectSubject('Toán');
      expect(model.visibleTasks, hasLength(1));
    });
  });
}
