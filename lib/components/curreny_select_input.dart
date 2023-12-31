import 'package:cash_tab/managers/rates_manager.dart';
import 'package:cash_tab/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrencySearchInputWidget extends ConsumerWidget {
  const CurrencySearchInputWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ratesManager = ref.read(ratesManagerProvider);
    return TextField(
      onChanged: (value) async {
        await ratesManager.updateSerachView(prompt: value);
      },
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)!
            .currency_search_placeholder
            .capitalize(),
        suffixIcon: GestureDetector(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.search),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
