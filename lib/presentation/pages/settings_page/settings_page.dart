import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll/application/theme/theme_cubit.dart';
import 'package:infinite_scroll/presentation/pages/settings_page/components.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool appThemeIsDark = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SettingsSectionWidget(
                sectionTitle: 'Profile',
                sectionIcon: Icon(Icons.person),
                sectionItems: [
                  SettingsSectionItem(
                    title: 'Personal setting',
                    icon: Icon(Icons.keyboard_arrow_right),
                  ),
                  SizedBox(height: 16),
                  SettingsSectionItem(
                    title: 'Reset password',
                    icon: Icon(Icons.keyboard_arrow_right),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              SettingsSectionWidget(
                sectionTitle: 'Notifications',
                sectionIcon: const Icon(Icons.notifications_active),
                sectionItems: [
                  SettingsSectionItem(
                    title: 'Reminders',
                    icon: Switch.adaptive(
                      value: true,
                      onChanged: (value) {},
                    ),
                  ),
                  const SizedBox(height: 16),
                  SettingsSectionItem(
                    title: 'New lesson available',
                    icon: Switch.adaptive(
                      value: true,
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              SettingsSectionWidget(
                sectionTitle: 'Other',
                sectionIcon: const Icon(Icons.settings),
                sectionItems: [
                  SettingsSectionItem(
                    title: 'Dark mode',
                    icon: Switch.adaptive(
                      value: appThemeIsDark,
                      onChanged: (value) {
                        appThemeIsDark = value;
                        setState(() {});
                        BlocProvider.of<ThemeCubit>(context)
                            .changeAppTheme(isDarkMode: !value);
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  const SettingsSectionItem(
                    title: 'Privacy policy',
                    icon: Icon(Icons.keyboard_arrow_right),
                  ),
                  const SizedBox(height: 16),
                  const SettingsSectionItem(
                    title: 'FAQ',
                    icon: Icon(Icons.keyboard_arrow_right),
                  ),
                  const SizedBox(height: 16),
                  const SettingsSectionItem(
                    title: 'About',
                    icon: Icon(Icons.keyboard_arrow_right),
                  ),
                  const SizedBox(height: 16),
                  const SettingsSectionItem(
                    title: 'Log Out',
                    icon: SizedBox(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
