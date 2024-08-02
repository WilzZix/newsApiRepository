import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
                      value: true,
                      onChanged: (value) {},
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

class SettingsSectionItem extends StatelessWidget {
  const SettingsSectionItem({
    super.key,
    required this.title,
    required this.icon,
  });

  final String title;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(title), icon],
    );
  }
}

class SettingsSectionWidget extends StatelessWidget {
  const SettingsSectionWidget({
    super.key,
    required this.sectionTitle,
    required this.sectionIcon,
    required this.sectionItems,
  });

  final String sectionTitle;
  final Icon sectionIcon;
  final List<Widget> sectionItems;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            sectionIcon,
            const SizedBox(width: 8),
            Text(
              sectionTitle,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: sectionItems.length,
                  itemBuilder: (context, item) {
                    return sectionItems[item];
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
