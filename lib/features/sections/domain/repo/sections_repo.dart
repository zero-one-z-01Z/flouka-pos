import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../entity/vendor_section_entity.dart';

abstract class SectionsRepo {
  Future<Either<DioException, bool>> assignProductsToSection(Map<String, dynamic> data,);
  Future<Either<DioException, List<VendorSectionEntity>>> getVendorSections(Map<String, dynamic> data,);
}
