import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/models/study_task.dart';
import '../viewmodels/study_view_model.dart';
import '../viewmodels/theme_view_model.dart';

class StudyPage extends StatelessWidget {
  const StudyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final study = context.watch<StudyViewModel>();
    final theme = context.watch<ThemeViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Study Planner',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: [
          TextButton(
            onPressed: context.read<ThemeViewModel>().toggleTheme,
            child: Text(theme.isDark ? 'Giao diện sáng' : 'Giao diện tối'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddTaskDialog(context),
        label: const Text('Thêm nhiệm vụ'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
            children: [
              const SizedBox(height: 8),
              _ProgressCard(
                completed: study.completedTasks,
                total: study.totalTasks,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Nhiệm vụ học tập',
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    '${study.visibleTasks.length} nhiệm vụ',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: study.subjects.map((subject) {
                  return ChoiceChip(
                    label: Text(subject),
                    selected: study.selectedSubject == subject,
                    showCheckmark: false,
                    onSelected: (_) => context
                        .read<StudyViewModel>()
                        .selectSubject(subject),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),
              if (study.visibleTasks.isEmpty)
                const _EmptyState()
              else
                ...study.visibleTasks.map(
                  (task) => _TaskTile(task: task),
                ),
              const SizedBox(height: 24),
              const _ProviderNote(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showAddTaskDialog(BuildContext context) async {
    final titleController = TextEditingController();
    final subjectController = TextEditingController(text: 'Lập trình');
    final formKey = GlobalKey<FormState>();

    try {
      await showDialog<void>(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: const Text('Thêm nhiệm vụ học tập'),
            content: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration:
                        const InputDecoration(labelText: 'Tên nhiệm vụ'),
                    validator: (value) =>
                        value == null || value.trim().isEmpty
                            ? 'Vui lòng nhập tên nhiệm vụ'
                            : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: subjectController,
                    decoration: const InputDecoration(labelText: 'Môn học'),
                    validator: (value) =>
                        value == null || value.trim().isEmpty
                            ? 'Vui lòng nhập môn học'
                            : null,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text('Hủy'),
              ),
              FilledButton(
                onPressed: () {
                  if (!formKey.currentState!.validate()) return;

                  final added = context.read<StudyViewModel>().addTask(
                        title: titleController.text,
                        subject: subjectController.text,
                      );
                  if (added) Navigator.pop(dialogContext);
                },
                child: const Text('Thêm'),
              ),
            ],
          );
        },
      );
    } finally {
      titleController.dispose();
      subjectController.dispose();
    }
  }
}

class _ProgressCard extends StatelessWidget {
  const _ProgressCard({required this.completed, required this.total});

  final int completed;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Tiến độ học tập',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
                Selector<StudyViewModel, double>(
                  selector: (_, model) => model.progress,
                  builder: (_, progress, __) => Text(
                    '${(progress * 100).round()}%',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Selector<StudyViewModel, double>(
              selector: (_, model) => model.progress,
              builder: (_, progress, __) => ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 10,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text('$completed / $total nhiệm vụ đã hoàn thành'),
          ],
        ),
      ),
    );
  }
}

class _TaskTile extends StatelessWidget {
  const _TaskTile({required this.task});

  final StudyTask task;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      child: CheckboxListTile(
        value: task.isDone,
        onChanged: (_) =>
            context.read<StudyViewModel>().toggleTask(task.id),
        controlAffinity: ListTileControlAffinity.leading,
        title: Text(
          task.title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            decoration: task.isDone ? TextDecoration.lineThrough : null,
            color: task.isDone ? colors.onSurfaceVariant : null,
          ),
        ),
        subtitle: Text('${task.subject}  •  ${task.dueLabel}'),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(28),
      child: Column(
        children: [
          Text('Chưa có nhiệm vụ trong môn học này.'),
        ],
      ),
    );
  }
}

class _ProviderNote extends StatelessWidget {
  const _ProviderNote();

  @override
  Widget build(BuildContext context) {
    return const Card(
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Provider trong demo này',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('• MultiProvider / ChangeNotifierProvider: đăng ký ViewModel.'),
            Text('• context.watch: theo dõi state để cập nhật giao diện.'),
            Text('• context.read: gọi hành động từ ViewModel.'),
            Text('• Consumer: cập nhật MaterialApp theo ThemeViewModel.'),
            Text('• Selector: chỉ cập nhật phần tiến độ khi tỷ lệ thay đổi.'),
          ],
        ),
      ),
    );
  }
}
