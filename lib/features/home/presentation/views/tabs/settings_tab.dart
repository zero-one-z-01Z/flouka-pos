import 'package:flouka_pos/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/widgets/button_widget.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: ButtonWidget(
            text: 'Logout',
            onTap: () {
              AuthProvider authProvider = Provider.of(context, listen: false);
              authProvider.showLogoutDialog();
            },
          ),
        ),
      ],
    );
  }
}
