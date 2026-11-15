class StudyTask {
  const StudyTask({required this.id, required this.title, required this.subject, required this.dueLabel, this.isDone = false});
  final String id;
  final String title;
  final String subject;
  final String dueLabel;
  final bool isDone;
  StudyTask copyWith({bool? isDone}) => StudyTask(id: id, title: title, subject: subject, dueLabel: dueLabel, isDone: isDone ?? this.isDone);
}
