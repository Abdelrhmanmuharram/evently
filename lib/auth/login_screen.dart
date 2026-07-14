import 'package:evently/home_screen.dart';
import 'package:evently/widgets/default_text_form_field.dart';
import 'package:flutter/material.dart';

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
                  alignment: .centerLeft,
                  child: Text(
                    'Login to your account',
                    style: textTheme.headlineSmall,
                  ),
                ),
                const SizedBox(height: 24),
                DefaultTextFormField(
                  controller: emailController,
                  onChange: (value) {},
                  hintText: 'Enter your email',
                  prefixIconImageName: 'email',
                  validator: (value) {
                    if (value == null || value.length < 2) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DefaultTextFormField(
                  controller: passwordController,
                  onChange: (value) {},
                  hintText: 'Enter your email',
                  prefixIconImageName: 'password',
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return 'Please enter your password with at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: .centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text('Forgot password?'),
                  ),
                ),
                const SizedBox(height: 48),
                DefaultElevatedButton(onPressed: login, label: 'Login'),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: .center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: textTheme.titleSmall,
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(
                        context,
                      ).pushReplacementNamed('/register'),
                      child: Text('Register'),
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
                      'OR',
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
                  onPressed: () {},
                  label: 'Sign in with Google',
                  backgroundColor: Colors.white,
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

  void login() {
    if (formKey.currentState!.validate()) {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    }
  }
}
