import 'package:bonne_reponse/src/view/explore/tile.dart';
import 'package:bonne_reponse/src/view/widgets/section_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Explore extends HookWidget {
  const Explore({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          const SectionName(name: 'Explore Groups'),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0.0, 0, 8.0),
            child: SearchAnchor(
              isFullScreen: false,
              builder:
                  (BuildContext context, SearchController searchController) {
                return SearchBar(
                  controller: searchController,
                  hintText: 'Search groups...',
                  leading: const Icon(Icons.search),
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
