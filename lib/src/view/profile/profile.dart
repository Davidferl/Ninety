import 'package:bonne_reponse/helpers/ui_helpers.dart';
import 'package:bonne_reponse/src/view/profile/text_count.dart';
import 'package:bonne_reponse/src/view/widgets/section_name.dart';
import 'package:bonne_reponse/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class Profile extends HookWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
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
                      const CircleAvatar(
                        radius: 54,
                        backgroundImage:
                            AssetImage('assets/images/profile_avatar.png'),
                      ),
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
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextCount(
                                      name: "Objectives",
                                      count: 5,
                                    ),
                                    horizontalSpaceMedium,
                                    TextCount(
                                      name: "Groups",
                                      count: 12,
                                    ),
                                    horizontalSpaceMedium,
                                    TextCount(
                                      name: "Logs",
                                      count: 48,
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
