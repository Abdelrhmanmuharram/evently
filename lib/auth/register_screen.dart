import 'package:evently/firebase_service.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/ui_utils.dart';
import 'package:evently/widgets/default_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_theme.dart';
import '../home_screen.dart';
import '../providers/settings_provider.dart';
import '../providers/user_provider.dart';
import '../widgets/default_elevated_button.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/register';
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 16),
                Image.asset('assets/images/logo.png', width: 142, height: 27),
                const SizedBox(height: 47),
                Align(
                  alignment: settingsProvider.isArabic
                      ? .centerRight
                      : .centerLeft,
                  child: Text(
                    appLocalizations.createYourAccount,
                    style: textTheme.headlineSmall,
                  ),
                ),
                const SizedBox(height: 24),
                DefaultTextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.length < 2) {
                      return appLocalizations.nameValidator;
                    }
                    return null;
                  },
                  hintText: appLocalizations.enterYourName,
                  prefixIconImageName: 'user',
                ),
                const SizedBox(height: 16),
                DefaultTextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.length < 2) {
                      return appLocalizations.emailValidator;
                    }
                    return null;
                  },
                  hintText: appLocalizations.enterYourEmail,
                  prefixIconImageName: 'email',
                ),
                const SizedBox(height: 16),
                DefaultTextFormField(
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return appLocalizations.passwordValidator;
                    }
                    return null;
                  },
                  hintText: appLocalizations.enterYourPassword,
                  prefixIconImageName: 'password',
                  isPassword: true,
                ),
                const SizedBox(height: 52),
                DefaultElevatedButton(
                  onPressed: register,
                  label: appLocalizations.register,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: .center,
                  children: [
                    Text(
                      appLocalizations.alreadyHaveAnAccount,
                      style: textTheme.titleSmall,
                    ),
                    TextButton(
                      onPressed: () =>
                          Navigator.of(context).pushReplacementNamed('/login'),
                      child: Text(appLocalizations.login),
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
                      color: AppTheme.secondText.withAlpha(50),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      appLocalizations.or,
                      style: textTheme.titleMedium!.copyWith(
                        color: AppTheme.primary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      width: MediaQuery.sizeOf(context).width * .35,
                      height: 1,
                      color: AppTheme.secondText.withAlpha(50),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                DefaultElevatedButton(
                  onPressed: () {},
                  label: appLocalizations.signUpWithGoogle,
                  backgroundColor: Theme.of(context).cardColor,
                  foregroundColor: Theme.of(context).primaryColor,
                  icon: 'google',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void register() {
    if (formKey.currentState!.validate()) {
      FirebaseService.register(
            nameController.text,
            emailController.text,
            passwordController.text,
          )
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
