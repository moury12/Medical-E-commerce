import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_source_apitest/controller/home_controller.dart';
import 'package:medi_source_apitest/pages/home_page.dart';
import 'package:mh_core/widgets/network_image/network_image.dart';
import 'package:mh_core/widgets/textfield/custom_textfield.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search';

  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController =ScrollController();
  @override
  void dispose() {
    searchController.dispose();
    scrollController.dispose();
    super.dispose();
  }
@override
  void initState() {
    scrollController.addListener(_scrolListener);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [

          CustomTextField(
            controller: searchController,
            hintText: 'Search Product',
            onChanged: (value) {
              HomeController.to.getSearchProductData(value);
              setState(() {

              });
            },
          ),
          searchController.text.isEmpty
              ? SizedBox.shrink()
              : Expanded(
                child: SingleChildScrollView(
                            controller: scrollController,
                  child: Column(
                    children: [
                      Obx(() {
                          if (HomeController.to.allProductLoading.value) {
                            return CircularProgressIndicator();
                          }
                          if (HomeController.to.searchProductList.isEmpty) {
                            return Text('there is no product');
                          }
                          return GridView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: HomeController.to.searchProductList.value.length,
                            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                            ),
                            itemBuilder: (context, index) {
                              final product =
                                  HomeController.to.searchProductList.value[index];
                              return ProductCardWidget(product: product);
                            },
                          );
                        }),
                    ],
                  ),
                ),
              ),
          Obx(() => HomeController.to.searchProductLoadMore.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox.shrink())
        ],
      ),
    );
  }

  Future<void> _scrolListener() async{
    if(scrollController.position.pixels==scrollController.position.maxScrollExtent){
      if(HomeController.to.initPageForSearch.value!=-1){
        if(!HomeController.to.searchProductLoadMore.value){
HomeController.to.getSearchProductData(searchController.text,false);
        }
      }
    }
  }
}
