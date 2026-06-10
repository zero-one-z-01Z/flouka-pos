import 'package:cached_network_image/cached_network_image.dart';
import 'package:flouka_pos/core/config/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/constants/app_lotties.dart';
import '../../../../core/dialog/success_dialog.dart';
import '../../../../core/widgets/button_widget.dart';
import '../../../../core/widgets/empty_animation.dart';
import '../providers/stories_operations_provider.dart';
import '../providers/stories_provider.dart';
import '../widgets/add_story_widget.dart';

class StoriesView extends StatelessWidget {
  const StoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    final StoriesProvider vendorStoresProvider = Provider.of<StoriesProvider>(context,);
    final StoriesOperationsProvider storeOperationsProvider = Provider.of<StoriesOperationsProvider>(context,);
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 2.h),
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(vendorStoresProvider.data != null)
              Row(mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ButtonWidget(width: 10.w,onTap: (){
                    storeOperationsProvider.showAddWidget();
                  }, text: "add_story"),
                ],
              ),
              SizedBox(height: 1.h,),
              Builder(builder: (context) {
                if(vendorStoresProvider.data == null) {
                  return Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: const Center(child: CircularProgressIndicator()),
                  );
                }
                if(vendorStoresProvider.data!.isEmpty) {
                  return const Center(child: EmptyAnimation(title: "", gif: Lotties.noSearch));
                }
                return Wrap(
                  runSpacing: 2.w,
                  spacing: 2.w,
                  children: List.generate(vendorStoresProvider.data!.length, (index) {
                    return SizedBox(
                      height: 50.h,width: 16.w,
                      child: Stack(
                        alignment:AlignmentDirectional.bottomEnd ,
                        children: [
                          Container(
                            height: 45.h,width: 16.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(image: CachedNetworkImageProvider(vendorStoresProvider.data![index].image),
                                    fit: BoxFit.cover)
                            ),
                          ),
                          Container(
                            height: 45.h,width: 16.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(colors: [
                                Colors.black.withOpacity(0.1),
                                Colors.black.withOpacity(0.1),
                                Colors.black.withOpacity(0.5),
                                Colors.black.withOpacity(0.6),
                                Colors.black.withOpacity(0.7),
                              ],begin: Alignment.topCenter,end: Alignment.bottomCenter),
                            ),
                          ),
          
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 0.5.w,vertical: 4.h),
                            child: Text(vendorStoresProvider.data![index].title,textAlign: TextAlign.end,
                              style: TextStyleClass.captionStyle(color: Colors.white),),
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () => storeOperationsProvider.deleteStory(id: vendorStoresProvider.data![index].id),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                  child: Icon(Icons.delete,color: Colors.red,size: 2.5.w,),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
