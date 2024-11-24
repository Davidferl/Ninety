import 'package:bonne_reponse/helpers/ui_helpers.dart';
import 'package:bonne_reponse/injection_container.dart';
import 'package:bonne_reponse/src/authentication/hooks/use_authentication.dart';
import 'package:bonne_reponse/src/authentication/services/auth_service.dart';
import 'package:bonne_reponse/src/group/application/group_service.dart';
import 'package:bonne_reponse/src/theme/colors.dart';
import 'package:bonne_reponse/src/user/domain/user.dart';
import 'package:bonne_reponse/src/user/services/user_service.dart';
import 'package:bonne_reponse/src/view/profile/text_count.dart';
import 'package:bonne_reponse/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boring_avatars/flutter_boring_avatars.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class Profile extends HookWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    AuthService authService = locator<AuthService>();
    GroupService groupService = locator<GroupService>();
    UserService userService = locator<UserService>();

    final user = useState<User?>(null);

    useEffect(() {
      Future<void> getUser() async {
        try {
          final fetchedUser = await userService.getCurrentUser();
          user.value = fetchedUser;
        } catch (e) {}
      }

      getUser();
      return () {};
    }, []);

    final groupNumber = useState<int>(0);
    final objectiveNumber = useState<int>(0);
    final logNumber = useState<int>(0);

    final auth = useAuthentication();

    const colorPalette =
        BoringAvatarPalette([kcPrimary, kcSecondaryVariant, kcLightPrimary]);

    useEffect(() {
      Future<void> getGroupNumber() async {
        try {
          final groups =
              await groupService.getMemberGroups(authService.currentUser!.uid);
          groupNumber.value = groups.length;
        } catch (e) {}
      }

      Future<void> getObjectiveNumber() async {
        try {
          final objectives = await groupService.getObjectives();
          objectiveNumber.value = objectives.length;
        } catch (e) {}
      }

      Future<void> getLogNumber() async {
        try {
          final logs = await groupService.getAllPostsOfConnectedUser();
          logNumber.value = logs.length;
        } catch (e) {}
      }

      getGroupNumber();
      getObjectiveNumber();
      getLogNumber();
      return () {};
    }, []);

    return Stack(
      children: [
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 56),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: GestureDetector(
                          onTap: () => context.goNamed(Routes.settings.name),
                          child: const Icon(Icons.settings,
                              color: kcSecondaryVariant)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 54,
                          child: BoringAvatar(
                              palette: colorPalette,
                              shape: const OvalBorder(),
                              name: auth.user!.uid,
                              type: BoringAvatarType.beam),
                        ),
                        horizontalSpace(8),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user.value?.name ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!
                                        .copyWith(
                                          color: kcSecondaryVariant,
                                        ),
                                  ),
                                  Text(
                                    'New York, USA',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: kcDarkGray,
                                        ),
                                  ),
                                  verticalSpaceSmall,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextCount(
                                        name: "Objectives",
                                        count: objectiveNumber.value,
                                      ),
                                      horizontalSpaceMedium,
                                      TextCount(
                                        name: "Groups",
                                        count: groupNumber.value,
                                      ),
                                      horizontalSpaceMedium,
                                      TextCount(
                                        name: "Logs",
                                        count: logNumber.value,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  verticalSpaceMedium,
                  Card(
                    elevation: 0,
                    margin: const EdgeInsets.only(
                        left: 8, right: 8, top: 4, bottom: 4),
                    child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'About me',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(
                                    color: kcPrimaryVariant,
                                  ),
                            ),
                            verticalSpaceSmall,
                            Text(
                              'I am a software engineer with a passion for mobile development. I love to learn new things and I am always looking for new challenges.',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w500),
                            ),
                          ],
                        )),
                  ),
                  const Divider(
                    color: kcDivider,
                    thickness: 1,
                  ),
                  Card(
                    elevation: 0,
                    margin: const EdgeInsets.only(
                        left: 8, right: 8, top: 4, bottom: 4),
                    child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Date of birth',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .copyWith(
                                        color: kcPrimaryVariant,
                                      ),
                                ),
                                const Icon(Icons.cake, color: kcPrimaryVariant),
                              ],
                            ),
                            verticalSpaceSmall,
                            Text(
                              'December 12th, 1995',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w500),
                            ),
                          ],
                        )),
                  ),
                  const Divider(
                    color: kcDivider,
                    thickness: 1,
                  ),
                  Card(
                    elevation: 0,
                    margin: const EdgeInsets.only(
                        left: 8, right: 8, top: 4, bottom: 4),
                    child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Country',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .copyWith(
                                        color: kcPrimaryVariant,
                                      ),
                                ),
                                const Icon(Icons.flag, color: kcPrimaryVariant),
                              ],
                            ),
                            verticalSpaceSmall,
                            Text(
                              'United States',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w500),
                            ),
                          ],
                        )),
                  ),
                  const Divider(
                    color: kcDivider,
                    thickness: 1,
                  ),
                  Card(
                    elevation: 0,
                    margin: const EdgeInsets.only(
                        left: 8, right: 8, top: 4, bottom: 4),
                    child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Joined on',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .copyWith(
                                        color: kcPrimaryVariant,
                                      ),
                                ),
                                const Icon(Icons.calendar_today,
                                    color: kcPrimaryVariant),
                              ],
                            ),
                            verticalSpaceSmall,
                            Text(
                              'March 22, 2020',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w500),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
