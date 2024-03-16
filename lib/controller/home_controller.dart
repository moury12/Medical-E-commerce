import 'package:get/get.dart';
import 'package:medi_source_apitest/api-service/home_service.dart';
import 'package:medi_source_apitest/models/district_model.dart';
import 'package:medi_source_apitest/models/product_model.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    // getHomePageAllLoad();
    getSliderData();
    getCategories();
    getProductData();
    getCompanies();
     getFlashProductData();
    super.onInit();
  }

  static HomeController get to => Get.find();
  RxList<SliderModel> sliderList = <SliderModel>[].obs;
  RxList<Company> companyList = <Company>[].obs;
  RxList<DistrictModel> categoryList = <DistrictModel>[].obs;
  RxList<ProductModel> productList = <ProductModel>[].obs;
  RxList<ProductModel> flashProductList = <ProductModel>[].obs;
  RxList<ProductModel> searchProductList = <ProductModel>[].obs;
  RxInt selectedCategoryIdHome = 1.obs;
  RxInt selectedCategoryIdFlash = 1.obs;
  RxInt initPageForHome = 1.obs;
  RxInt initPageForFlash = 1.obs;
  RxInt initPageForSearch = 1.obs;
  final RxString searchKey = ''.obs;
  RxInt pageCountForHome = 1.obs;
  RxInt pageCountForFlash = 1.obs;
  RxInt pageCountForSearch = 1.obs;
  RxString flashCategoryIDHome = '1'.obs;
  final RxBool homeProductLoadMore = false.obs;
  final RxBool searchProductLoadMore = false.obs;
  final RxBool flashProductLoadMore = false.obs;
  final RxBool allProductLoading = false.obs;
  final RxBool homeProductLoading = false.obs;
  final RxBool flashProductLoading = false.obs;
  final RxBool searchProductLoading = false.obs;
  Future<void> getHomePageAllLoad() async{
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
Future<void> getProductData([bool initialCall =true]) async{
  final com = companyList
      .where((p0) => p0.userCheck == true)
      .toList();
    if(initialCall){
      homeProductLoading(true);
    initPageForHome(0);
    pageCountForHome(1);
      productList.value=await HomeService.getProductList(
          initPageForHome: initPageForHome.value,
          nextPageUrl: pageCountForHome.value,
          activeCategory:
      selectedCategoryIdHome.value.toString(),company: com.map((e) =>
      e.id).toList());
      homeProductLoading(false);
    }else{
      homeProductLoadMore(true);
      final data = await HomeService.getProductList(
          initPageForHome: initPageForHome.value,
          nextPageUrl: pageCountForHome.value,
          activeCategory:
      selectedCategoryIdHome.value.toString(),company: com.map((e) =>
      e.id).toList());
      productList.addAll(data);
      homeProductLoadMore(false);

    }



}
Future<void> getSearchProductData(String? key,[bool initialCall =true]) async{

    if(initialCall){
      searchProductLoading(true);
    initPageForSearch(0);
    pageCountForSearch(1);
      searchProductList.value=await HomeService.getProductSearchList(
        key: key,
          initPage: initPageForSearch.value,
          nextPageUrl: pageCountForSearch.value,
         );
      searchProductLoading(false);
    }else{
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
  Future<void> getFlashProductData([bool initialCall =true]) async{

    if(initialCall){
      flashProductLoading(true);
      initPageForFlash(0);
      pageCountForFlash(1);
      flashProductList.value=await HomeService.getFlashProductList(
          initPage: initPageForFlash.value,
          nextPageUrl: pageCountForFlash.value,
          activeCategory:
          selectedCategoryIdFlash.value.toString());
      flashProductLoading(false);
    }else{
      flashProductLoadMore(true);
      final data = await HomeService.getFlashProductList(
          initPage: initPageForFlash.value,
          nextPageUrl: pageCountForFlash.value,
          activeCategory:
          selectedCategoryIdFlash.value.toString(),);
      flashProductList.addAll(data);
      flashProductLoadMore(false);

    }



  }

Future<void> getCompanies()async{
    companyList.value=await HomeService.getcompanyList();

}Future<void> getCategories()async{
    categoryList.value=await HomeService.getCategories();

}
}
