import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../provider/settings_provider.dart';
import '../widgets/settings_header_widget.dart';
import '../widgets/settings_widget.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: SizedBox(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(height: 2.h),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 6.w),
                //   child: const SettingsHeaderWidget(),
                // ),
                SizedBox(height: 4.h),
                SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    spacing: 3.w,
                    runSpacing: 0.h,
                    children: List.generate(
                      settingsProvider.settingsList.length,
                      (index) => SettingsWidget(
                        settingsEntity: settingsProvider.settingsList[index],
                      ),
                    ),
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
