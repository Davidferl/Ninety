import 'package:bonne_reponse/src/theme/colors.dart';
import 'package:bonne_reponse/src/view/explore/tile.dart';
import 'package:bonne_reponse/src/view/widgets/section_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Explore extends HookWidget {
  const Explore({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SectionName(name: AppLocalizations.of(context)!.explore),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0.0, 0, 8.0),
            child: SearchAnchor(
              isFullScreen: false,
              builder:
                  (BuildContext context, SearchController searchController) {
                return SearchBar(
                  backgroundColor: const WidgetStatePropertyAll<Color>(kcGray),
                  shadowColor:
                      const WidgetStatePropertyAll<Color>(Colors.transparent),
                  textStyle: WidgetStatePropertyAll<TextStyle>(
                      Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: kcDarkGray,
                          )),
                  controller: searchController,
                  hintText: 'Search',
                  leading: const Icon(
                    Icons.search,
                    color: kcDarkGray,
                  ),
                  shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              },
              suggestionsBuilder:
                  (BuildContext context, SearchController controller) {
                return [];
              },
            ),
          ),
          Expanded(
            child: MasonryGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              itemBuilder: (BuildContext context, int index) {
                return Tile(
                  index: index,
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}
