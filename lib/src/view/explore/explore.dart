import 'package:bonne_reponse/helpers/ui_helpers.dart';
import 'package:bonne_reponse/main.dart';
import 'package:bonne_reponse/injection_container.dart';
import 'package:bonne_reponse/src/authentication/hooks/use_authentication.dart';
import 'package:bonne_reponse/src/group/application/group_service.dart';
import 'package:bonne_reponse/src/group/domain/group.dart';
import 'package:bonne_reponse/src/theme/colors.dart';
import 'package:bonne_reponse/src/view/explore/tile.dart';
import 'package:bonne_reponse/src/view/widgets/bottom_button.dart';
import 'package:bonne_reponse/src/view/widgets/custom_text_input.dart';
import 'package:bonne_reponse/src/view/widgets/image_selector.dart';
import 'package:bonne_reponse/src/view/widgets/section_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class Explore extends HookWidget {
  const Explore({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = useAuthentication();

    final groupService = locator<GroupService>();
    final titleController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final tagsController = useTextEditingController();

    final isSubmitting = useState(false);
    final formKey = useMemoized(() => GlobalKey<FormState>());

    final ValueNotifier<XFile?> selectedImage = useState<XFile?>(null);

    Future<void> showCreateGroupDialog(
        BuildContext context, Function callback) async {
      void clearForm() {
        titleController.clear();
        descriptionController.clear();
        selectedImage.value = null;
        tagsController.clear();
      }

      Future<void> submitForm() async {
        if (!formKey.currentState!.validate()) return;
        if (selectedImage.value == null) return;

        final title = titleController.text.trim();
        final description = descriptionController.text.trim();
        final tags = tagsController.text
            .split(',')
            .map((tag) => tag.trim())
            .where((tag) => tag.isNotEmpty)
            .toList();

        isSubmitting.value = true;

        try {
          await groupService.addGroup(
              title, description, selectedImage.value!, tags);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Group added successfully!')),
          );
          clearForm();
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error adding group: $e')),
          );
        } finally {
          isSubmitting.value = false;
          callback();
        }
      }

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              backgroundColor: kcBackground,
              insetPadding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: screenWidth(context),
                  height: 600,
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text('Create a new group',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: kcSecondaryVariant,
                                      fontSize: 20,
                                    )),
                            verticalSpace(32),
                            CustomTextInput(
                              controller: titleController,
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? 'Title is required'
                                      : null,
                              labelText: "Title",
                            ),
                            verticalSpace(16),
                            CustomTextInput(
                              controller: descriptionController,
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? 'Description is required'
                                      : null,
                              maxLines: 3,
                              labelText: 'Description',
                            ),
                            verticalSpace(16),
                            ImageSelector(selectedImage: selectedImage),
                            verticalSpace(16),
                            CustomTextInput(
                              controller: tagsController,
                              labelText: "Tags (comma separated)",
                            ),
                            verticalSpace(32),
                          ],
                        ),
                        BottomButton(
                          title: "Submit",
                          color: kcPrimary,
                          isDisabled: isSubmitting.value,
                          onPressed: isSubmitting.value ? null : submitForm,
                        ),
                      ],
                    ),
                  ),
                ),
              ));
        },
      );
    }

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
          Stack(
            children: [
              SectionName(name: AppLocalizations.of(context)!.explore),
              Positioned(
                  right: 0,
                  child: IconButton(
                    icon: const Icon(Icons.add_circle,
                        size: 30, color: kcPrimary),
                    onPressed: () => showCreateGroupDialog(
                        context,
                        // pass async callback to refetch groups and context pop
                        () async => {
                              await groupService.getGroups().then((groups) {
                                allGroups.value = groups;
                                filteredGroups.value = groups;
                                context.pop();
                              })
                            }), // Modified line
                  ))
            ],
          ),
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
                            userId: auth.user!.uid),
                      );
                    },
                  ),
          ),
        ],
      ),
    ));
  }
}
