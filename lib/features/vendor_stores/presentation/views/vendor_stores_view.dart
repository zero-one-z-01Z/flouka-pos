import 'package:flouka_pos/core/config/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_color.dart';
import '../providers/store_operations_provider.dart';
import '../providers/vendor_stores_provider.dart';
import '../widgets/add_store_widget.dart';

class VendorStoresView extends StatelessWidget {
  const VendorStoresView({super.key});

  @override
  Widget build(BuildContext context) {
    final VendorStoresProvider vendorStoresProvider = Provider.of<VendorStoresProvider>(context,);
    final StoreOperationsProvider storeOperationsProvider = Provider.of<StoreOperationsProvider>(context,);
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 2.h),
        child: Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 2,
              child: Builder(builder: (context) {
                if(vendorStoresProvider.data == null) {
                  return const Center(child: CircularProgressIndicator());
                }
                if(vendorStoresProvider.data!.isEmpty) {
                  return const Center(child: Text("No stores"));
                }
                return Wrap(
                  runSpacing: 2.w,
                  spacing: 2.w,
                  children: List.generate(vendorStoresProvider.data!.length, (index) {
                    return Container(width: 20.w,
                      padding:const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Row(crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(flex: 6,
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,spacing: 1.h,
                              children: [
                                Text(vendorStoresProvider.data![index].name??"",
                                  maxLines: 1,
                                  style: TextStyleClass.captionStyle(),),
                                Text(vendorStoresProvider.data![index].phone??"",
                                  maxLines: 1,
                                  style: TextStyleClass.captionStyle(),),
                                Text(vendorStoresProvider.data![index].address??"",
                                  maxLines: 1,
                                  style: TextStyleClass.captionStyle(),),
                                Text(vendorStoresProvider.data![index].userName??"",
                                  maxLines: 1,
                                  style: TextStyleClass.captionStyle(),),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              storeOperationsProvider.selectToEdit(store: vendorStoresProvider.data![index]);
                            },
                            child: Icon(Icons.edit,size: 1.5.w,color: AppColor.primaryColor,),
                          ),
                          SizedBox(width: 0.5.w,),
                          InkWell(
                            onTap: (){
                              storeOperationsProvider.deleteStore(id: vendorStoresProvider.data![index].id);
                            },
                            child: Icon(Icons.delete,size: 1.5.w,color: Colors.red,),
                          ),
                        ],
                      ),
                    );
                  }),
                );
              }),
            ),
            if(vendorStoresProvider.data != null)
            const Expanded(child: AddStoreWidget()),
          ],
        ),
      ),
    );
  }
}
