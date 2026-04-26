import 'dart:ui';
import 'package:flouka_pos/features/products/presentation/widgets/sold_by_product_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/product_entity.dart';
import '../providers/product_provider.dart';

class ProductPreviewOverlay extends StatefulWidget {
  final Product product;

  const ProductPreviewOverlay({super.key, required this.product});

  @override
  State<ProductPreviewOverlay> createState() => _ProductPreviewOverlayState();
}

class _ProductPreviewOverlayState extends State<ProductPreviewOverlay> {
  int _currentPage = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context, listen: false);

    return GestureDetector(
      onTap: productProvider.closePreview,
      child: Container(
        color: Colors.black.withOpacity(0.4),
        child: Center(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: Container(
              width: 45.w,
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Banner Carousel
                    SizedBox(
                      height: 30.h,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: widget.product.imagePaths.length,
                        onPageChanged: (index) {
                          setState(() {
                            _currentPage = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              widget.product.imagePaths[index],
                              fit: BoxFit.contain,
                              width: double.infinity,
                            ),
                          );
                        },
                      ),
                    ),

                    // Page indicator
                    SizedBox(height: 1.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        widget.product.imagePaths.length,
                        (index) => Container(
                          width: 1.w,
                          height: 3.h,
                          margin: EdgeInsets.symmetric(horizontal: 1.w),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentPage == index
                                ? Colors.black
                                : Colors.grey[400],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 2.h),

                    // Product Name
                    Text(
                      widget.product.name,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 1.h),

                    // Price
                    Text(
                      "\$${widget.product.price}",
                      style:
                          TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 1.h),

                    // Rating Stars
                    Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          index < widget.product.rating.round()
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.amber,
                          size: 14.sp,
                        ),
                      )
                        ..add(SizedBox(width: 1.w))
                        ..add(
                          Text(
                            widget.product.rating.toString(),
                            style: TextStyle(
                                fontSize: 10.sp, fontWeight: FontWeight.bold),
                          ),
                        ),
                    ),
                    SizedBox(height: 2.h),

                    // Description Section
                    Text(
                      "Description",
                      style: TextStyle(
                          fontSize: 15.sp, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      widget.product.description,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey[500],
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 2.h),

                    // Sold By Section
                    const SoldByProductContainerWidget(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
