import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:topic12_provider_demo/presentation/viewmodels/study_view_model.dart';
import 'package:topic12_provider_demo/presentation/viewmodels/theme_view_model.dart';
import 'package:topic12_provider_demo/presentation/views/study_page.dart';

Widget createTestApp() {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => StudyViewModel()),
      ChangeNotifierProvider(create: (_) => ThemeViewModel()),
    ],
    child: Consumer<ThemeViewModel>(
      builder: (context, theme, _) => MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
        ),
        themeMode: theme.isDark ? ThemeMode.dark : ThemeMode.light,
        home: const StudyPage(),
      ),
    ),
  );
}

void main() {
  testWidgets('shows dashboard and initial tasks', (tester) async {
    await tester.pumpWidget(createTestApp());

    expect(find.text('Study Planner'), findsOneWidget);
    expect(find.text('Nhiệm vụ học tập'), findsOneWidget);
    expect(find.text('Ôn tập phương trình bậc hai'), findsOneWidget);
    expect(find.text('1 / 5 nhiệm vụ đã hoàn thành'), findsOneWidget);
  });

  testWidgets('adds a task and displays it immediately', (tester) async {
    await tester.pumpWidget(createTestApp());

    await tester.tap(find.text('Thêm nhiệm vụ'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Tên nhiệm vụ'),
      'Ôn thi cuối kỳ',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Môn học'),
      'Giải tích',
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Thêm'));
    await tester.pumpAndSettle();

    expect(find.text('Ôn thi cuối kỳ'), findsOneWidget);
    expect(find.text('Giải tích  •  Mới thêm'), findsOneWidget);
    expect(find.text('6 nhiệm vụ'), findsOneWidget);
  });

  testWidgets('validates empty task title', (tester) async {
    await tester.pumpWidget(createTestApp());

    await tester.tap(find.text('Thêm nhiệm vụ'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Thêm'));
    await tester.pumpAndSettle();

    expect(find.text('Vui lòng nhập tên nhiệm vụ'), findsOneWidget);
    expect(find.text('Thêm nhiệm vụ học tập'), findsOneWidget);
  });

  testWidgets('filters tasks by subject', (tester) async {
    await tester.pumpWidget(createTestApp());

    await tester.tap(find.widgetWithText(ChoiceChip, 'Toán'));
    await tester.pumpAndSettle();

    expect(find.text('Ôn tập phương trình bậc hai'), findsOneWidget);
    expect(find.text('Đọc Chapter 4: Provider'), findsNothing);
    expect(find.text('1 nhiệm vụ'), findsOneWidget);
  });

  testWidgets('checkbox updates completion and progress', (tester) async {
    await tester.pumpWidget(createTestApp());

    await tester.tap(find.text('Ôn tập phương trình bậc hai'));
    await tester.pumpAndSettle();

    expect(find.text('2 / 5 nhiệm vụ đã hoàn thành'), findsOneWidget);
    expect(find.text('40%'), findsOneWidget);
  });

  testWidgets('theme button changes the actual app theme', (tester) async {
    await tester.pumpWidget(createTestApp());

    expect(
      Theme.of(tester.element(find.byType(StudyPage))).brightness,
      Brightness.light,
    );

    await tester.tap(find.byIcon(Icons.dark_mode_outlined));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.light_mode_outlined), findsOneWidget);
    expect(
      Theme.of(tester.element(find.byType(StudyPage))).brightness,
      Brightness.dark,
    );
  });
}
