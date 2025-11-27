import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class OrderCardWidget extends StatelessWidget {
  final String orderId;
  final String customerName;
  final String totalPrice;
  final String paymentMethod;
  final String orderTime;
  final String itemsCount;
  final String address;
  final String orderStatus;
  final Color statusColor;
  final List<Map<String, dynamic>> actions;

  const OrderCardWidget({
    super.key,
    required this.orderId,
    required this.customerName,
    required this.totalPrice,
    required this.paymentMethod,
    required this.orderTime,
    required this.itemsCount,
    required this.address,
    required this.orderStatus,
    required this.statusColor,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order ID and Customer Name
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(1.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF2196F3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.person, color: Colors.white, size: 2.5.h),
              ),
              SizedBox(width: 1.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order ID',
                      style: TextStyle(fontSize: 7.sp, color: Colors.black54),
                    ),
                    Text(
                      orderId,
                      style: TextStyle(
                        fontSize: 8.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 1.5.h),

          // Order Details
          _buildDetailRow('Customer Name', customerName),
          SizedBox(height: 1.h),
          _buildDetailRow('Total Price', totalPrice),
          SizedBox(height: 1.h),
          _buildDetailRow('Payment Method', paymentMethod),
          SizedBox(height: 1.h),
          _buildDetailRow('Order Time', orderTime),
          SizedBox(height: 1.h),
          _buildDetailRow('Items Count', itemsCount),
          SizedBox(height: 1.h),
          _buildDetailRow('Address', address),
          SizedBox(height: 1.5.h),

          // Order Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order Status',
                style: TextStyle(fontSize: 7.sp, color: Colors.black54),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 1.5.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  orderStatus,
                  style: TextStyle(
                    fontSize: 7.sp,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),

          // Action Buttons
          Row(
            children: actions.asMap().entries.map((entry) {
              final index = entry.key;
              final action = entry.value;
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: index < actions.length - 1 ? 1.w : 0,
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: action['color'],
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 1.2.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      action['label'],
                      style: TextStyle(fontSize: 7.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          if (actions.length == 1) SizedBox(height: 1.h),
          if (actions.length == 1)
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_horiz),
              color: const Color(0xFF2196F3),
              style: IconButton.styleFrom(
                backgroundColor: const Color(0xFF2196F3).withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 7.sp, color: Colors.black54),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 7.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
