class CategoryModel{
  bool ? status ;
  CategoryDataModel ? data ;
  CategoryModel.fromJson(json){
    status=json['status'] ;
    data = CategoryDataModel.fromJson(json['data']) ;
  }
}
class CategoryDataModel{
  int ? currentPage  ;
  List ? data = [] ;
  CategoryDataModel.fromJson(json){
    currentPage = json['current_Page'];
    json['data'].forEach((element) {
      data!.add(DataModel.fromJson(element));
    }) ;
  }
}
class DataModel{
  int ? id ;
  String ? name  , image ;
  DataModel.fromJson(json){
    id=json['id'] ;
    name=json['name'] ;
    image=json['image'] ;
  }
}