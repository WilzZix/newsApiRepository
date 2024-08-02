import 'package:flutter/material.dart';

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
      //      color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
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
