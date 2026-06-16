// ignore_for_file: unused_local_variable

import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flouka_pos/features/home/domain/entity/navigation_entity.dart';
import 'package:flouka_pos/features/home/presentation/views/home_view.dart';
import 'package:flouka_pos/features/orders/presentation/providers/orders_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/dialog/confirm_dialog.dart';
import '../../../../core/dialog/confirm_pop_up_dialog.dart';
import '../../../../core/dialog/snack_bar.dart';
import '../../../../core/helper_function/api.dart';
import '../../../../core/helper_function/loading.dart';
import '../../../../core/helper_function/navigation.dart';
import '../../../../core/helper_function/prefs.dart';
import '../../../../core/helper_function/text_form_field_validation.dart';
import '../../../../core/models/text_field_model.dart';
import '../../../home/domain/entity/info_card_entity.dart';
import '../../../home/domain/entity/stat_item_entity.dart';
import '../../../home/domain/entity/stats_card_entity.dart';
import '../../../home/presentation/providers/home_provider.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/user_usecases.dart';
import '../views/login_view.dart';
import '../views/user_type_page.dart';

class AuthProvider extends ChangeNotifier {
  UserEntity? userEntity;
  final AuthUseCase userUseCase;

  bool isUser = true;

  AuthProvider(this.userUseCase);

  void goToLoginView() {
    bool isStore = sharedPreferences.getBool('isStore') ?? true;
    if(isStore){
      loginTextFieldList = [
        TextFieldModel(
          label: LanguageProvider.translate("inputs", "user_name"),
          key: "user_name",
          controller: TextEditingController(),
          textInputType: TextInputType.text,
          validator: (value) => validateUserName(value),
        ),
        TextFieldModel(
          label: LanguageProvider.translate("inputs", "Password"),
          controller: TextEditingController(),
          textInputType: TextInputType.visiblePassword,
          validator: (value) => validatePassword(value),
          key: "password",
        ),
      ];
    }else{
      loginTextFieldList = [
        TextFieldModel(
          label: LanguageProvider.translate("inputs", "phone_number"),
          key: "phone",
          controller: TextEditingController(),
          textInputType: TextInputType.phone,
          validator: (value) => validatePhone(value),
        ),
        TextFieldModel(
          label: LanguageProvider.translate("inputs", "Password"),
          controller: TextEditingController(),
          textInputType: TextInputType.visiblePassword,
          validator: (value) => validatePassword(value),
          key: "password",
        ),
      ];
    }

    navP(const LoginView());
  }

  bool isStore = true;
  void changeUserType({required bool isStore}) {
    this.isStore = isStore;
    sharedPreferences.setBool('isStore', isStore);
    print('${isStore}');
    notifyListeners();
  }
  void goToUserTypePage() {
    changeUserType(isStore: isStore);
    sharedPreferences.remove('token');
    navPR(const UserTypePage());
  }

  /// ----------- Login Logic -----------
  Future<void> socialLogin({required String loginFrom}) async {
    Map<String, dynamic> data = {};
    data['login_from'] = loginFrom;
    if (loginFrom == 'google') {
      data['name'] = googleUser!.displayName;
      data['email'] = googleUser!.email;
      data['image'] = googleUser!.photoUrl;
    }
    data['token'] = await FirebaseMessaging.instance.getToken() ?? "123";
    loading();
    final result = await userUseCase.socialLogin(data);
    navPop();
    result.fold((l) => showToast(l.message!), (r) {
      loginSuccess(r);
      userEntity = r;
    });
  }

  Future<void> deleteAccount() async {
    loading();
    await userUseCase.deleteAccount();
    await sharedPreferences.remove('token');
    navPop();
    ApiHandel.getInstance.updateHeader('');
    goToUserTypePage();
  }

  void loginSuccess(UserEntity userEntity) {
    this.userEntity = userEntity;
    if (userEntity.token != null) {
      ApiHandel.getInstance.updateHeader(userEntity.token!);
      sharedPreferences.setString('token', userEntity.token!);
    }
    getUserData(userEntity);
    Provider.of<HomeProvider>(Constants.globalContext(), listen: false,).goToHomeView();
  }

