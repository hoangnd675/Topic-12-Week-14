import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'presentation/viewmodels/cart_view_model.dart';
import 'presentation/viewmodels/theme_view_model.dart';
import 'presentation/views/store_page.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CartViewModel()),
      ChangeNotifierProvider(create: (_) => ThemeViewModel()),
    ],
    child: const Topic12App(),
  ));
}

class Topic12App extends StatelessWidget {
  const Topic12App({super.key});

  @override
  Widget build(BuildContext context) => Consumer<ThemeViewModel>(
    builder: (context, theme, _) => MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Topic 12 - Provider',
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5267D8)), scaffoldBackgroundColor: const Color(0xFFF6F7FB)),
      darkTheme: ThemeData(useMaterial3: true, brightness: Brightness.dark, colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF9AA8FF), brightness: Brightness.dark)),
      themeMode: theme.isDark ? ThemeMode.dark : ThemeMode.light,
      home: const StorePage(),
    ),
  );
}
