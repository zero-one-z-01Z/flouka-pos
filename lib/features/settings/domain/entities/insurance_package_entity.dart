class InsurancePackageEntity {
  final int id;
  final num from;
  final num to;
  final num price;
  InsurancePackageEntity({required this.id, required this.from, required this.to, required this.price,});

  bool getInsurancePackage({required num price}){
    return ( price >= from && price <= to );
  }

}