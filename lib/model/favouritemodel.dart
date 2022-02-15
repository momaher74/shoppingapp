class FavouriteModel {
  DataModel? data;

  FavouriteModel.fromJson(Map json) {
    data = DataModel.fromJson(json['data']);
  }
}

class DataModel {
  List data = [];

  DataModel.fromJson(Map json) {
    json['data'].forEach((element) {
      data.add(Data.fromJson(element));
    });
  }
}

class Data {
  Product? product;

  Data.fromJson(Map json) {
    product = Product.fromJson(json['product']);
  }
}

class Product {
  int? id;

  dynamic price;

  dynamic oldPrice;

  dynamic discount;

  String? image;

  String? name;

  String? description;

  Product.fromJson(Map json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}

// class FavouriteModel {
//   FavouriteModel({
//     required this.status,
//     this.message,
//     required this.data,
//   });
//   late final bool status;
//   late final Null message;
//   late final Data data;
//
//   FavouriteModel.fromJson(Map<String, dynamic> json){
//     status = json['status'];
//     message = json['message'];
//     data = Data.fromJson(json['data']);
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['status'] = status;
//     _data['message'] = message;
//     _data['data'] = data.toJson();
//     return _data;
//   }
// }
//
// class Data {
//   Data({
//     required this.currentPage,
//     required this.data,
//     required this.firstPageUrl,
//     required this.from,
//     required this.lastPage,
//     required this.lastPageUrl,
//     this.nextPageUrl,
//     required this.path,
//     required this.perPage,
//     this.prevPageUrl,
//     required this.to,
//     required this.total,
//   });
//   late final int currentPage;
//   late final List<Data> data;
//   late final String firstPageUrl;
//   late final int from;
//   late final int lastPage;
//   late final String lastPageUrl;
//   late final Null nextPageUrl;
//   late final String path;
//   late final int perPage;
//   late final Null prevPageUrl;
//   late final int to;
//   late final int total;
//
//   Data.fromJson(Map<String, dynamic> json){
//     currentPage = json['current_page'];
//     data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
//     firstPageUrl = json['first_page_url'];
//     from = json['from'];
//     lastPage = json['last_page'];
//     lastPageUrl = json['last_page_url'];
//     nextPageUrl = json['next_page_url'];
//     path = json['path'];
//     perPage = json['per_page'];
//     prevPageUrl = json['prev_page_url'];
//     to = json['to'];
//     total = json['total'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['current_page'] = currentPage;
//     _data['data'] = data.map((e)=>e.toJson()).toList();
//     _data['first_page_url'] = firstPageUrl;
//     _data['from'] = from;
//     _data['last_page'] = lastPage;
//     _data['last_page_url'] = lastPageUrl;
//     _data['next_page_url'] = nextPageUrl;
//     _data['path'] = path;
//     _data['per_page'] = perPage;
//     _data['prev_page_url'] = prevPageUrl;
//     _data['to'] = to;
//     _data['total'] = total;
//     return _data;
//   }}