import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/controller/settings_controller.dart';
import 'package:weather_app/core/themes/app_styles.dart';
import 'package:weather_app/view/widgets/settings/popup_options.dart';
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
              child: Column(
                children: [
                  Container(
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
                          options: (context) => PopupOptions.unit(controller),
                        ),
                        myDivider(),
                        PopupSettingsMenuItem(
                          property: "Local Weather",
                          value: "Agree",
                          options: (context) => PopupOptions.localWeather(),
                        ),
                        myDivider(),
                        PopupSettingsMenuItem(
                          isBottom: true,
                          property: "Auto refresh",
                          value:
                              "Every ${controller.refreshTime.inHours} hours",
                          options: (context) =>
                              PopupOptions.autoRefresh(controller),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF212121),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Theme",
                              style: AppStyles.bodyMediumXL,
                            ),
                            Text(
                              controller.isDarkTheme
                                  ? 'Light mode'
                                  : 'Dark mode',
                              style: AppStyles.bodyRegularL
                                  .copyWith(color: Colors.blue),
                            ),
                          ],
                        ),
                        Switch(
                          value: controller.isDarkTheme,
                          onChanged: (val) => controller.swithTheme(val),
                        )
                      ],
                    ),
                  )
                ],
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
