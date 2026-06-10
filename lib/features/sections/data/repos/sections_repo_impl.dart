import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/entity/vendor_section_entity.dart';
import '../../domain/repo/sections_repo.dart';
import '../data_source/sections_remote_data_source.dart';
import '../models/vendor_section_model.dart';

class SectionsRepoImpl implements SectionsRepo {
  final SectionsRemoteDataSource sectionsRemoteDataSource;

  SectionsRepoImpl(this.sectionsRemoteDataSource);

  @override
  Future<Either<DioException, bool>> assignProductsToSection(Map<String, dynamic> data,) async {
    return await sectionsRemoteDataSource.assignProductsToSection(data);
  }

  @override
  Future<Either<DioException, List<VendorSectionModel>>> getVendorSections(Map<String, dynamic> data,) async {
    return await sectionsRemoteDataSource.getVendorSections(data);
  }
}
