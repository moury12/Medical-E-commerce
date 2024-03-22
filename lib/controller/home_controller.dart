import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medi_source_apitest/DB/db_helper.dart';
import 'package:medi_source_apitest/api-service/home_service.dart';
import 'package:medi_source_apitest/main.dart';
import 'package:medi_source_apitest/models/cart_model.dart';
import 'package:medi_source_apitest/models/cart_model.dart';
import 'package:medi_source_apitest/models/district_model.dart';
import 'package:medi_source_apitest/models/order_model.dart';
import 'package:medi_source_apitest/models/order_model.dart';
import 'package:medi_source_apitest/models/product_model.dart';
import 'package:mh_core/utils/global.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    // getHomePageAllLoad();
    getSliderData();
    getCategories();
    getProductData();
    getCompanies();
    getFlashProductData();
    getCartData();
    getOrderList();
    scrollForOrder.addListener(orderScrollListener);
    super.onInit();
  }

  static HomeController get to => Get.find();
  ScrollController scrollForOrder =ScrollController();
  RxList<SliderModel> sliderList = <SliderModel>[].obs;
  RxList<Company> companyList = <Company>[].obs;
  RxList<DistrictModel> categoryList = <DistrictModel>[].obs;
  RxList<ProductModel> productList = <ProductModel>[].obs;
  RxList<ProductModel> flashProductList = <ProductModel>[].obs;
  RxList<ProductModel> searchProductList = <ProductModel>[].obs;
  RxList<OrderModel> orderList = <OrderModel>[].obs;
  RxList<CartModel> cartList = <CartModel>[].obs;
 /* Rx<double> subtotal =cartList.value.map((e) => double.parse(e.product
      .price??'0')*int
      .parse(e.quantity.toString())).toList().reduce((value, element) =>
  value + element).obs;
  Rx<double> discount =cartList.value.map((e) => double.parse(e.product
      .discountPrice??'0')*e.quantity
  ).toList().reduce((value, element) => value + element).obs;*/
  RxInt selectedCategoryIdHome = 1.obs;
  RxInt selectedCategoryIdFlash = 1.obs;
  RxInt initPageForHome = 1.obs;
  RxInt initPageForFlash = 1.obs;
  RxInt initPageForSearch = 1.obs;
  RxInt initPageForOrder = 1.obs;
  final RxString searchKey = ''.obs;
  RxInt pageCountForHome = 1.obs;
  RxInt pageCountForFlash = 1.obs;
  RxInt pageCountForSearch = 1.obs;
  RxInt pageCountForOrder = 1.obs;
  RxString flashCategoryIDHome = '1'.obs;
  final RxBool homeProductLoadMore = false.obs;
  final RxBool searchProductLoadMore = false.obs;
  final RxBool flashProductLoadMore = false.obs;
  final RxBool orderProductLoadMore = false.obs;
  final RxBool allProductLoading = false.obs;
  final RxBool homeProductLoading = false.obs;
  final RxBool flashProductLoading = false.obs;
  final RxBool searchProductLoading = false.obs;
  final RxBool orderProductLoading = false.obs;
  Future<void> getHomePageAllLoad() async {
    allProductLoading(true);
    getSliderData();
    getProductData();
    getCompanies();
    getCategories();
    allProductLoading(false);
  }

  Future<void> getSliderData() async {
    sliderList.value = await HomeService.getSliderList();
  }

  Future<void> getProductData([bool initialCall = true]) async {
    final com = companyList.where((p0) => p0.userCheck == true).toList();
    if (initialCall) {
      homeProductLoading(true);
      initPageForHome(0);
      pageCountForHome(1);
      productList.value = await HomeService.getProductList(
          initPageForHome: initPageForHome.value,
          nextPageUrl: pageCountForHome.value,
          activeCategory: selectedCategoryIdHome.value.toString(),
          company: com.map((e) => e.id).toList());
      homeProductLoading(false);
    } else {
      homeProductLoadMore(true);
      final data = await HomeService.getProductList(
          initPageForHome: initPageForHome.value,
          nextPageUrl: pageCountForHome.value,
          activeCategory: selectedCategoryIdHome.value.toString(),
          company: com.map((e) => e.id).toList());
      productList.addAll(data);
      homeProductLoadMore(false);
    }
  }

  Future<void> getSearchProductData(String? key,
      [bool initialCall = true]) async {
    if (initialCall) {
      searchProductLoading(true);
      initPageForSearch(0);
      pageCountForSearch(1);
      searchProductList.value = await HomeService.getProductSearchList(
        key: key,
        initPage: initPageForSearch.value,
        nextPageUrl: pageCountForSearch.value,
      );
      searchProductLoading(false);
    } else {
      searchProductLoadMore(true);
      final data = await HomeService.getProductSearchList(
        key: key,
        initPage: initPageForSearch.value,
        nextPageUrl: pageCountForSearch.value,
      );
      searchProductList.addAll(data);
      searchProductLoadMore(false);
    }
  }

  Future<void> getFlashProductData([bool initialCall = true]) async {
    if (initialCall) {
      flashProductLoading(true);
      initPageForFlash(0);
      pageCountForFlash(1);
      flashProductList.value = await HomeService.getFlashProductList(
          initPage: initPageForFlash.value,
          nextPageUrl: pageCountForFlash.value,
          activeCategory: selectedCategoryIdFlash.value.toString());
      flashProductLoading(false);
    } else {
      flashProductLoadMore(true);
      final data = await HomeService.getFlashProductList(
        initPage: initPageForFlash.value,
        nextPageUrl: pageCountForFlash.value,
        activeCategory: selectedCategoryIdFlash.value.toString(),
      );
      flashProductList.addAll(data);
      flashProductLoadMore(false);
    }
  }

  Future<void> getOrderList([bool initialCall = true]) async {
    if (initialCall) {
      orderProductLoading(true);
      initPageForOrder(0);
      pageCountForOrder(1);
      orderList.value =
          await HomeService.getOrderData(pageCountForOrder.value.toString());
      orderProductLoading(false);
    }
    else{
      orderProductLoadMore(true);
      orderList.value =
      await HomeService.getOrderData(pageCountForOrder.value.toString());
      orderProductLoadMore(false);

    }
  }

  Future<void> getCompanies() async {
    companyList.value = await HomeService.getcompanyList();
  }

  Future<void> getCategories() async {
    categoryList.value = await HomeService.getCategories();
  }

  ///Cart operation
  void getCartData() async {
    final cartData = await DbHelper.fetchCart();
    cartList.assignAll(cartData.map((e) {
      // Check if 'product_data' is a String, and decode it if necessary
      final dynamic productData = e['product_data'];
      final productJson =
          productData is String ? jsonDecode(productData) : productData;
      return CartModel.fromJson({
        'id': e['id'],
        'product_data': productJson,
        'quantity': e['quantity'],
      });
    }));
    globalLogger.d(cartData, 'cart');
  }

  void addToCart(ProductModel product, int quantity) async {
    await DbHelper.addToCart(product, quantity);
    getCartData();
  }

  void removeFromCart(int id) async {
    await DbHelper.removeFromCart(id);
    getCartData();
  }

  void updateCart(int id, int newQuantity) async {
    await DbHelper.updateCartQuantity(id, newQuantity);
    getCartData();
  }

  void deleteCartList() async {
    await DbHelper.deleteCartData();
    cartList.clear();
  }

  Future<void> checkoutCall(dynamic body) async {
    final isSuccess = await HomeService.checkoutCall(body);
    if (isSuccess) {
      showSnackBar(msg: 'Order placed successfully');
      deleteCartList();
      await getOrderList();
    } else {
      showSnackBar(msg: 'Order can\'t placed successfully');
    }
  }

  Future<void> orderScrollListener() async {
    if(scrollForOrder.position.pixels==scrollForOrder.position.maxScrollExtent){
      if(initPageForOrder.value!=-1){
        if(!orderProductLoadMore.value){
          await getOrderList(false);
        }
      }
    }
  }
}
