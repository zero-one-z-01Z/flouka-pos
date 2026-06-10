import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../entity/vendor_section_entity.dart';
import '../repo/sections_repo.dart';

class SectionsUseCase {
  final SectionsRepo sectionsCategoryRepo;

  SectionsUseCase(this.sectionsCategoryRepo);


  Future<Either<DioException, bool>> assignProductsToSection(Map<String, dynamic> data,) async {
    return await sectionsCategoryRepo.assignProductsToSection(data);
  }

  Future<Either<DioException, List<VendorSectionEntity>>> getVendorSections(Map<String, dynamic> data,) async {
    return await sectionsCategoryRepo.getVendorSections(data);
  }


}
