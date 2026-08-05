import 'package:flouka_pos/core/dialog/success_dialog.dart';
import 'package:flouka_pos/core/helper_function/loading.dart';
import 'package:flouka_pos/core/helper_function/navigation.dart';
import 'package:flouka_pos/core/models/text_field_model.dart';
import 'package:flouka_pos/features/auth/domain/entities/user_entity.dart';
import 'package:flouka_pos/features/auth/presentation/providers/auth_provider.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/dialog/snack_bar.dart';
import '../../domain/user_case/withdraw_use_case.dart';
import 'withdraw_provider.dart';

class WithdrawOperationsProvider extends ChangeNotifier {
  List<TextFieldModel> addWithdrawInputs = [];
  final formKey = GlobalKey<FormState>();
  WithdrawUseCase withdrawUseCase;
  WithdrawOperationsProvider(this.withdrawUseCase);

  void addTextField() {
    AuthProvider authProvider = Constants.globalContext().read();
    UserEntity? user = authProvider.userEntity;
    addWithdrawInputs = [
      TextFieldModel(
        key: "name",
        hint: "name",
        controller: TextEditingController(text: user?.name??""),
      ),
      TextFieldModel(
        key: "amount",
        hint: "amount",
        textInputType: TextInputType.number,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return LanguageProvider.translate("validation", "field");
          } else if (num.tryParse(value) == null) {
            return LanguageProvider.translate("validation", "value_invalid");
          }
          return null;
        },
        controller: TextEditingController(),
      ),
      TextFieldModel(
        key: "paypal",
        hint: "Paypal",
        validator: (v)=>null,
        controller: TextEditingController(),
      ),
      TextFieldModel(
        key: "iban",
        hint: "Iban",
        validator: (v)=>null,
        controller: TextEditingController(text: user?.bankNumber??""),
      ),
    ];
    notifyListeners();
  }

  // Only sends: paypal, iban, name, amount — matching the create_withdraw API
  Map<String, dynamic> prepareData() {
    Map<String, dynamic> data = {};
    for (var element in addWithdrawInputs) {
      data[element.key] = element.controller.text;
    }
    return data;
  }

  Future addWithdraw() async {
    Map<String, dynamic> apiData = prepareData();
    if(apiData['iban']==null&&apiData['paypal']==null){
      return;
    }
    loading();
    final result = await withdrawUseCase.createWithdraw(apiData);
    navPop();
    result.fold((l) => showToast(l.message ?? "Error creating withdraw"), (r) {
      successDialog();
      Provider.of<WithdrawProvider>(Constants.globalContext(), listen: false).addWithdraw(r);
      reset();
      notifyListeners();
    });
  }

  void reset() {
    for (var element in addWithdrawInputs) {
      element.controller.clear();
    }
    notifyListeners();
  }
}
