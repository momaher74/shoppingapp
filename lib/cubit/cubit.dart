import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasksappsqflitenew/cubit/states.dart';
import 'package:tasksappsqflitenew/helpers/diohelper.dart';
import 'package:tasksappsqflitenew/helpers/sharedpref.dart';
import 'package:tasksappsqflitenew/main.dart';
import 'package:tasksappsqflitenew/model/addordermodel.dart';
import 'package:tasksappsqflitenew/model/addressmodel.dart';
import 'package:tasksappsqflitenew/model/changecartmodel.dart';
import 'package:tasksappsqflitenew/model/favouritemodel.dart';
import 'package:tasksappsqflitenew/model/addandremovefavmodel.dart';
import 'package:tasksappsqflitenew/model/bannermodel.dart';
import 'package:tasksappsqflitenew/model/categorymodel.dart';
import 'package:tasksappsqflitenew/model/complaintmodel.dart';
import 'package:tasksappsqflitenew/model/contactsmodel.dart';
import 'package:tasksappsqflitenew/model/getaddressmodel.dart';
import 'package:tasksappsqflitenew/model/notificationmodel.dart';
import 'package:tasksappsqflitenew/model/productsmodel.dart';
import 'package:tasksappsqflitenew/model/profilemodel.dart';
import 'package:tasksappsqflitenew/model/repeatedquestionsmodel.dart';
import 'package:tasksappsqflitenew/model/usermodel.dart';
import 'package:tasksappsqflitenew/screens/cartscreen.dart';
import 'package:tasksappsqflitenew/screens/favscreen.dart';
import 'package:tasksappsqflitenew/screens/homescreen.dart';
import 'package:tasksappsqflitenew/screens/productscreen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;

  login({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(url: 'login', data: {
      'email': email,
      'password': password,
    }).then((value) {
      userModel = UserModel.fromJson(value.data);
      emit(LoginSuccessState());
    }).catchError((error) {
      emit(LoginErrorState());
    });
  }

  signup({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(url: 'register', data: {
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
      'image': 'adsfa',
    }).then((value) {
      userModel = UserModel.fromJson(value.data);
      emit(RegisterSuccessState());
    }).catchError((error) {
      emit(RegisterErrorState());
    });
  }

  BannersModel? bannersModel;

  void getBanners() {
    emit(GetBannersLoadingState());
    DioHelper.getData(url: 'banners').then((value) {
      bannersModel = BannersModel.fromJson(value.data);
      emit(GetBannersSuccessState());
    }).catchError((error) {
      emit(GetBannersErrorState());
    });
  }

  CategoryModel? categoryModel;

  void getCategory() {
    emit(GetCategoryLoadingState());
    DioHelper.getData(
      url: 'categories',
    ).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);

      emit(GetCategorySuccessState());
    }).catchError((error) {
      emit(GetCategoryErrorState());
    });
  }

  int currentIndex = 0;

  changeNavScreen(int index) {
    currentIndex = index;
    emit(ChangeNavbarState());
  }

  List<Widget> screens = [
    const HomeScreen(),
    const ProductScreen(),
    const FavScreen(),
    const CartScreen(),
  ];
  List<String> titles = [
    'Home',
    'Products',
    'Favourites',
    'Cart',
  ];
  ContactsModel? contactsModel;

  getContacts() {
    emit(GetCategoryLoadingState());
    DioHelper.getData(
      url: 'contacts',
    ).then((value) {
      contactsModel = ContactsModel.fromJson(value.data);
      emit(GetContactsSuccessState());
    }).catchError((error) {
      emit(GetContactsErrorState());
    });
  }

  ComplaintModel? complaintModel;

  complaint({
    required String name,
    required int phone,
    required String email,
    required String message,
  }) {
    emit(ComplaintLoadingState());
    DioHelper.postData(
      url: 'complaints',
      data: {
        'name': name,
        'phone': phone,
        'email': email,
        'message': message,
      },
    ).then((value) {
      complaintModel = ComplaintModel.fromJson(value.data);
      emit(ComplaintSuccessState());
    }).catchError((error) {
      print(error);
      emit(ComplaintErrorState());
    });
  }

  RepeatedQuestions? repeatedQuestions;

  repeatedQuestionsFun() {
    emit(GetRepeatedQuestionsLoadingState());
    DioHelper.getData(url: 'faqs').then((value) {
      repeatedQuestions = RepeatedQuestions.fromJson(value.data);
      emit(GetRepeatedQuestionsSuccessState());
    }).catchError((error) {
      emit(GetRepeatedQuestionsErrorState());
    });
  }

  ProductsModel? productsModel;
  Map favorites = {};
  List cart = [];

  getHomeData() {
    cart = [];
    emit(GetHomeDataLoadingState());
    DioHelper.getData(url: 'home', token: token).then((value) {
      productsModel = ProductsModel.fromJson(value.data);
      productsModel!.data!.products.forEach((element) {
        favorites.addAll({
          element.id: element.in_favorites,
        });
      });
      productsModel!.data!.products.forEach((element) {
        if (element.in_cart == true) {
          cart.add(element);
        }
      });
      emit(GetHomeDataSuccessState());
    }).catchError((error) {
      print(error);
      emit(GetHomeDataErrorState());
    });
  }

  NotificationModel? notificationModel;

  getNotification() {
    emit(GetNotificationLoadingState());
    DioHelper.getData(url: 'notifications', token: token).then((value) {
      notificationModel = NotificationModel.fromJson(value.data);
      emit(GetNotificationSuccessState());
    }).catchError((error) {
      emit(GetNotificationErrorState());
    });
  }

  ChangeFavModel? changeFavModel;

  changeFavorites(int? id) {
    favorites[id] = !favorites[id];
    emit(ChangeFavoritesLoadingState());
    DioHelper.postData(
      url: 'favorites',
      data: {
        'product_id': id,
      },
      token: token,
    ).then((value) {
      changeFavModel = ChangeFavModel.fromJson(value.data);
      getFavorites();
      emit(ChangeFavoritesSuccessState());
    }).catchError((error) {
      print(error);
      emit(ChangeFavoritesErrorState());
    });
  }

  FavouriteModel? favoritesModel;

  getFavorites() {
    emit(GetFavoritesLoadingState());
    DioHelper.getData(url: 'favorites', token: token).then((value) {
      favoritesModel = FavouriteModel.fromJson(value.data);
      //print(favoritesModel!.data!.data[0].product.image) ;
      emit(GetFavoritesSuccessState());
    }).catchError((error) {
      emit(GetFavoritesErrorState());
    });
  }

  ChangeCartModel? changeCartModel;

  changeCart(int? id) {
    emit(ChangeCartLoadingState());
    DioHelper.postData(
      url: 'carts',
      data: {
        "product_id": id,
      },
      token: token,
    ).then((value) {
      changeCartModel = ChangeCartModel.fromJson(value.data);
      emit(ChangeCartSuccessState());
    }).catchError((error) {
      emit(ChangeCartErrorState());
    });
  }

  var getCartData;

  getCart() {
    emit(GetCartLoadingState());
    DioHelper.getData(
      url: 'carts',
      token: token,
    ).then((value) {
      getCartData = value.data;
      emit(GetCartSuccessState());
    }).catchError((error) {
      emit(GetCartErrorState());
    });
  }

  bool? dark;

  changeTheme(bool? mode) {
    dark = !mode!;
    emit(ChangeThemeSuccessState());
    CacheHelper.putBoolean(key: 'dark', value: dark!).then((value) {
      emit(ChangeThemeSuccessState());
    });
  }

  AddOrderModel? addOrderModel;

  void addOrder({
    required int? num,
  }) {
    emit(AddOrderLoadingState());
    DioHelper.postData(url: 'orders', data: {
      "address_id": 35,
      "payment_method": num,
      "use_points": false,
      "promo_code_id": false,
    }).then((value) {
      addOrderModel = AddOrderModel.fromJson(value.data);
      emit(AddOrderSuccessState());
    }).catchError((error) {
      emit(AddOrderErrorState());
    });
  }

  bool appear = false;

  void changeAppear() {
    appear = !appear;
    emit(ChangeAppearSuccessState());
  }

  var ordersList;

  void getOrders() {
    emit(GetOrdersLoadingState());
    DioHelper.getData(url: 'orders').then((value) {
      ordersList = value.data;
      emit(GetOrdersSuccessState());
    }).catchError((error) {
      emit(GetOrdersErrorState());
    });
  }

  AddressModel? addressModel;

  void address({
    required String? name,
    required String? city,
    required String? region,
    required String? details,
    required String? notes,
  }) {
    emit(AddAddressLoadingState());
    DioHelper.postData(url: 'addresses', data: {
      "name": name,
      "city": city,
      "region": region,
      "details": details,
      "latitude": 30.0616863,
      "longitude": 31.3260088,
      "notes": notes,
    }).then((value) {
      addressModel = AddressModel.fromJson(value.data);
      emit(AddAddressSuccessState());
    }).catchError((error) {
      emit(AddAddressErrorState());
    });
  }

  var getAddData;

  void getAddress() {
    emit(GetAddressLoadingState());
    DioHelper.getData(url: 'addresses').then((value) {
      getAddData = value.data;
      emit(GetAddressSuccessState());
    }).catchError((error) {
      emit(GetAddressErrorState());
    });
  }

  ProfileModel? profileModel;

  void viewProfile() {
    emit(ViewProfileLoadingState());
    DioHelper.getData(url: 'profile').then((value) {
      profileModel = ProfileModel.fromJson(value.data);
      emit(ViewProfileSuccessState());
    }).catchError((error) {
      emit(ViewProfileErrorState());
    });
  }

  ImagePicker picker = ImagePicker();
  File? prodImage;

  Future<void> pickProductImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      prodImage = File(pickedFile.path);
      emit(PickProdImgSuccessState());
    } else {
      emit(PickProdImgErrorState());
    }
  }
}
