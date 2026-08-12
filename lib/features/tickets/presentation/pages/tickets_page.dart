import 'package:flouka_pos/core/config/app_color.dart';
import 'package:flouka_pos/core/constants/constants.dart';
import 'package:flouka_pos/core/widgets/vendor/vendor_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../core/config/app_styles.dart';
import '../../../../core/constants/app_lotties.dart';
import '../../../../core/widgets/empty_animation.dart';
import '../../../../core/widgets/loading_animation_widget.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../provider/add_ticket_provider.dart';
import '../provider/ticket_message_provider.dart';
import '../provider/tickets_provider.dart';
import '../widgets/ticket_widget.dart';
import 'add_ticket_page.dart';
import 'ticket_message_page.dart';

class TicketsPage extends StatelessWidget {
  const TicketsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TicketsProvider ticketsProvider = Provider.of(context);
    final TicketMessageProvider ticketMessageProvider = Provider.of(context);
    final AddTicketProvider addTicketProvider = Provider.of(context);
    ticketsProvider.pagination();
    final compact = Constants.isCompactShell(context);
    final showDetail = addTicketProvider.isAddTicket ||
        ticketMessageProvider.isShowTicket;

    Widget master = RefreshIndicator(
      color: AppColor.sidebar,
      onRefresh: () async => ticketsProvider.refresh(),
      child: SingleChildScrollView(
        controller: ticketsProvider.controller,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(
          compact ? 16 : 20,
          12,
          compact ? 16 : 12,
          88,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LanguageProvider.translate('ticket', 'support_ticket'),
              style: GoogleFonts.bricolageGrotesque(
                fontSize: compact ? 22 : 18,
                fontWeight: FontWeight.w800,
                color: AppColor.ink,
              ),
            ),
            const SizedBox(height: 14),
            Builder(
              builder: (context) {
                if (ticketsProvider.tickets == null) {
                  return const Center(
                    child: LoadingAnimationWidget(gif: Lotties.chats),
                  );
                }
                if (ticketsProvider.tickets!.isEmpty) {
                  return const Center(
                    child: EmptyAnimation(
                      title: 'no_ticket',
                      gif: Lotties.noSearch,
                    ),
                  );
                }
                return Column(
                  children: List.generate(
                    ticketsProvider.tickets!.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: TicketWidget(
                        ticket: ticketsProvider.tickets![index],
                      ),
                    ),
                  ),
                );
              },
            ),
            if (ticketsProvider.paginationStarted) const LoadingWidget(),
          ],
        ),
      ),
    );

    Widget? detail;
    if (addTicketProvider.isAddTicket && !ticketMessageProvider.isShowTicket) {
      detail = AddTicketPage();
    } else if (!addTicketProvider.isAddTicket &&
        ticketMessageProvider.isShowTicket) {
      detail = const TicketMessagePage();
    }

    return Scaffold(
      backgroundColor: AppColor.canvas,
      floatingActionButton: ticketsProvider.tickets != null &&
              !addTicketProvider.isAddTicket &&
              !ticketMessageProvider.isShowTicket
          ? FloatingActionButton.extended(
              onPressed: () {
                Provider.of<AddTicketProvider>(context, listen: false)
                    .goToAddTicketPage();
              },
              backgroundColor: AppColor.gold,
              foregroundColor: AppColor.ink,
              icon: const Icon(Icons.add_rounded),
              label: Text(
                LanguageProvider.translate('ticket', 'add_ticket'),
                style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800),
              ),
            )
          : null,
      body: compact
          ? (showDetail && detail != null
              ? Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
                        onPressed: () {
                          if (addTicketProvider.isAddTicket) {
                            addTicketProvider.setIsAddTicket(false);
                          }
                          if (ticketMessageProvider.isShowTicket) {
                            ticketMessageProvider.clear();
                          }
                        },
                        icon: const Icon(Icons.arrow_back_rounded),
                        label: Text(
                          LanguageProvider.translate('buttons', 'cancel'),
                          style: TextStyleClass.normalStyle(),
                        ),
                      ),
                    ),
                    Expanded(child: detail),
                  ],
                )
              : master)
          : MasterDetailScaffold(
              master: master,
              detail: detail ??
                  Center(
                    child: Text(
                      LanguageProvider.translate('ticket', 'support_ticket'),
                      style: GoogleFonts.plusJakartaSans(
                        color: AppColor.textMuted,
                      ),
                    ),
                  ),
              showDetail: true,
            ),
    );
  }
}
