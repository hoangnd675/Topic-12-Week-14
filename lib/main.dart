import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'presentation/viewmodels/study_view_model.dart';
import 'presentation/viewmodels/theme_view_model.dart';
import 'presentation/views/store_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StudyViewModel()),
        ChangeNotifierProvider(create: (_) => ThemeViewModel()),
      ],
      child: const Topic12App(),
    ),
  );
}

class Topic12App extends StatelessWidget {
  const Topic12App({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeViewModel>(
      builder: (context, theme, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Study Planner - Topic 12',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4967D5)),
          scaffoldBackgroundColor: const Color(0xFFF5F7FC),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF9EAEFF),
            brightness: Brightness.dark,
          ),
        ),
        themeMode: theme.isDark ? ThemeMode.dark : ThemeMode.light,
        home: const StudyPage(),
      ),
    );
  }
}
