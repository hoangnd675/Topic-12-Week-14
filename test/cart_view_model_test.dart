import 'package:flutter_test/flutter_test.dart';
import 'package:topic12_provider_demo/presentation/viewmodels/study_view_model.dart';

void main() {
  group('StudyViewModel', () {
    late StudyViewModel model;

    setUp(() {
      model = StudyViewModel();
    });

    test('starts with sample study tasks', () {
      expect(model.tasks, isNotEmpty);
      expect(model.totalTasks, greaterThan(0));
    });

    test('toggling a task updates completed count', () {
      final task = model.tasks.first;
      final before = model.completedTasks;
      model.toggleTask(task.id);
      expect(model.completedTasks, before + (task.isDone ? -1 : 1));
    });

    test('adds a new task', () {
      final before = model.totalTasks;
      model.addTask(title: 'Ôn tập Provider', subject: 'Lập trình');
      expect(model.totalTasks, before + 1);
      expect(model.tasks.last.title, 'Ôn tập Provider');
    });

    test('filters tasks by subject', () {
      model.selectSubject('Toán');
      expect(model.visibleTasks.every((task) => task.subject == 'Toán'), isTrue);
    });
  });
}
