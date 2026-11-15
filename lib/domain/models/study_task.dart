class StudyTask {
  const StudyTask({
    required this.id,
    required this.title,
    required this.subject,
    required this.dueLabel,
    this.isDone = false,
  });

  final String id;
  final String title;
  final String subject;
  final String dueLabel;
  final bool isDone;

  factory StudyTask.fromMap(Map<String, dynamic> map) => StudyTask(
        id: map['id'] as String,
        title: map['title'] as String,
        subject: map['subject'] as String,
        dueLabel: map['due_label'] as String? ?? 'Mới thêm',
        isDone: map['is_done'] as bool? ?? false,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'subject': subject,
        'due_label': dueLabel,
        'is_done': isDone,
      };

  StudyTask copyWith({bool? isDone}) => StudyTask(
        id: id,
        title: title,
        subject: subject,
        dueLabel: dueLabel,
        isDone: isDone ?? this.isDone,
      );
}