  void getUserData(UserEntity userEntity) {
    bool isStore =sharedPreferences.getBool('isStore') ?? false;
    statsCards = [
      StatsCardEntity(
        title: LanguageProvider.translate('global', 'total_sales'),
        value: '${(userEntity.vendorStatistics?.sales?.total??0).toStringAsFixed(2)} K US',
        icon: Images.totalSales,
        iconColor: const Color(0xFFFFB74D),
        stats: [
          StatItemEntity(
            label: LanguageProvider.translate('global', 'this_month'),
            value: '${userEntity.vendorStatistics?.sales?.thisMonth} \$',
          ),
          StatItemEntity(
            label: LanguageProvider.translate('global', 'last_month'),
            value: '${userEntity.vendorStatistics?.sales?.lastMonth} \$',
          ),
        ],
      ),
      StatsCardEntity(
        title: LanguageProvider.translate('global', 'total_orders'),
        value: '${userEntity.vendorStatistics?.orders?.total}',
        icon: Images.totalOrders,
        iconColor: const Color(0xFF4CAF50),
        stats: [
          StatItemEntity(
            label: LanguageProvider.translate('global', 'cancelled_orders'),
            value: '${userEntity.vendorStatistics?.orders?.cancelled}',
          ),
          StatItemEntity(
            label: LanguageProvider.translate('global', 'active_orders'),
            value: '${userEntity.vendorStatistics?.orders?.active}'
          ),
        ],
      ),
      if(userEntity.vendorStatistics?.products?.best != null && userEntity.vendorStatistics?.products?.worst != null)
      StatsCardEntity(
        title: LanguageProvider.translate('global', 'best_worst_products'),
        value:"",
        icon: Images.productsIcon,
        iconColor: const Color(0xFF2196F3),
        stats: [
          StatItemEntity(
            label: LanguageProvider.translate('global', 'best'),
            value:  '${userEntity.vendorStatistics?.products?.best}',
          ),
          StatItemEntity(
            label: LanguageProvider.translate('global', 'worst'),
            value:  '${userEntity.vendorStatistics?.products?.worst}',
          ),
        ],
      ),
    ];
    infoCards = [

      InfoCardEntity(
          title: LanguageProvider.translate('global', 'products'),
          subtitle: LanguageProvider.translate('global', 'all_products'),
          svgImage: Images.productsIcon,
          backgroundColor: const Color(0xfffff5e0),
          svgBackgroundColor: const Color(0xfffe9bc),
          onTap: (){
            HomeProvider homeProvider = Provider.of(Constants.globalContext(),listen: false);
            NavigationEntity navigation= homeProvider.navigationList.firstWhere((element) => element.title == 'Products');
            homeProvider.setSelectedNavigation(navigation);
          }
      ),
      InfoCardEntity(
        title: LanguageProvider.translate('global', 'support'),
        subtitle: LanguageProvider.translate('global', 'open_ticket'),
        svgImage: Images.support,
        backgroundColor: const Color(0xffefe6f6),
        svgBackgroundColor: const Color(0xffe7d1f8),
        onTap: (){
          HomeProvider homeProvider = Provider.of(Constants.globalContext(),listen: false);
          NavigationEntity navigation= homeProvider.navigationList.firstWhere((element) => element.title == 'support');
          homeProvider.setSelectedNavigation(navigation);
        }
      ),
      if(!isStore)
      InfoCardEntity(
          title: LanguageProvider.translate('navbar', 'vendor_stores'),
          subtitle: LanguageProvider.translate('global', 'add_store'),
          svgImage: Images.appleStore,
          backgroundColor: const Color(0xffe0f8ea),
          svgBackgroundColor: const Color(0xff00a8e1),
          onTap: (){
            HomeProvider homeProvider = Provider.of(Constants.globalContext(),listen: false);
            NavigationEntity navigation= homeProvider.navigationList.firstWhere((element) => element.title == 'vendor_stores');
            homeProvider.setSelectedNavigation(navigation);
          }

      ),
      InfoCardEntity(
          title: LanguageProvider.translate('global', 'orders'),
          subtitle: LanguageProvider.translate('global', 'all_orders'),
          svgImage: Images.homeOrders,
          backgroundColor: const Color(0xfffceae4),
          svgBackgroundColor: const Color(0xffff8d4c8),
          onTap: (){
            HomeProvider homeProvider = Provider.of(Constants.globalContext(),listen: false);
            NavigationEntity navigation= homeProvider.navigationList.firstWhere((element) => element.title == 'Orders');
            homeProvider.setSelectedNavigation(navigation);
          }
      ),
    ];
  }

