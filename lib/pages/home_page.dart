import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_source_apitest/constant/global.dart';
import 'package:medi_source_apitest/controller/home_controller.dart';
import 'package:medi_source_apitest/pages/search_page.dart';
import 'package:mh_core/widgets/button/custom_button.dart';
import 'package:mh_core/widgets/network_image/network_image.dart';
import 'package:mh_core/widgets/textfield/custom_textfield.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    scrollController.addListener(_scrolListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
          child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).viewPadding.top,
          ),
          CustomTextField(
            marginVertical: 0,
            controller: searchController,
            onChanged: (value) {
              HomeController.to.companyList
                  .where((p0) => p0.name!.toLowerCase().contains(value))
                  .toList();
              setState(() {});
            },
            hintText: 'Search company',
          ),
          Expanded(
              child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 8),
            itemCount: searchController.text.isNotEmpty
                ? HomeController.to.companyList
                    .where((p0) =>
                        p0.name!.toLowerCase().contains(searchController.text))
                    .toList()
                    .length
                : HomeController.to.companyList.length,
            itemBuilder: (context, index) {
              final company = searchController.text.isNotEmpty
                  ? HomeController.to.companyList
                      .where((p0) => p0.name!
                          .toLowerCase()
                          .contains(searchController.text))
                      .toList()[index]
                  : HomeController.to.companyList[index];
              return CheckboxListTile(
                title: Text(company.name ?? ''),
                value: company.userCheck,
                onChanged: (value) {
                  company.userCheck = value;
                  setState(() {});
                },
              );
            },
          )),
          Container(
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    label: 'Apply',
                    marginVertical: 8,
                    onPressed: () {
                      Get.back();
                      HomeController.to.getProductData();
                    },
                  ),
                ),
                Expanded(
                  child: CustomButton(
                    label: 'Reset',
                    marginVertical: 8,
                    onPressed: () {
                      for (int i = 0;
                          i < HomeController.to.companyList.length;
                          i++) {
                        HomeController.to.companyList[i].userCheck = false;
                        setState(() {});
                        HomeController.to.getProductData();
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      )),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            Obx(() {
              return Row(
                children:
                    List.generate(HomeController.to.sliderList.length, (index) {
                  final slider = HomeController.to.sliderList[index];
                  return CustomNetworkImage(
                    networkImagePath: slider.image ?? '',
                    borderRadius: 0,
                    height: 200,
                  );
                }),
              );
            }),
            GestureDetector(
              onTap: () {
                Get.toNamed(SearchScreen.routeName);
              },
              child: CustomTextField(
                hintText: 'Search Product',
              ),
            ),
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ...List.generate(HomeController.to.categoryList.length,
                      (index) {
                    final data = HomeController.to.categoryList[index];
                    bool isSelected =
                        HomeController.to.selectedCategoryIdHome.value ==
                            int.parse(data.id);

                    return GestureDetector(
                      onTap: () async {
                        HomeController.to
                            .selectedCategoryIdHome(int.parse(data.id));
                        HomeController.to.getProductData();
                      },
                      child: Text(
                        data.name,
                        style: TextStyle(
                            color: isSelected ? Colors.green : Colors.black),
                      ),
                    );
                  })
                ],
              );
            }),
            Obx(() {if(HomeController.to.allProductLoading.value){
              return CircularProgressIndicator();
            }
            if(HomeController.to.productList.isEmpty){
              return Text('there is no product');
            }
              return GridView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: HomeController.to.productList.value.length,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                ),
                itemBuilder: (context, index) {
                  final product = HomeController.to.productList.value[index];
                  return CustomNetworkImage(
                    networkImagePath: product.image ?? '',
                  );
                },
              );
            }),
            Obx(() => HomeController.to.homeProductLoadMore.value
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SizedBox.shrink())
            /* Obx(() => HomeController.to.homeProductLoading.value?CircularProgressIndicator():HomeController.to.productList.isEmpty?Center(child: Text('there is no product'),):GridView.builder( itemCount:HomeController.to.productList.length ,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                mainAxisExtent: 210, maxCrossAxisExtent: 200, crossAxisSpacing: 20, mainAxisSpacing: 20),
            itemBuilder: (context, index) {
            final product= HomeController.to.productList[index];
            return Container(child: Column(children: [Text(product.name??'')],),);
          },))*/
          ],
        ),
      ),
    );
  }

  Future<void> _scrolListener() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (HomeController.to.initPageForHome.value != -1) {
        if (!HomeController.to.homeProductLoadMore.value) {
          HomeController.to.getProductData(false);
        }
      }
    }
  }
}
