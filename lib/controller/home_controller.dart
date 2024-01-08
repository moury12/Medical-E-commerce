import 'package:get/get.dart';
import 'package:medi_source_apitest/api-service/home_service.dart';
import 'package:medi_source_apitest/models/district_model.dart';
import 'package:medi_source_apitest/models/product_model.dart';

class HomeController extends GetxController{
  @override
  void onInit() {
   getSliderData();
    super.onInit();
  }
  static HomeController  get to =>Get.find();
  RxList<SliderModel> sliderList = <SliderModel>[].obs;
  RxList<Company> companyList =<Company>[].obs;
RxString activeCategoryIdHome ='1'.obs;

Future <void> getSliderData () async{
sliderList.value=await HomeService.getSliderList();
}
}