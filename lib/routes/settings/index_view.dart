import 'package:cash_tab/utils.dart';
import 'package:cash_tab/language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class SettingsView extends ConsumerStatefulWidget {
  const SettingsView({super.key, required this.title});

  final String title;

  @override
  SettingsViewState createState() => SettingsViewState();
}

class MenuItem {
  MenuItem({required this.title, required this.onTap});

  String title;
  void Function() onTap;
}

class SettingsViewState extends ConsumerState<SettingsView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final router = GoRouter.of(context);

    final menuItems = [
      MenuItem(
        title: l10n.language.capitalize(),
        onTap: () {
          router.push('/settings/language');
        },
      ),
      MenuItem(
        title: l10n.appereance.capitalize(),
        onTap: () {
          router.push('/settings/appereance');
        },
      )
    ];

    return Scaffold(
      appBar: AppBar(title: Text(widget.title.capitalize())),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 24,
        ),
        child: ListView.separated(
          itemCount: menuItems.length,
          separatorBuilder: (context, index) => const Divider(
            height: 1, // Customize the color of the separator here
          ),
          itemBuilder: (context, index) => ListTile(
            title: Text(menuItems[index].title),
            trailing: Icon(
              Icons.arrow_forward,
              color: theme.iconTheme.color,
            ),
            onTap: menuItems[index].onTap,
          ),
        ),
      ),
    );
  }
}
