import 'package:bonne_reponse/main.dart';
import 'package:bonne_reponse/src/authentication/services/auth_service.dart';
import 'package:bonne_reponse/src/authentication/validators.dart';
import 'package:bonne_reponse/src/exceptions/exceptions.dart';
import 'package:bonne_reponse/src/user/infra/user_repo.dart';
import 'package:bonne_reponse/src/view/widgets/custom_auto_complete.dart';
import 'package:bonne_reponse/src/view/widgets/custom_text_input.dart';
import 'package:bonne_reponse/src/view/widgets/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../helpers/ui_helpers.dart';
import '../../../injection_container.dart';
import '../../theme/colors.dart';
import '../widgets/bottom_button.dart';

class Register extends HookWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final firstNameController = useTextEditingController();
    final lastNameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    final isLoading = useState(false);

    Future<void> register() async {
      final email = emailController.text;
      final password = passwordController.text;
      final String name = firstNameController.text;
      final String surname = lastNameController.text;

      if (formKey.currentState!.validate()) {
        isLoading.value = true;

        try {
          AuthService authService = locator<AuthService>();
          await authService.register(email, password);

          try {
            isLoading.value = false;
            UserRepository profileRepository = locator<UserRepository>();
            final userId = authService.currentUser!.uid;
            await profileRepository.addUser(userId, name, surname, "123");

            if (context.mounted) {
              context.goNamed(Routes.home.name);
            }
          } on FirestoreException catch (e) {
            isLoading.value = false;
            showDialog(
              context: context,
              builder: (BuildContext context) => ErrorDialog(
                title: AppLocalizations.of(context)!.unknown_error,
                message: e.message,
                buttonText: "OK",
              ),
            );
          }
        } on AuthenticationException catch (e) {
          isLoading.value = false;
          showDialog(
            context: context,
            builder: (BuildContext context) => ErrorDialog(
              title: AppLocalizations.of(context)!.unknown_error,
              message: e.message,
              buttonText: "OK",
            ),
          );
        }
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 76, 24, 24),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ninety",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: kcPrimary,
                      ),
                ),
                verticalSpace(36),
                Text(
                  AppLocalizations.of(context)!.sign_up,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: kcPrimaryVariant,
                      ),
                ),
                verticalSpace(36),
                CustomTextInput(
                  textInputAction: TextInputAction.next,
                  controller: firstNameController,
                  validator: validateName,
                  keyboardType: TextInputType.name,
                  labelText: AppLocalizations.of(context)!.first_name,
                ),
                verticalSpace(24),
                CustomTextInput(
                  textInputAction: TextInputAction.next,
                  controller: lastNameController,
                  validator: validateName,
                  keyboardType: TextInputType.name,
                  labelText: AppLocalizations.of(context)!.last_name,
                ),
                verticalSpace(24),
                CustomTextInput(
                  textInputAction: TextInputAction.next,
                  controller: emailController,
                  validator: validateEmail,
                  keyboardType: TextInputType.emailAddress,
                  labelText: AppLocalizations.of(context)!.email,
                ),
                verticalSpace(24),
                CustomTextInput(
                  textInputAction: TextInputAction.done,
                  controller: passwordController,
                  validator: validatePassword,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  labelText: AppLocalizations.of(context)!.password,
                ),
                verticalSpace(48),
                BottomButton(
                  onPressed: () => register(),
                  title: AppLocalizations.of(context)!.sign_up,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.already_have_account,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: kcLightSecondary),
                    ),
                    TextButton(
                      onPressed: () => context.goNamed(Routes.login.name),
                      child: Text(
                        AppLocalizations.of(context)!.login.toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: kcPrimaryVariant),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
