import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app/core/themes/app_themes.dart';
import 'package:weather_app/view/widgets/settings/setting_menu_widget.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      padding: EdgeInsets.zero, child: Text("C˚"),),
                    PopupMenuItem(child: Text("F˚")),
                  ],
                  child: SettingMenuWidget(
                    property: "Units",
                    value: "C˚",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
