import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/helper_function/api.dart';
import '../../domain/entity/vendor_section_entity.dart';
import '../models/vendor_section_model.dart';

    class SectionsRemoteDataSource {
  final ApiHandel apiHandel;
  SectionsRemoteDataSource(this.apiHandel);

  Future<Either<DioException, bool>> assignProductsToSection(Map<String, dynamic> data,) async {
      var response = await ApiHandel.getInstance.post('vendor/assign_products_to_section', data,);
    return response.fold((l) => Left(l), (r) {
      return const Right(true);
    });
  }

  Future<Either<DioException, List<VendorSectionModel>>> getVendorSections(Map<String, dynamic> data,) async {
    var response = await ApiHandel.getInstance.get('vendor/get_vendor_sections', data,);
    return response.fold((l) => Left(l), (r) {
      List<VendorSectionModel> stories = [];
      for(var element in r.data['data']){
        stories.add(VendorSectionModel.fromJson(element));
      }
      return Right(stories);
    });
  }

}
