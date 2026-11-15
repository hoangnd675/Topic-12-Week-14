import '../../domain/models/study_task.dart';
class StudyRepository {
  const StudyRepository();
  List<StudyTask> getInitialTasks() => const [
    StudyTask(id: '1', title: 'Ôn tập phương trình bậc hai', subject: 'Toán', dueLabel: 'Hôm nay'),
    StudyTask(id: '2', title: 'Đọc Chapter 4: Provider', subject: 'Lập trình', dueLabel: 'Hôm nay'),
    StudyTask(id: '3', title: 'Làm bài tập từ vựng Unit 6', subject: 'Tiếng Anh', dueLabel: 'Ngày mai'),
    StudyTask(id: '4', title: 'Tóm tắt bài giảng Vật lý', subject: 'Vật lý', dueLabel: 'Thứ 6', isDone: true),
    StudyTask(id: '5', title: 'Thực hành ChangeNotifier', subject: 'Lập trình', dueLabel: 'Thứ 7'),
  ];
}
