import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/widgets/custom_app_bat.dart';
import '../providers/home_provider.dart';
import '../widgets/navigation_rail_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeProvider homeProvider = Provider.of(context);
    return const Scaffold(
      backgroundColor: Color(0xfff8f9fd),
      body: Row(
        children: [
          NavigationRailWidget(),
          Expanded(child: Column(children: [CustomAppBar()])),
        ],
      ),
    );
  }
}
