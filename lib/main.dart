import 'package:cash_tab/managers/rates_manager.dart';
import 'package:cash_tab/providers/settings_providers.dart';
import 'package:cash_tab/routes/router.dart';
import 'package:cash_tab/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

var uuidLib = const Uuid();

void main() async {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    final languageNotifier = ref.read(languageProvider.notifier);
    final homeProvider = ref.read(ratesManagerProvider);
    Future.delayed(Duration.zero, () async {
      await languageNotifier.init();
      await homeProvider.settingsLoad();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final language = ref.watch(languageProvider);
    final darkMode = ref.watch(darkThemeProvider);
    return MaterialApp.router(
      title: 'CashTab',
      routerConfig: routerConfig,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(language),
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
    );
  }
}
