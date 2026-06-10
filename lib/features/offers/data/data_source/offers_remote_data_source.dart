import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/helper_function/api.dart';
import '../../domain/entity/offer_entity.dart';
import '../models/offer_model.dart';

  class OffersRemoteDataSource {
  final ApiHandel apiHandel;
  OffersRemoteDataSource(this.apiHandel);

  Future<Either<DioException, OfferModel>> createOffer(Map<String, dynamic> data,) async {
    var response = await ApiHandel.getInstance.post('vendor/create_offer', data,);
    return response.fold((l) => Left(l), (r) {
      return Right(OfferModel.fromJson(r.data['data']));
    });
  }

  Future<Either<DioException, OfferModel>> updateOffer(Map<String, dynamic> data,) async {
    var response = await ApiHandel.getInstance.post('vendor/update_offer', data,);
    return response.fold((l) => Left(l), (r) {
      return Right(OfferModel.fromJson(r.data['data']));
    });
  }


  Future<Either<DioException, List<OfferModel>>> getVendorOffers(Map<String, dynamic> data,) async {
    var response = await ApiHandel.getInstance.get('vendor/get_vendor_offers', data,);
    return response.fold((l) => Left(l), (r) {
      List<OfferModel> stories = [];
      for(var element in r.data['data']){
        stories.add(OfferModel.fromJson(element));
      }
      return Right(stories);
    });
  }

  Future<Either<DioException, bool>> deleteOffer(Map<String, dynamic> data,) async {
    var response = await ApiHandel.getInstance.post('vendor/delete_offer', data,);
    return response.fold((l) => Left(l), (r) {
      return const Right(true);
    });
  }


}
