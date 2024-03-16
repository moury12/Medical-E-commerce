import 'package:medi_source_apitest/controller/home_controller.dart';
import 'package:medi_source_apitest/models/district_model.dart';
import 'package:medi_source_apitest/models/product_model.dart';
import 'package:mh_core/services/api_service.dart';
import 'package:mh_core/utils/global.dart';
import 'package:mh_core/utils/string_utils.dart';

class HomeService {
  ///Slider Data
  static Future<List<SliderModel>> getSliderList() async {
    List<SliderModel> sliderList = [];
    final response = await ServiceAPI.genericCall(
      url: '${ServiceAPI.apiUrl}slider-list',
      httpMethod: HttpMethod.get,
    );
    globalLogger.d(response, "Get Slider Route");
    // Get.back();
    if (response['status'] != null && response['status']) {
      response['data'].forEach((cat) {
        sliderList.add(SliderModel.fromJson(cat));
      });
    } else if (response['status'] != null && !response['status']) {
      ServiceAPI.showAlert(errorMessageJson(response['message']));
    }

    return sliderList;
  }

  static Future<List<Company>> getcompanyList() async {
    List<Company> company = [];
    final response = await ServiceAPI.genericCall(
        url: '${ServiceAPI.apiUrl}company?paginate=50000',
        httpMethod: HttpMethod.get);
    globalLogger.d(response, "Get Company Route");
    if (response['status'] != null && response['status']) {
      response['data']['data'].forEach((com) {
        company.add(Company.fromJson(com));
      });
      globalLogger.d(response, 'Company list');
    } else if (response['status'] != null && !response['status']) {
      ServiceAPI.showAlert(errorMessageJson(response['message']));
    }
    return company;
  }

  static Future<List<DistrictModel>> getCategories() async {
    List<DistrictModel> categories = [];
    final response = await ServiceAPI.genericCall(
        url: '${ServiceAPI.apiUrl}categories', httpMethod: HttpMethod.get);
    globalLogger.d(response, "Get Company Route");
    if (response['status'] != null && response['status']) {
      response['data'].forEach((com) {
        categories.add(DistrictModel.fromJson(com));
      });
    } else if (response['status'] != null && !response['status']) {
      ServiceAPI.showAlert(errorMessageJson(response['message']));
    }
    return categories;
  }

  static Future<List<ProductModel>> getProductList(
      {String? key,
      int nextPageUrl = 1,
      int initPageForHome = 1,
      String? activeCategory,
      List? company}) async {
    List<ProductModel> productList = [];

    var url = '${ServiceAPI.apiUrl}products/?pagination=20&category_id'
        '=$activeCategory${company!.isEmpty ? '' : '&company_id=${company.toString()}'}&page=${nextPageUrl.toString() ?? '1'}';
    globalLogger.d(url, 'url');
    final response =
        await ServiceAPI.genericCall(url: url, httpMethod: HttpMethod.get);
    globalLogger.d(response, "Get products ");
    if (response['status'] != null && response['status']) {
      response['data']['data'].forEach((product) {
        productList.add(ProductModel.fromJson(product));
      });
      if (response['data']['next_page_url'] != null) {
        nextPageUrl++;
      } else {
        initPageForHome = -1;
      }
    } else {
      ServiceAPI.showAlert(response['message']);
    }
    return productList;
  }
  static Future<List<ProductModel>> getProductSearchList(
      {String? key,
      int nextPageUrl = 1,
      int initPage = 1,
    }) async {
    List<ProductModel> productList = [];

    var url = '${ServiceAPI.apiUrl}products/?${key!=null&&key.isNotEmpty
        ?'search=$key&':''}pagination=20'
        '&page=${nextPageUrl.toString() ?? '1'}';
    globalLogger.d(url, 'url');
    final response =
        await ServiceAPI.genericCall(url: url, httpMethod: HttpMethod.get);
    globalLogger.d(response, "Get products ");
    if (response['status'] != null && response['status']) {
      response['data']['data'].forEach((product) {
        productList.add(ProductModel.fromJson(product));
      });
      if (response['data']['next_page_url'] != null) {
        nextPageUrl++;
      } else {
        initPage = -1;
      }
    } else {
      ServiceAPI.showAlert(response['message']);
    }
    return productList;
  }
  static Future<List<ProductModel>> getFlashProductList(
      {String? key,
        int nextPageUrl = 1,
        int initPage = 1,
        String? activeCategory,
        }) async {
    List<ProductModel> productList = [];

    var url = '${ServiceAPI.apiUrl}products/?pagination=20&is_flash_sale=1&category_id'
        '=$activeCategory&page=${nextPageUrl.toString() ?? '1'}';
    globalLogger.d(url, 'url');
    final response =
    await ServiceAPI.genericCall(url: url, httpMethod: HttpMethod.get);
    globalLogger.d(response, "Get flash products ");
    if (response['status'] != null && response['status']) {
      response['data']['data'].forEach((product) {
        productList.add(ProductModel.fromJson(product));
      });
      if (response['data']['next_page_url'] != null) {
        nextPageUrl++;
      } else {
        initPage = -1;
      }
    } else {
      ServiceAPI.showAlert(response['message']);
    }
    return productList;
  }



}
