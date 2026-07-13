import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../app_theme.dart';
import '../../models/language_model.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
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
            Text('User Name', style: textTheme.titleLarge),
            const SizedBox(height: 4),
            Text('User Email', style: textTheme.titleSmall),
            const SizedBox(height: 32),
            SwitchListTile(
              value: true,
              onChanged: (value) {},
              title: Text('Dark Mode'),
              tileColor: AppTheme.white,
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
              trailing: SvgPicture.asset('assets/icons/logout.svg'),
            ),
          ],
        ),
      ),
    );
  }
}
