import '../../domain/models/study_task.dart';

/// Data source for study tasks.
/// Returns a fresh, mutable list for the ViewModel to manage.
class StudyRepository {
  const StudyRepository();

  List<StudyTask> getInitialTasks() {
    return [
      const StudyTask(
        id: 'task-1',
        title: 'Ôn tập phương trình bậc hai',
        subject: 'Toán',
        dueLabel: 'Hôm nay',
      ),
      const StudyTask(
        id: 'task-2',
        title: 'Đọc Chapter 4: Provider',
        subject: 'Lập trình',
        dueLabel: 'Hôm nay',
      ),
      const StudyTask(
        id: 'task-3',
        title: 'Làm bài tập từ vựng Unit 6',
        subject: 'Tiếng Anh',
        dueLabel: 'Ngày mai',
      ),
      const StudyTask(
        id: 'task-4',
        title: 'Tóm tắt bài giảng Vật lý',
        subject: 'Vật lý',
        dueLabel: 'Thứ 6',
        isDone: true,
      ),
      const StudyTask(
        id: 'task-5',
        title: 'Thực hành ChangeNotifier',
        subject: 'Lập trình',
        dueLabel: 'Thứ 7',
      ),
    ];
  }
}
