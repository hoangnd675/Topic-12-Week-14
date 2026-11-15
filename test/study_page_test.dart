import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:topic12_provider_demo/presentation/viewmodels/study_view_model.dart';
import 'package:topic12_provider_demo/presentation/viewmodels/theme_view_model.dart';
import 'package:topic12_provider_demo/presentation/views/study_page.dart';

Widget createTestApp() => MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => StudyViewModel()),
    ChangeNotifierProvider(create: (_) => ThemeViewModel()),
  ],
  child: MaterialApp(
    home: const StudyPage(),
    theme: ThemeData(useMaterial3: true),
    darkTheme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
  ),
);

void main() {
  testWidgets('shows learning dashboard and sample tasks', (tester) async {
    await tester.pumpWidget(createTestApp());
    expect(find.text('Study Planner'), findsOneWidget);
    expect(find.text('Nhiệm vụ học tập'), findsOneWidget);
    expect(find.text('Ôn tập phương trình bậc hai'), findsOneWidget);
  });

  testWidgets('adds a new learning task from the dialog', (tester) async {
    await tester.pumpWidget(createTestApp());
    await tester.tap(find.text('Thêm nhiệm vụ'));
    await tester.pumpAndSettle();

    await tester.enterText(find.widgetWithText(TextFormField, 'Tên nhiệm vụ'), 'Ôn thi cuối kỳ');
    await tester.enterText(find.widgetWithText(TextFormField, 'Môn học'), 'Giải tích');
    await tester.tap(find.widgetWithText(FilledButton, 'Thêm'));
    await tester.pumpAndSettle();

    expect(find.text('Ôn thi cuối kỳ'), findsOneWidget);
    expect(find.text('Giải tích  •  Mới thêm'), findsOneWidget);
  });

  testWidgets('filters tasks by subject', (tester) async {
    await tester.pumpWidget(createTestApp());
    await tester.tap(find.widgetWithText(ChoiceChip, 'Toán'));
    await tester.pumpAndSettle();

    expect(find.text('Ôn tập phương trình bậc hai'), findsOneWidget);
    expect(find.text('Đọc Chapter 4: Provider'), findsNothing);
  });

  testWidgets('checkbox completes a task and updates progress', (tester) async {
    await tester.pumpWidget(createTestApp());
    await tester.tap(find.text('Ôn tập phương trình bậc hai'));
    await tester.pumpAndSettle();

    expect(find.text('2 / 5 nhiệm vụ đã hoàn thành'), findsOneWidget);
    expect(find.text('40%'), findsOneWidget);
  });

  testWidgets('theme toggle responds to tap', (tester) async {
    await tester.pumpWidget(createTestApp());
    expect(find.byIcon(Icons.dark_mode_outlined), findsOneWidget);
    await tester.tap(find.byIcon(Icons.dark_mode_outlined));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.light_mode_outlined), findsOneWidget);
  });
}
