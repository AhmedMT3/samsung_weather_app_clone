import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/controller/settings_controller.dart';
import 'package:weather_app/view/widgets/settings/popup_settings_menu_item.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle:
            const TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
        title: const Text("Weather settings"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: GetBuilder<SettingsController>(
            builder: (controller) => SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF212121),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    PopupSettingsMenuItem(
                      isTop: true,
                      property: "Unit",
                      value: "˚${controller.unit}",
                      options: (context) => [
                        PopupMenuItem(
                          onTap: () => controller.setUnit('C'),
                          child: const Text("C˚"),
                        ),
                        PopupMenuItem(
                          onTap: () => controller.setUnit('F'),
                          child: const Text("F˚"),
                        ),
                      ],
                    ),
                    myDivider(),
                    PopupSettingsMenuItem(
                      property: "Local Weather",
                      value: "Agree",
                      options: (context) => const [
                        PopupMenuItem(
                          child: Text("Agree"),
                        ),
                        PopupMenuItem(
                          child: Text("Disagree"),
                        ),
                      ],
                    ),
                    myDivider(),
                    PopupSettingsMenuItem(
                      isBottm: true,
                      property: "Auto refresh",
                      value: "Every ${controller.refreshTime.inHours} hour",
                      options: (context) => [
                        PopupMenuItem(
                          child: Text("Never"),
                        ),
                        PopupMenuItem(
                          onTap: () => controller.setRefreshTime(1),
                          child: const Text("Every 1 hour"),
                        ),
                        PopupMenuItem(
                          onTap: () => controller.setRefreshTime(3),
                          child: const Text("Every 3 hour"),
                        ),
                        PopupMenuItem(
                          onTap: () => controller.setRefreshTime(6),
                          child: const Text("Every 6 hour"),
                        ),
                        PopupMenuItem(
                          onTap: () => controller.setRefreshTime(12),
                          child: const Text("Every 12 hour"),
                        ),
                        PopupMenuItem(
                          onTap: () => controller.setRefreshTime(24),
                          child: const Text("Every 24 hour"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Divider myDivider() {
    return const Divider(
      height: 0,
      indent: 15,
      endIndent: 15,
    );
  }
}
