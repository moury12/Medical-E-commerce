import 'package:get/get.dart';
import 'package:medi_source_apitest/api-service/home_service.dart';
import 'package:medi_source_apitest/models/district_model.dart';
import 'package:medi_source_apitest/models/product_model.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    getSliderData();
    getProductData();
    super.onInit();
  }

  static HomeController get to => Get.find();
  RxList<SliderModel> sliderList = <SliderModel>[].obs;
  RxList<Company> companyList = <Company>[].obs;
  RxList<ProductModel> productList = <ProductModel>[].obs;
  RxString activeCategoryIdHome = '1'.obs;
  RxInt initPageForHome = 1.obs;
  final RxString searchKey = ''.obs;
  RxInt pageCountForHome = 1.obs;
  RxString flashCategoryIDHome = '1'.obs;
  final RxBool allProductLoadMore = false.obs;
  final RxBool searchProductLoadMore = false.obs;
  final RxBool allProductLoading = false.obs;
  final RxBool HomeProductLoading = false.obs;
  Future<void> getSliderData() async {
    sliderList.value = await HomeService.getSliderList();
  }
Future<void> getProductData([bool initialCall =true]) async{
    if(initialCall){
      HomeProductLoading(true);
      HomeController.to.initPageForHome(0);
      HomeController.to.pageCountForHome(1);
      productList.value= await HomeService.getProductList(key: searchKey
          .isNotEmpty?searchKey.value:null);
      HomeProductLoading(false);
    }else{
      allProductLoadMore(true);
      final data = await HomeService.getProductList(key: searchKey
          .isNotEmpty?searchKey.value:null,nextPageUrl: pageCountForHome
          .value.toString());
      productList.addAll(data);
      allProductLoadMore(false);

    }

}
}
