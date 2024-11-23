import 'package:bonne_reponse/helpers/ui_helpers.dart';
import 'package:bonne_reponse/main.dart';
import 'package:bonne_reponse/src/theme/colors.dart';
import 'package:bonne_reponse/src/authentication/validators.dart';
import 'package:bonne_reponse/src/view/widgets/custom_text_input.dart';
import 'package:bonne_reponse/src/view/widgets/floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../exceptions/exceptions.dart';
import '../widgets/error_dialog.dart';
import '../../authentication/hooks/use_authentication.dart';

class Login extends HookWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final auth = useAuthentication();

    void onLogin() {
      context.goNamed(Routes.home.name);
    }

    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    final isLoading = useState(false);

    Future<void> login() async {
      final email = emailController.text;
      final password = passwordController.text;

      if (formKey.currentState!.validate()) {
        isLoading.value = true;

        try {
          isLoading.value = false;
          await auth.login(email, password, onLogin);
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
          padding: const EdgeInsets.fromLTRB(24, 84, 24, 24),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/ninety_small_logo.png',
                ),
                verticalSpace(36),
                Text(
                  AppLocalizations.of(context)!.welcome_back,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: kcPrimaryVariant,
                      ),
                ),
                verticalSpace(40),
                CustomTextInput(
                  textInputAction: TextInputAction.next,
                  controller: emailController,
                  validator: validateEmail,
                  keyboardType: TextInputType.emailAddress,
                  labelText: AppLocalizations.of(context)!.email,
                ),
                verticalSpace(32),
                CustomTextInput(
                  textInputAction: TextInputAction.done,
                  controller: passwordController,
                  validator: validatePassword,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  labelText: AppLocalizations.of(context)!.password,
                ),
                verticalSpace(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.dont_have_account,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: kcLightSecondary),
                    ),
                    TextButton(
                      onPressed: () => context.goNamed(Routes.signup.name),
                      child: Text(
                        AppLocalizations.of(context)!.sign_up,
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
      floatingActionButton: GradientFloatingActionButton(onPressed: () => login(), icon: const Icon(Icons.arrow_forward_ios)),
    );
  }
}
