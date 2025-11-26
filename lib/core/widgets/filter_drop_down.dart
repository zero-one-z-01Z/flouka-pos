import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../dialog/drop_down_dialog.dart';
import '../models/drop_down_class.dart';


class FilterDropDown extends StatefulWidget {
  final DropDownClass dropDownClass;
  final double? width,borderRadius;
  final Color? borderColor;
  final double? padding;
  final void Function()? onTap;
  const FilterDropDown({required this.dropDownClass,this.width,super.key, this.onTap, this.borderRadius, this.borderColor, this.padding});
  @override
  State<FilterDropDown> createState() => _DropDownWidgetState(dropDownClass);
}

class _DropDownWidgetState extends State<FilterDropDown> {
  DropDownClass dropDownClass;
  _DropDownWidgetState(this.dropDownClass);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: (){
            FocusScope.of(context).unfocus();
            if(widget.onTap==null){
              showDropDownDialog(dropDownClass).then((value) => setState((){}));
            }else{
              widget.onTap!();
            }
          },
          child: Container(
            width: widget.width??100.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius??10),
              color: Colors.white,
              // border:  Border.all(color:widget.borderColor ?? Colors.grey),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: widget.padding ?? 0.7.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  dropDownClass.displayedWidget()??const SizedBox()
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
