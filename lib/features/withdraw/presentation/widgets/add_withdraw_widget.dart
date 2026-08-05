import 'package:flouka_pos/core/widgets/button_widget.dart';
import 'package:flouka_pos/core/widgets/list_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../providers/withdraw_operations_provider.dart';

class AddWithdrawWidget extends StatelessWidget {
  const AddWithdrawWidget({super.key});

  @override
  Widget build(BuildContext context) {
    WithdrawOperationsProvider withdrawOperationsProvider = Provider.of(context);
    return Form(
      key: withdrawOperationsProvider.formKey,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 2.h,),
                  ListTextFieldWidget(inputs: withdrawOperationsProvider.addWithdrawInputs),
                ],
              ),
            ),
          ),
          SizedBox(height: 1.h,),
          ButtonWidget(onTap: () {
            if (withdrawOperationsProvider.formKey.currentState!.validate()) {
              withdrawOperationsProvider.addWithdraw();
            }
          }, text: "add_withdraw"),
          SizedBox(height: 1.h,),
        ],
      ),
    );
  }
}
