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
    // getFlashProductData();
    super.onInit();
  }

  static HomeController get to => Get.find();
  RxList<SliderModel> sliderList = <SliderModel>[].obs;
  RxList<Company> companyList = <Company>[].obs;
  RxList<DistrictModel> categoryList = <DistrictModel>[].obs;
  RxList<ProductModel> productList = <ProductModel>[].obs;
  RxList<ProductModel> flashProductList = <ProductModel>[].obs;
  RxList<ProductModel> searchProductList = <ProductModel>[].obs;
  RxString activeCategoryIdHome = '1'.obs;
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
    if(initialCall){
      homeProductLoading(true);
      HomeController.to.initPageForHome(0);
      HomeController.to.pageCountForHome(1);
      productList.value= await HomeService.getProductList(key: searchKey.value
          .isNotEmpty?searchKey.value:null);
      homeProductLoading(false);
    }else{
      homeProductLoadMore(true);
      final data = await HomeService.getProductList(key: searchKey.value
          .isNotEmpty?searchKey.value:null,nextPageUrl: pageCountForHome
          .value.toString());
      productList.addAll(data);
      homeProductLoadMore(false);

    }

}
Future<void> getFlashProductData([bool initialCall =true]) async{
    if(initialCall){
      flashProductLoading(true);
      HomeController.to.initPageForFlash(0);
      HomeController.to.pageCountForFlash(1);
      flashProductList.value= await HomeService.getFlashProductList();
      flashProductLoading(false);
    }else{
      flashProductLoadMore(true);
      final data = await HomeService.getFlashProductList(nextPageUrl: pageCountForFlash
          .value.toString());
      flashProductList.addAll(data);
      flashProductLoadMore(false);

    }

}
Future<void> getSearchProductData(String key, [bool initialcall =true])async{
    if(initialcall){
      searchProductLoading(true);
      HomeController.to.initPageForSearch(0);
      HomeController.to.pageCountForSearch(1);
      searchProductList.value= await HomeService.getProductSearchList(key: key);
      searchProductLoading(false);
    }else{
      searchProductLoadMore(true);
      final data = await HomeService.getProductSearchList(nextPageUrl: pageCountForSearch.value.toString());
      searchProductList.addAll(data);
      searchProductLoadMore(false);
    }
}
Future<void> getCompanies()async{
    companyList.value=await HomeService.getcompanyList();

}Future<void> getCategories()async{
    categoryList.value=await HomeService.getCategories();

}
}
