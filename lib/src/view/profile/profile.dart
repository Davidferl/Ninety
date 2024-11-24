import 'package:bonne_reponse/helpers/ui_helpers.dart';
import 'package:bonne_reponse/injection_container.dart';
import 'package:bonne_reponse/src/authentication/hooks/use_authentication.dart';
import 'package:bonne_reponse/src/authentication/services/auth_service.dart';
import 'package:bonne_reponse/src/group/application/group_service.dart';
import 'package:bonne_reponse/src/theme/colors.dart';
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
        Positioned.fill(
          child: Image.asset(
            'assets/images/profile_background.png',
            // Replace with your image asset path
            fit: BoxFit.cover,
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 56),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: GestureDetector(
                        onTap: () => context.goNamed(Routes.settings.name),
                        child: const Icon(Icons.settings, color: Colors.white)),
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
                                  'John Doe',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                                Text(
                                  'New York, USA',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: Colors.white.withOpacity(0.5),
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}
