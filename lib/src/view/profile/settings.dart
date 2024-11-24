import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import '../../../main.dart';
import '../../authentication/hooks/use_authentication.dart';
import '../../theme/colors.dart';
import '../widgets/section_name.dart';

class Settings extends HookWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = useAuthentication();

    void onLogout() {
      context.goNamed(Routes.login.name);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () => context.pop(''),
                      icon: const Icon(Icons.chevron_left,
                          color: Colors.black, size: 30)),
                  const SectionName(name: 'Settings'),
                  IconButton(
                      onPressed: () => {},
                      icon: const Icon(
                        Icons.more_horiz,
                        color: kcDarkGray,
                      ))
                ],
              ),
              GestureDetector(
                onTap: () => auth.logout(onLogout),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.logout,
                            color: kcPrimaryVariant,
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Text(
                            'Logout',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: kcPrimaryVariant,
                                ),
                          ),
                        ],
                      ),
                      Text(
                        '>',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: kcPrimaryVariant,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
