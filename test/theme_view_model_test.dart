import 'package:flutter_test/flutter_test.dart';
import 'package:topic12_provider_demo/presentation/viewmodels/theme_view_model.dart';

void main() {
  group('ThemeViewModel', () {
    late ThemeViewModel viewModel;

    setUp(() {
      viewModel = ThemeViewModel();
    });

    tearDown(() {
      viewModel.dispose();
    });

    test('starts in light mode', () {
      expect(viewModel.isDark, isFalse);
    });

    test('toggles between light and dark modes', () {
      viewModel.toggleTheme();
      expect(viewModel.isDark, isTrue);

      viewModel.toggleTheme();
      expect(viewModel.isDark, isFalse);
    });

    test('notifies listeners when theme changes', () {
      var notifications = 0;
      viewModel.addListener(() => notifications++);

      viewModel.toggleTheme();

      expect(notifications, 1);
      expect(viewModel.isDark, isTrue);
    });
  });
}
