import 'package:flutter/material.dart';

import 'social_media_icon_button.dart';

class LoginSocialMediaListWidget extends StatelessWidget {
  const LoginSocialMediaListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(3, (index) => const SocialMediaIconButton()),
    );
  }
}
