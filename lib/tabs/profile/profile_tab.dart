import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../app_theme.dart';
import '../../auth/login_screen.dart';
import '../../firebase_service.dart';
import '../../models/language_model.dart';
import '../../models/user_model.dart';
import '../../providers/settings_provider.dart';
import '../../providers/user_provider.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel currentUser = Provider.of<UserProvider>(context).currentUser!;
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    Color primaryColor = Theme.of(context).primaryColor;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 32),
            CircleAvatar(
              radius: 58,
              backgroundImage: AssetImage('assets/images/route_logo.png'),
            ),
            const SizedBox(height: 16),
            Text(currentUser.name, style: textTheme.titleLarge),
            const SizedBox(height: 4),
            Text(currentUser.email, style: textTheme.titleSmall),
            const SizedBox(height: 32),
            SwitchListTile(
              value: settingsProvider.isDark,
              onChanged: (isDark) {
                settingsProvider.changeTheme(isDark ? .dark : .light);
              },
              title: Text('Dark Mode'),
              tileColor: Theme.of(context).cardColor,
              activeTrackColor: primaryColor,
              activeThumbColor: AppTheme.switchBackground,
              thumbColor: WidgetStatePropertyAll(AppTheme.white),
              trackOutlineColor: WidgetStatePropertyAll(Colors.transparent),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: Text('Language'),
              trailing: DropdownButton(
                value: 'en',
                underline: const SizedBox(),
                items: LanguageModel.languages
                    .map(
                      (language) => DropdownMenuItem(
                        value: language.code,
                        child: Text(language.name),
                      ),
                    )
                    .toList(),
                onChanged: (value) {},
                borderRadius: BorderRadius.circular(16),
                dropdownColor: AppTheme.white,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: Text('Logout'),
              trailing: InkWell(
                onTap: () => FirebaseService.logout().then((_) {
                  Navigator.of(
                    context,
                  ).pushReplacementNamed(LoginScreen.routeName).then((_) {
                    Provider.of<UserProvider>(context).updateCurrentUser(null);
                  });
                }),
                child: SvgPicture.asset('assets/icons/logout.svg'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
