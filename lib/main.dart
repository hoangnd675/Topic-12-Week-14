import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'data/repositories/study_repository.dart';
import 'presentation/viewmodels/study_view_model.dart';
import 'presentation/viewmodels/theme_view_model.dart';
import 'presentation/views/study_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://wvsuvofgchmbsyucrdfy.supabase.co',
    publishableKey: 'sb_publishable_fjAhw3OS7pn8IoChJQ5ehw_TbzcNVuT',
  );
  final repository = StudyRepository(Supabase.instance.client);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => StudyViewModel(repository: repository)..loadTasks(),
        ),
        ChangeNotifierProvider(create: (_) => ThemeViewModel()),
      ],
      child: const Topic12App(),
    ),
  );
}

class Topic12App extends StatelessWidget {
  const Topic12App({super.key});

  @override
  Widget build(BuildContext context) => Consumer<ThemeViewModel>(
        builder: (context, themeViewModel, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Topic 12 - Study Planner',
          themeMode: themeViewModel.isDark ? ThemeMode.dark : ThemeMode.light,
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
          home: const StudyPage(),
        ),
      );
}
