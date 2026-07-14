import 'package:evently/widgets/default_text_form_field.dart';
import 'package:flutter/material.dart';

import '../app_theme.dart';
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

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Image.asset('assets/images/logo.png', width: 142, height: 27),
              const SizedBox(height: 47),
              Align(
                alignment: .centerLeft,
                child: Text(
                  'Create your account',
                  style: textTheme.headlineSmall,
                ),
              ),
              const SizedBox(height: 24),
              DefaultTextFormField(
                controller: nameController,
                validator: (value) {
                  if (value == null || value.length < 2) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                hintText: 'Enter your name',
                prefixIconImageName: 'user',
              ),
              const SizedBox(height: 16),
              DefaultTextFormField(
                controller: emailController,
                validator: (value) {
                  if (value == null || value.length < 2) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                hintText: 'Enter your email',
                prefixIconImageName: 'email',
              ),
              const SizedBox(height: 16),
              DefaultTextFormField(
                controller: passwordController,
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return 'Please enter your password with at least 6 characters';
                  }
                  return null;
                },
                hintText: 'Enter your password',
                prefixIconImageName: 'password',
                isPassword: true,
              ),
              const SizedBox(height: 52),
              DefaultElevatedButton(onPressed: () {}, label: 'Register'),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: .center,
                children: [
                  Text('Already have an account?', style: textTheme.titleSmall),
                  TextButton(onPressed: () {}, child: Text('Login')),
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
                    'OR',
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
                label: 'Sign up with Google',
                backgroundColor: AppTheme.white,
                foregroundColor: AppTheme.primary,
                icon: 'google',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
