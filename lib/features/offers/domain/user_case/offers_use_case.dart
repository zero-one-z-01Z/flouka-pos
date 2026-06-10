import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../entity/offer_entity.dart';
import '../repo/offers_repo.dart';

class OffersUseCase {
  final OffersRepo offersRepo;

  OffersUseCase(this.offersRepo);


  Future<Either<DioException, OfferEntity>> createOffer(Map<String, dynamic> data,) async {
    return await offersRepo.createOffer(data);
  }

  Future<Either<DioException, OfferEntity>> updateOffer(Map<String, dynamic> data,) async {
    return await offersRepo.updateOffer(data);
  }

  Future<Either<DioException, bool>> deleteOffer(Map<String, dynamic> data,) async {
    return await offersRepo.deleteOffer(data);
  }

  Future<Either<DioException, List<OfferEntity>>> getVendorOffers(Map<String, dynamic> data,) async {
    return await offersRepo.getVendorOffers(data);
  }


}
