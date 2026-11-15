import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'data/services/metrics_simulator_service.dart';
import 'presentation/viewmodels/dashboard_view_model.dart';
import 'presentation/viewmodels/theme_view_model.dart';
import 'presentation/views/dashboard_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => DashboardViewModel(
            simulator: MetricsSimulatorService(),
          )..startMonitoring(),
        ),
      ],
      child: const ProviderDemoApp(),
    ),
  );
}

class ProviderDemoApp extends StatelessWidget {
  const ProviderDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeViewModel, ThemeMode>(
      selector: (_, viewModel) => viewModel.themeMode,
      builder: (context, themeMode, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Provider Monitor',
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: themeMode,
          home: const DashboardPage(),
        );
      },
    );
  }
}
