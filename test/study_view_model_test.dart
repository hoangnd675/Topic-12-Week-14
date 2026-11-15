import 'package:flutter_test/flutter_test.dart';
import 'package:topic12_provider_demo/presentation/viewmodels/study_view_model.dart';

void main() {
  group('StudyViewModel', () {
    late StudyViewModel viewModel;

    setUp(() {
      viewModel = StudyViewModel();
    });

    test('loads initial tasks and calculates progress', () {
      expect(viewModel.totalTasks, 5);
      expect(viewModel.completedTasks, 1);
      expect(viewModel.progress, 0.2);
    });

    test('toggleTask updates completion and progress', () {
      viewModel.toggleTask('task-1');

      expect(viewModel.completedTasks, 2);
      expect(viewModel.progress, 0.4);
      expect(viewModel.tasks.first.isDone, isTrue);
    });

    test('selectSubject filters visible tasks', () {
      viewModel.selectSubject('Toán');

      expect(viewModel.visibleTasks, hasLength(1));
      expect(viewModel.visibleTasks.first.subject, 'Toán');
    });

    test('addTask trims input and makes the new task visible', () {
      viewModel.selectSubject('Toán');

      final added = viewModel.addTask(
        title: '  Ôn thi cuối kỳ  ',
        subject: '  Giải tích  ',
      );

      expect(added, isTrue);
      expect(viewModel.selectedSubject, 'Tất cả');
      expect(viewModel.totalTasks, 6);
      expect(viewModel.tasks.last.title, 'Ôn thi cuối kỳ');
      expect(viewModel.tasks.last.subject, 'Giải tích');
    });

    test('rejects empty task fields without changing state', () {
      final added = viewModel.addTask(title: ' ', subject: 'Toán');

      expect(added, isFalse);
      expect(viewModel.totalTasks, 5);
    });

    test('ignores unknown task IDs and subjects', () {
      viewModel.toggleTask('missing');
      viewModel.selectSubject('Không tồn tại');

      expect(viewModel.totalTasks, 5);
      expect(viewModel.selectedSubject, 'Tất cả');
    });
  });
}