  void rebuild() {
    notifyListeners();
  }

  /// ----------- Google Login (new API v7) -----------
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  GoogleSignInAccount? googleUser;
  bool _isGoogleInitialized = false;

  Future<void> _initGoogle() async {
    if (!_isGoogleInitialized) {
      await _googleSignIn.initialize();
      _isGoogleInitialized = true;
    }
  }

  Future<void> googleLogin() async {
    await _initGoogle();
    try {
      await _googleSignIn.signOut();
      googleUser = await _googleSignIn.authenticate();
      log("message");
      socialLogin(loginFrom: 'google');
    } catch (error) {
      log(error.toString());
    }
  }

  Future getProfile() async {
    final result = await userUseCase.getProfile();
    result.fold(
      (l) {
        showToast(l.message!);
        if (userEntity == null) {
          goToUserTypePage();
        }
      },
      (r) {
        loginSuccess(r);
      },
    );
  }

  Future refreshToken() async {
    String token = sharedPreferences.getString('token')!;
    Map<String, dynamic> data = {'token': token};
    final result = await userUseCase.refreshToken(data);
    result.fold((l) => showToast(l.message!), (r) {
      sharedPreferences.setString('token', r);
      ApiHandel.getInstance.updateHeader(r);
    });
  }

  showLogoutDialog() {
    showPopUpDialog(
      title: LanguageProvider.translate('global', 'want_logout'),
      onConfirm: () {
        final result = userUseCase.logout({
          "token": FirebaseMessaging.instance.getToken(),
        });
        successLogout();
      },
    );
  }

  List<TextFieldModel> loginTextFieldList = [];

  List<TextFieldModel> registerTextFieldList = [
    TextFieldModel(
      label: LanguageProvider.translate("inputs", "Number"),
      controller: TextEditingController(),
      textInputType: const TextInputType.numberWithOptions(),
      validator: (value) => validatePhone(value),
      key: "phone",
    ),
  ];

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  Future<void> login() async {
    if (!loginFormKey.currentState!.validate()) return;

    Map<String, dynamic> data = {};
    data["token"] = await FirebaseMessaging.instance.getToken() ?? "123";

    for (var element in loginTextFieldList) {
      data[element.key] = element.controller.text.trim();
    }

    loading();
    final result = await userUseCase.login(data);
    navPop();

    result.fold(
      (l) {
        showToast(l.message!);
      },
      (r) {
        userEntity = r;
        loginSuccess(r);
      },
    );
  }

  void successLogout() {
    sharedPreferences.remove('login');
    sharedPreferences.remove('phone');
    sharedPreferences.remove('token');
    userEntity = null;
    goToUserTypePage();
  }

  void confirmDeleteAccount() {
    confirmDialog(
      LanguageProvider.translate('settings', "delete_account"),
      LanguageProvider.translate('settings', "delete"),
      () {
        deleteAccount();
      },
    );
  }

  List<InfoCardEntity> infoCards = [];
  List<StatsCardEntity> statsCards =[];

  Future<void> updateProfile({bool updateActive = false}) async {
    Map<String, dynamic> data = {};
    loading();
    if(updateActive){
      data['active'] =! (userEntity?.active ?? false) ;
    }else{
    }
    final result = await userUseCase.updateProfile(data);
    navPop();
    result.fold((l) {
    showToast(l.message!);}, (r) {
      userEntity?.active = !(userEntity?.active ?? false);
      notifyListeners();
      },
    );
  }

}
