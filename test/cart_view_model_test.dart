import 'package:flutter_test/flutter_test.dart';
import 'package:topic12_provider_demo/presentation/viewmodels/study_view_model.dart';

void main() {
  group('StudyViewModel', () {
    late StudyViewModel viewModel;

    setUp(() => viewModel = StudyViewModel());

    test('loads sample tasks and calculates progress', () {
      expect(viewModel.totalTasks, 5);
      expect(viewModel.completedTasks, 1);
      expect(viewModel.progress, 0.2);
    });

    test('toggleTask changes completion and progress', () {
      final task = viewModel.tasks.firstWhere((item) => !item.isDone);
      viewModel.toggleTask(task.id);
      expect(viewModel.completedTasks, 2);
      expect(viewModel.progress, 0.4);
    });

    test('addTask adds a task and its subject filter', () {
      viewModel.addTask(title: 'Ôn Provider', subject: 'Flutter');
      expect(viewModel.tasks.last.title, 'Ôn Provider');
      expect(viewModel.subjects, contains('Flutter'));
      expect(viewModel.totalTasks, 6);
    });

    test('does not add empty task data', () {
      viewModel.addTask(title: '  ', subject: 'Toán');
      expect(viewModel.totalTasks, 5);
    });

    test('filters tasks by selected subject', () {
      viewModel.selectSubject('Toán');
      expect(viewModel.visibleTasks, hasLength(1));
      expect(viewModel.visibleTasks.first.subject, 'Toán');
    });
  });
}
