import 'package:flouka_pos/core/config/app_styles.dart';
import 'package:flouka_pos/core/constants/constants.dart';
import 'package:flouka_pos/core/widgets/vendor/vendor_widgets.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../core/config/app_color.dart';
import '../providers/store_operations_provider.dart';
import '../providers/vendor_stores_provider.dart';
import '../widgets/add_store_widget.dart';

class VendorStoresView extends StatelessWidget {
  const VendorStoresView({super.key});

  Widget _list(
    BuildContext context,
    VendorStoresProvider vendorStoresProvider,
    StoreOperationsProvider ops,
  ) {
    if (vendorStoresProvider.data == null) {
      return const Center(
        child: CircularProgressIndicator(color: AppColor.sidebar),
      );
    }
    if (vendorStoresProvider.data!.isEmpty) {
      return Center(
        child: Text(
          'No stores',
          style: GoogleFonts.plusJakartaSans(color: AppColor.textMuted),
        ),
      );
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        final cols = constraints.maxWidth > 700 ? 2 : 1;
        const gap = 12.0;
        final w = cols == 1
            ? constraints.maxWidth
            : (constraints.maxWidth - gap) / 2;
        return SingleChildScrollView(
          child: Wrap(
            spacing: gap,
            runSpacing: gap,
            children: List.generate(vendorStoresProvider.data!.length, (index) {
              final store = vendorStoresProvider.data![index];
              return Container(
                width: w,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColor.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColor.hairline),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            store.name ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyleClass.captionStyle(),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            store.phone ?? '',
                            maxLines: 1,
                            style: TextStyleClass.captionStyle(),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            store.address ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyleClass.captionStyle(),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            store.userName ?? '',
                            maxLines: 1,
                            style: TextStyleClass.captionStyle(),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => ops.selectToEdit(store: store),
                      icon: const Icon(Icons.edit_outlined, size: 18),
                      color: AppColor.sidebar,
                    ),
                    IconButton(
                      onPressed: () => ops.deleteStore(id: store.id),
                      icon: const Icon(Icons.delete_outline, size: 18),
                      color: Colors.red,
                    ),
                  ],
                ),
              );
            }),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final VendorStoresProvider vendorStoresProvider =
        Provider.of<VendorStoresProvider>(context);
    final StoreOperationsProvider ops =
        Provider.of<StoreOperationsProvider>(context);
    final compact = Constants.isCompactShell(context);

    return Scaffold(
      backgroundColor: AppColor.canvas,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              compact ? 16 : 20,
              16,
              compact ? 16 : 20,
              0,
            ),
            child: Text(
              LanguageProvider.translate('navbar', 'vendor_stores'),
              style: GoogleFonts.bricolageGrotesque(
                fontSize: compact ? 22 : 18,
                fontWeight: FontWeight.w800,
                color: AppColor.ink,
              ),
            ),
          ),
          Expanded(
            child: compact
                ? ListView(
                    children: [
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.45,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                          child: _list(context, vendorStoresProvider, ops),
                        ),
                      ),
                      if (vendorStoresProvider.data != null)
                        const Padding(
                          padding: EdgeInsets.fromLTRB(16, 0, 16, 24),
                          child: AddStoreWidget(),
                        ),
                    ],
                  )
                : MasterDetailScaffold(
                    master: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 12, 12, 16),
                      child: _list(context, vendorStoresProvider, ops),
                    ),
                    detail: vendorStoresProvider.data == null
                        ? const SizedBox.shrink()
                        : const Padding(
                            padding: EdgeInsets.fromLTRB(12, 12, 20, 16),
                            child: AddStoreWidget(),
                          ),
                    showDetail: vendorStoresProvider.data != null,
                  ),
          ),
        ],
      ),
    );
  }
}
