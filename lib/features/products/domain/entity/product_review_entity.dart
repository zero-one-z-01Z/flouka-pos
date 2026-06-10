class ProductReviewEntity {
  final int id;
  final num rating;
  final String comment;
  final String createdAt;
  final List<ReviewImage> images;
  final ReviewUser user;
  const ProductReviewEntity({
    required this.id,
    required this.rating,
    required this.comment,
    required this.createdAt,
    required this.images,
    required this.user,
  });
}

class ReviewImage {
  final String image;
  final int id;
  ReviewImage({required this.image,required this.id});
}
class ReviewUser {
  final String image;
  final String name;
  final int id;
  ReviewUser({required this.image,required this.id,required this.name});
}
