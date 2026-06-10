import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../entity/offer_entity.dart';

abstract class OffersRepo {
  Future<Either<DioException, bool>> deleteOffer(Map<String, dynamic> data,);
  Future<Either<DioException, OfferEntity>> updateOffer(Map<String, dynamic> data,);
  Future<Either<DioException, OfferEntity>> createOffer(Map<String, dynamic> data,);
  Future<Either<DioException, List<OfferEntity>>> getVendorOffers(Map<String, dynamic> data,);
}
