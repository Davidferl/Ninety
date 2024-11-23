import 'package:bonne_reponse/helpers/ui_helpers.dart';
import 'package:bonne_reponse/main.dart';
import 'package:bonne_reponse/src/theme/colors.dart';
import 'package:bonne_reponse/src/view/account/validators.dart';
import 'package:bonne_reponse/src/view/widgets/bottom_button.dart';
import 'package:bonne_reponse/src/view/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Login extends HookWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    final isLoading = useState(false);

    Future<void> login() async {
      final email = emailController.text;
      final password = passwordController.text;

      // if (formKey.currentState!.validate()) {
      //   isLoading.value = true;

      //   try {
      //     isLoading.value = false;
      //     AuthService authService = locator<AuthService>();
      //     await authService.login(email, password);

      //     if (context.mounted) {
      //       Navigator.pushReplacementNamed(context, Routes.hub.name);
      //     }
      //   } on AuthenticationException catch (e) {
      //     isLoading.value = false;
      //     showDialog(
      //       context: context,
      //       builder: (BuildContext context) => ErrorDialog(
      //         title: "Oops",
      //         message: e.message,
      //         buttonText: "OK",
      //       ),
      //     );
      //   }
      // }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 76, 20, 24),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ECOHUB",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: kcPrimary,
                      ),
                ),
                verticalSpace(36),
                Text(
                  "Login",
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
                  labelText: "Email",
                ),
                verticalSpace(32),
                CustomTextInput(
                  textInputAction: TextInputAction.done,
                  controller: passwordController,
                  validator: validatePassword,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  labelText: "Password",
                ),
                verticalSpace(96),
                BottomButton(
                  onPressed: () => login(),
                  title: "Login",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: kcLightSecondary),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushReplacementNamed(
                          context, Routes.home.name),
                      child: Text(
                        "Sign up",
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
