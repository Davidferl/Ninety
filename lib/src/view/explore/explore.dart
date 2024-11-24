import 'package:bonne_reponse/main.dart';
import 'package:bonne_reponse/injection_container.dart';
import 'package:bonne_reponse/src/group/application/group_service.dart';
import 'package:bonne_reponse/src/group/domain/group.dart';
import 'package:bonne_reponse/src/theme/colors.dart';
import 'package:bonne_reponse/src/view/explore/tile.dart';
import 'package:bonne_reponse/src/view/widgets/section_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class Explore extends HookWidget {
  const Explore({super.key});

  @override
  Widget build(BuildContext context) {
    final GroupService groupService = locator<GroupService>();

    final allGroups = useState<List<Group>>([]);
    final filteredGroups = useState<List<Group>>([]);
    useEffect(() {
      Future<void> getGroups() async {
        await groupService.getGroups().then((groups) =>
            {allGroups.value = groups, filteredGroups.value = groups});
      }

      getGroups();
      return () {};
    }, []);

    void onSearch(String query) {
      if (query.isEmpty) {
        filteredGroups.value = allGroups.value;
        return;
      }
      // check group title and group tags for query
      filteredGroups.value = allGroups.value
          .where((group) =>
              group.title.toLowerCase().contains(query.toLowerCase()) ||
              group.tags.any((tag) => tag.toLowerCase().contains(query)))
          .toList();
    }

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
                  onChanged: onSearch,
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
            child: filteredGroups.value.isEmpty
                ? const Center(
                    child:
                        CircularProgressIndicator(), // Show a loader if empty
                  )
                : MasonryGridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    itemCount: filteredGroups
                        .value.length, // Specify itemCount explicitly
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () => context.goNamed(Routes.groupViewer.name,
                            extra: filteredGroups.value[index]),
                        child: Tile(
                          group: filteredGroups.value[index],
                          index: index,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    ));
  }
}
