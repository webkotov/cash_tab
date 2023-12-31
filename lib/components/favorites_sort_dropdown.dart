import 'package:cash_tab/managers/favorites_manager.dart';
import 'package:cash_tab/providers/db_provider.dart';
import 'package:cash_tab/providers/favorites_providers.dart';
import 'package:cash_tab/routes/favorites/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cash_tab/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesSortDropdown extends ConsumerStatefulWidget {
  const FavoritesSortDropdown({super.key});

  @override
  ConsumerState<FavoritesSortDropdown> createState() =>
      _FavoritesSortDropdownState();
}

class _FavoritesSortDropdownState extends ConsumerState<FavoritesSortDropdown> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final Map<FavoritesSort, String> lables = {
      FavoritesSort.recents: l10n.sort_recents.capitalize(),
      FavoritesSort.az: l10n.sort_az.capitalize(),
    };
    final Map<String, FavoritesSort> values = {
      l10n.sort_recents.capitalize(): FavoritesSort.recents,
      l10n.sort_az.capitalize(): FavoritesSort.az
    };

    final currentValue = ref.watch(favoritesSortState);
    final notifier = ref.watch(favoritesSortState.notifier);
    final favoritesManager = ref.read(favoritesManagerProvider);

    return DropdownButton<String>(
      value: lables[currentValue],
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      underline: Container(
        height: 2,
      ),
      onChanged: (String? value) async {
        notifier.state = values[value]!;
        await favoritesManager.updateViewList();
      },
      items: lables.values.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
