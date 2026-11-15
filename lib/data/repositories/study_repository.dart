import '../../domain/models/study_task.dart';

/// Data source for study tasks. Replace this class with an API/local database
/// implementation without changing the View or ViewModel.
class StudyRepository {
  const StudyRepository();

  List<StudyTask> getInitialTasks() {
    return const [
      StudyTask(
        id: 'task-1',
        title: 'Ôn tập phương trình bậc hai',
        subject: 'Toán',
        dueLabel: 'Hôm nay',
      ),
      StudyTask(
        id: 'task-2',
        title: 'Đọc Chapter 4: Provider',
        subject: 'Lập trình',
        dueLabel: 'Hôm nay',
      ),
      StudyTask(
        id: 'task-3',
        title: 'Làm bài tập từ vựng Unit 6',
        subject: 'Tiếng Anh',
        dueLabel: 'Ngày mai',
      ),
      StudyTask(
        id: 'task-4',
        title: 'Tóm tắt bài giảng Vật lý',
        subject: 'Vật lý',
        dueLabel: 'Thứ 6',
        isDone: true,
      ),
      StudyTask(
        id: 'task-5',
        title: 'Thực hành ChangeNotifier',
        subject: 'Lập trình',
        dueLabel: 'Thứ 7',
      ),
    ];
  }
}
