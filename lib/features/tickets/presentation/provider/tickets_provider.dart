import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/dialog/snack_bar.dart';
import '../../../../core/helper_function/helper_function.dart';
import '../../../../core/helper_function/navigation.dart';
import '../../../../core/models/pagination_class.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/ticket_entity.dart';
import '../../domain/usecases/tickets_use_case.dart';
import '../pages/tickets_page.dart';
import 'ticket_message_provider.dart';

class TicketsProvider extends ChangeNotifier implements PaginationClass{

  List<TicketEntity>? tickets;

  @override
  int pageIndex = 1;
  void clear(){
    tickets = null;
    paginationStarted = false;
    paginationFinished = false;
    pageIndex = 1;

  }

  void goToTicketsPage(){
    TicketMessageProvider ticketMessageProvider = Provider.of(Constants.globalContext(),listen: false);
    ticketMessageProvider.clear();

    refresh();
    navP(TicketsPage(),then: (s)async{
     await delay(500);
     clear();
     ticketMessageProvider.clear();
    });
  }
  Future getTickets()async{
    Map<String,dynamic> data = {};
    data['page'] = pageIndex;
    Either<DioException,List<TicketEntity>> value = await TicketsUseCase(sl()).getTickets(data);
    value.fold((l) {
      showToast(l.message??"");
    }, (r) async{
      pageIndex++;
      tickets ??=[];
      tickets?.addAll(r);
      notifyListeners();
      if(r.isEmpty){
        paginationFinished = true;
      }
    });
    paginationStarted = false;
    notifyListeners();
  }

  void rebuild(){
    notifyListeners();
  }


  void refresh(){
    clear();
    getTickets();
  }


  void updateTicketStatus(TicketEntity ticket){
    int index = tickets!.indexWhere((element) => element.id==ticket.id);
    if(index !=-1) {
      tickets![index] = ticket;
    }
    notifyListeners();
  }

  @override
  bool paginationFinished = false;

  @override
  bool paginationStarted = false;

  ScrollController controller = ScrollController();
  @override
  void pagination() {
    controller.addListener(() async{
      if(controller.position.atEdge&&controller.position.pixels>50){
        if(!paginationFinished&&!paginationStarted&&tickets!=null&&tickets!.isNotEmpty){
          paginationStarted = true;
          notifyListeners();
          await getTickets();
        }
      }
    });
  }

}