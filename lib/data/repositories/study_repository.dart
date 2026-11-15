import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/models/study_task.dart';

class StudyRepository {
  StudyRepository(this._client);

  final SupabaseClient _client;

  Future<List<StudyTask>> getTasks() async {
    final rows = await _client.from('study_tasks').select().order('created_at');
    if (rows.isNotEmpty) {
      return rows.map((row) => StudyTask.fromMap(row)).toList();
    }

    final samples = [
      const StudyTask(id: 'sample-1', title: 'Ôn tập phương trình bậc hai', subject: 'Toán', dueLabel: 'Thứ 2'),
      const StudyTask(id: 'sample-2', title: 'Đọc Chapter 4: Provider', subject: 'Lập trình', dueLabel: 'Thứ 3'),
      const StudyTask(id: 'sample-3', title: 'Làm bài tập từ vựng Unit 6', subject: 'Tiếng Anh', dueLabel: 'Thứ 4'),
      const StudyTask(id: 'sample-4', title: 'Tóm tắt bài giảng Vật lý', subject: 'Vật lý', dueLabel: 'Thứ 6', isDone: true),
      const StudyTask(id: 'sample-5', title: 'Thực hành ChangeNotifier', subject: 'Lập trình', dueLabel: 'Thứ 7'),
    ];
    await _client.from('study_tasks').insert(samples.map((task) => task.toMap()).toList());
    return samples;
  }

  Future<void> addTask(StudyTask task) async {
    await _client.from('study_tasks').insert(task.toMap());
  }

  Future<void> updateTask(StudyTask task) async {
    await _client.from('study_tasks').update(task.toMap()).eq('id', task.id);
  }

  Future<void> deleteTask(String id) async {
    await _client.from('study_tasks').delete().eq('id', id);
  }
}
