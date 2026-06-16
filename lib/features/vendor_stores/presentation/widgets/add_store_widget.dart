import 'package:flouka_pos/core/widgets/button_widget.dart';
import 'package:flouka_pos/core/widgets/list_text_field_widget.dart';
import 'package:flouka_pos/features/vendor_stores/presentation/providers/store_operations_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddStoreWidget extends StatelessWidget {
  const AddStoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    StoreOperationsProvider storeOperationsProvider = Provider.of(context);
    return Form(
      key: storeOperationsProvider.formKey,
      child: Column(
        children: [
          SizedBox(width: double.infinity,height: 20.h,
            child: Stack(
              children: [
                GoogleMap(
                  // style: storeOperationsProvider.mapStyleString,
                  initialCameraPosition: CameraPosition(
                    target: storeOperationsProvider.center??const LatLng(36.806389, 10.181667),
                    zoom: storeOperationsProvider.zoom,
                  ),
                  onMapCreated: (c) {
                    storeOperationsProvider.onMapCreated(c);
                  },
                  onCameraIdle: () => storeOperationsProvider.onCameraMoveEnd(),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  markers: storeOperationsProvider.markers,
                  onCameraMove: (pos) => storeOperationsProvider.onCameraMove(pos),
                ),
                Center(
                  child: Icon(Icons.location_on,size: 2.w,color: Colors.red,),
                ),
              ],
            ),
          ),
          SizedBox(height: 1.h,),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [

                  ListTextFieldWidget(inputs: storeOperationsProvider.addStoreInputs),
                ],
              ),
            ),
          ),
          SizedBox(height: 1.h,),
          Row(
            children: [
              Expanded(
                child: ButtonWidget(onTap: (){
                  if(storeOperationsProvider.formKey.currentState!.validate()){
                    if(storeOperationsProvider.id !=null){
                      storeOperationsProvider.updateStore();
                    }else{
                      storeOperationsProvider.addStore();
                    }
                  }
                }, text: "add_store"),
              ),
              if(storeOperationsProvider.id != null)...[
                SizedBox(width: 2.w,),
                Expanded(
                  child: ButtonWidget(onTap: (){
                    storeOperationsProvider.reset();
                  }, color: Colors.red,text: "cancel_selection"),
                ),

              ],
            ],
          ),
          SizedBox(height: 1.h,),
        ],
      ),
    );
  }
}
