import 'dart:core';

class Product {

  const Product({
    this.productName,this.desscription,this.images,this.price,this.discountPrice
  });

  final String productName;
  final String desscription;
  final List<String> images;
  final int price;
  final int discountPrice;

  factory Product.fromJson(Map<String,dynamic> json){
    return Product(
      productName: json['product_name']
    );

  }
}

class HomeProduct {
   HomeProduct({
    this.productName,this.id,this.image,this.price
  });

  final String id;
  String productName;
  final String image;
  final int price;

  factory HomeProduct.fromJson(Map<String,dynamic> json){
    return HomeProduct(
      id: json['product_id'],
      productName: json['product_name'],
      image:  'https://p0.pikrepo.com/preview/351/5/nivea-soft-tube-on-white-surface-thumbnail.jpg',// json['image']
      price: json['price']
    );

  }

}