import 'package:evently/firebase_service.dart';
import 'package:evently/home_screen.dart';
import 'package:evently/models/user_model.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/widgets/default_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../providers/settings_provider.dart';
import '../ui_utils.dart';
import '../widgets/default_elevated_button.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Image.asset('assets/images/logo.png', height: 27),
                const SizedBox(height: 48),
                Align(
                  alignment: settingsProvider.isArabic
                      ? .centerRight
                      : .centerLeft,
                  child: Text(
                    AppLocalizations.of(context)!.loginToYourAccount,
                    style: textTheme.headlineSmall,
                  ),
                ),
                const SizedBox(height: 24),
                DefaultTextFormField(
                  controller: emailController,
                  onChange: (value) {},
                  hintText: AppLocalizations.of(context)!.enterYourEmail,
                  prefixIconImageName: 'email',
                  validator: (value) {
                    if (value == null || value.length < 2) {
                      return AppLocalizations.of(context)!.emailValidator;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DefaultTextFormField(
                  controller: passwordController,
                  onChange: (value) {},
                  hintText: AppLocalizations.of(context)!.enterYourPassword,
                  prefixIconImageName: 'password',
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return AppLocalizations.of(context)!.passwordValidator;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: .centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(AppLocalizations.of(context)!.forgotPassword),
                  ),
                ),
                const SizedBox(height: 48),
                DefaultElevatedButton(
                  onPressed: login,
                  label: AppLocalizations.of(context)!.login,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: .center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.doNotHaveAnAccount,
                      style: textTheme.titleSmall,
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(
                        context,
                      ).pushReplacementNamed('/register'),
                      child: Text(AppLocalizations.of(context)!.register),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: .center,
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width * .35,
                      height: 1,
                      color: Colors.grey.withAlpha(50),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      AppLocalizations.of(context)!.or,
                      style: textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      width: MediaQuery.sizeOf(context).width * .35,
                      height: 1,
                      color: Colors.grey.withAlpha(50),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                DefaultElevatedButton(
                  onPressed: () async {
                    final user = await FirebaseService.signInWithGoogle();
                    if (user != null) {
                      Provider.of<UserProvider>(context, listen: false)
                          .updateCurrentUser(user);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()),
                      );
                    }
                  },
                  label: AppLocalizations.of(context)!.loginInWithGoogle,
                  backgroundColor: Theme.of(context).cardColor,
                  foregroundColor: Theme.of(context).primaryColor,
                  icon: 'google',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() {
    if (formKey.currentState!.validate()) {
      FirebaseService.login(emailController.text, passwordController.text)
          .then((user) {
            Provider.of<UserProvider>(
              context,
              listen: false,
            ).updateCurrentUser(user);
            Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
          })
          .catchError((error) {
            String? errorMessage;
            if (error is FirebaseAuthException) {
              errorMessage = error.message;
            }
            UIUtils.showErrorMessage(errorMessage);
          });
    }
  }
}
