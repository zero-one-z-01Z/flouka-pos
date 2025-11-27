import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'order_card_widget.dart';

class OrderListWidget extends StatefulWidget {
  const OrderListWidget({super.key});

  @override
  State<OrderListWidget> createState() => _OrderListWidgetState();
}

class _OrderListWidgetState extends State<OrderListWidget> {
  String selectedTab = 'All';
  final List<String> tabs = ['All', 'New', 'Ongoing', 'Completed'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF0F0F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order List',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              // Tabs
              Row(
                children: tabs.map((tab) {
                  final isSelected = selectedTab == tab;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTab = tab;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 1.w),
                      padding: EdgeInsets.symmetric(
                        horizontal: 2.w,
                        vertical: 0.8.h,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF2196F3).withOpacity(0.1)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        tab,
                        style: TextStyle(
                          fontSize: 8.sp,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                          color: isSelected
                              ? const Color(0xFF2196F3)
                              : Colors.black54,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          SizedBox(height: 2.h),

          // Order Cards
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: OrderCardWidget(
                  orderId: '37332323',
                  customerName: 'Moaz mohamed',
                  totalPrice: '3,000.00 \$',
                  paymentMethod: 'Visa',
                  orderTime: '09/10/2025 - 10:30 AM',
                  itemsCount: '10',
                  address: 'Smoha,32 ElBulring,20Alex...',
                  orderStatus: 'Pressing',
                  statusColor: Color(0xFFFFB74D),
                  actions: [
                    {'label': 'Accept', 'color': Color(0xFF4CAF50)},
                    {'label': 'Cancel', 'color': Color(0xFFF44336)},
                  ],
                ),
              ),
              SizedBox(width: 2.w),
              const Expanded(
                child: OrderCardWidget(
                  orderId: '37332323',
                  customerName: 'Moaz mohamed',
                  totalPrice: '3,000.00 \$',
                  paymentMethod: 'Visa',
                  orderTime: '09/10/2025 - 10:30 AM',
                  itemsCount: '10',
                  address: 'Smoha,32 ElBulring,20Alex...',
                  orderStatus: 'Pressing',
                  statusColor: Color(0xFFFFB74D),
                  actions: [
                    {'label': 'Order Prepared', 'color': Color(0xFF4CAF50)},
                  ],
                ),
              ),
              SizedBox(width: 2.w),
              const Expanded(
                child: OrderCardWidget(
                  orderId: '37332323',
                  customerName: 'Moaz mohamed',
                  totalPrice: '3,000.00 \$',
                  paymentMethod: 'Visa',
                  orderTime: '09/10/2025 - 10:30 AM',
                  itemsCount: '10',
                  address: 'Smoha,32 ElBulring,20Alex...',
                  orderStatus: 'Done',
                  statusColor: Color(0xFF4CAF50),
                  actions: [
                    {'label': 'More Details', 'color': Color(0xFF2196F3)},
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
