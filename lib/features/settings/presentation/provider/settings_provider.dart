import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/dialog/snack_bar.dart';
import '../../../../../core/helper_function/navigation.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../../../notification/presentation/provider/notifications_provider.dart';
import '../../../tickets/presentation/provider/tickets_provider.dart';
import '../../domain/entities/profile_settings_entity.dart';
import '../../domain/entities/settings_entity.dart';
import '../../domain/usecases/settings_usecases.dart';
import '../views/web_view.dart';

class SettingsProvider extends ChangeNotifier {
  SettingsEntity? settingsEntity;
  final SettingsUseCases settingsUseCases;

  SettingsProvider(this.settingsUseCases);

  List<ProfileSettingsEntity> get settingsList => [
    ProfileSettingsEntity(
      text: "notification",
      color: const Color(0xff11BD57),
      onTap: () {
        Provider.of<NotificationProvider>(Constants.globalContext(), listen: false,).goToNotificationPage();
      },
    ),
    ProfileSettingsEntity(
      text: "language",
      color: const Color(0xff144B86),
      onTap: () {
        Provider.of<LanguageProvider>(
          Constants.globalContext(),
          listen: false,
        ).showLanguageDialog();
      },
    ),
    // ProfileSettingsEntity(
    //   text: "support",
    //   color: const Color(0xff254AA5),
    //   onTap: () {
    //     Provider.of<TicketsProvider>(
    //       Constants.globalContext(),
    //       listen: false,
    //     ).goToTicketsPage();
    //   },
    // ),
    ProfileSettingsEntity(
      text: "privacy_policy",
      color: const Color(0xff70C090),
      onTap: () {
        goToPrivacy();
      },
    ),
    ProfileSettingsEntity(
      text: "terms",
      onTap: () {
        goToTerms();
      },
    ),
    ProfileSettingsEntity(
      text: "about",
      onTap: () {
        navP(WebViewPage(title: 'about', link: settingsEntity?.aboutLink ?? ""));
      },
    ),

    // NewSettingsEntity(
    //   svgImage: Assets.images.settings.rating.path,
    //   text: "rate_app",
    //   onTap: () {},
    // ),
    ProfileSettingsEntity(
      text: "delete_account",
      color: const Color(0xffF44336),
      onTap: () {
        Provider.of<AuthProvider>(
          Constants.globalContext(),
          listen: false,
        ).confirmDeleteAccount();
      },
    ),
    ProfileSettingsEntity(
      text: "logout",
      color: const Color(0xffF44336),
      onTap: () {
        Provider.of<AuthProvider>(
          Constants.globalContext(),
          listen: false,
        ).showLogoutDialog();
      },
    ),
  ];

  Future getSettings() async {
    Either<DioException, SettingsEntity> response = await settingsUseCases.getSettings();
    response.fold((l) => showToast(l.message ?? ""), (r) {
      settingsEntity = r;
      notifyListeners();
    });
  }

  void goToPrivacy() {
    navP(WebViewPage(title: 'privacy_policy', link: settingsEntity?.privacyLink ?? ""));
  }

  void goToTerms() {
    navP(WebViewPage(title: 'terms', link: settingsEntity?.termsLink ?? ""));
  }

}
