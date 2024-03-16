import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_source_apitest/controller/home_controller.dart';
import 'package:mh_core/widgets/network_image/network_image.dart';

class ProductFlashScreen extends StatefulWidget {
  static const String routeName ='/flash';
  const ProductFlashScreen({super.key});

  @override
  State<ProductFlashScreen> createState() => _ProductFlashScreenState();
}

class _ProductFlashScreenState extends State<ProductFlashScreen> {
  ScrollController scrollController =ScrollController();
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    scrollController.addListener(_scrolListener);
    // TODO: implement initState
    super.initState();
  }
  Future<void> _scrolListener() async{
    if(scrollController.position.pixels==scrollController.position.maxScrollExtent){
      if(HomeController.to.initPageForFlash.value!=-1){
        if(!HomeController.to.flashProductLoadMore.value){
          HomeController.to.getFlashProductData(false);
        }
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ...List.generate(HomeController.to.categoryList.length,
                          (index) {
                        final data = HomeController.to.categoryList[index];
                        bool isSelected =
                            HomeController.to.selectedCategoryIdFlash.value ==
                                int.parse(data.id);

                        return GestureDetector(
                          onTap: () async {
                            HomeController.to
                                .selectedCategoryIdFlash(int.parse(data.id));
                            HomeController.to.getFlashProductData();
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
            Obx(() {
              if (HomeController.to.allProductLoading.value) {
                return const CircularProgressIndicator();
              }
              if (HomeController.to.flashProductList.isEmpty) {
                return const Text('there is no product');
              }
              return GridView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: HomeController.to.flashProductList.value.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                ),
                itemBuilder: (context, index) {
                  final product = HomeController.to.flashProductList.value[index];
                  return CustomNetworkImage(
                    networkImagePath: product.image ?? '',
                  );
                },
              );
            }),
            Obx(() => HomeController.to.flashProductLoadMore.value
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : const SizedBox.shrink())
          ],
        ),
      ),
    );
  }
}
