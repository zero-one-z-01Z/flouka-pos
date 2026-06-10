
import 'dart:developer';

import '../../domain/entity/product_review_entity.dart';

class ProductReviewModel extends ProductReviewEntity {
  const ProductReviewModel({
    required super.id,
    required super.images,
    required super.rating,
    required super.comment,
    required super.createdAt,
    required super.user,
  });

  factory ProductReviewModel.fromJson(Map<String, dynamic> json) {
    List<ReviewImageModel> images=[];
    if(json['images'] !=null){
      for(var element in json['images']){
        images.add(ReviewImageModel.fromJson(element));
      }
    }
    return ProductReviewModel(
      id: json['id'],
      images: images,
      rating: json['rating'],
      comment: json['comment'],
      createdAt: json['created_at'],
      user: ReviewUserModel.fromJson(json['user']),


    );
  }
}
class ReviewImageModel extends ReviewImage {
  ReviewImageModel({
    required super.image,
    required super.id
  });

  factory ReviewImageModel.fromJson(Map<String, dynamic> json) {
    try {
      return ReviewImageModel(image: json['image'],id: json['id'],);
    } catch (e, l) {
      log(l.toString());
      log(e.toString());
      throw e;
    }
  }
}

class ReviewUserModel extends ReviewUser {
  ReviewUserModel({
    required super.image,
    required super.id,
    required super.name,

  });

  factory ReviewUserModel.fromJson(Map<String, dynamic> json) {
    try {
      return ReviewUserModel(image: json['image'],id: json['id'],name: json['name']);
    } catch (e, l) {
      log(l.toString());
      log(e.toString());
      throw e;
    }
  }
}
