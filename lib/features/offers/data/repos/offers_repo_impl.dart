import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/entity/offer_entity.dart';
import '../../domain/repo/offers_repo.dart';
import '../data_source/offers_remote_data_source.dart';

class OffersRepoImpl implements OffersRepo {
  final OffersRemoteDataSource offersRemoteDataSource;

  OffersRepoImpl(this.offersRemoteDataSource);

  @override
  Future<Either<DioException, OfferEntity>> createOffer(Map<String, dynamic> data,) async {
    return await offersRemoteDataSource.createOffer(data);
  }

  @override
  Future<Either<DioException, OfferEntity>> updateOffer(Map<String, dynamic> data,) async {
    return await offersRemoteDataSource.updateOffer(data);
  }


  @override
  Future<Either<DioException, List<OfferEntity>>> getVendorOffers(Map<String, dynamic> data,) async {
    return await offersRemoteDataSource.getVendorOffers(data);
  }

  @override
  Future<Either<DioException, bool>> deleteOffer(Map<String, dynamic> data,) async {
    return await offersRemoteDataSource.deleteOffer(data);
  }
}
