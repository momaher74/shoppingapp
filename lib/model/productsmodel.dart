class ProductsModel {
  ProductData? data;

  ProductsModel.fromJson(json) {
    data = ProductData.fromJson(json['data']);
  }
}

class ProductData {
  List products = [];

  List banners = [];

  ProductData.fromJson(json) {
    json['products'].forEach((element) {
      products.add(ProductsDataModel.fromJson(element));
    });

    json['banners'].forEach((element) {
      banners.add(BannersDataModel.fromJson(element));
    });
  }
}

class ProductsDataModel {
  dynamic id;

  dynamic price;

  dynamic oldPrice;

  dynamic discount;

  String? image;

  String? name;

  String? description;

  bool? in_favorites;

  bool? in_cart;

  ProductsDataModel.fromJson(Map json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    in_favorites = json['in_favorites'];
    in_cart = json['in_cart'];
  }
}

class BannersDataModel {
  int? id;

  String? image;

  BannersDataModel.fromJson(json) {
    id = json['id'];
    image = json['image'];
  }
}
