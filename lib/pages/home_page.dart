import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_source_apitest/constant/global.dart';
import 'package:medi_source_apitest/controller/home_controller.dart';
import 'package:medi_source_apitest/models/cart_model.dart';
import 'package:medi_source_apitest/models/product_model.dart';
import 'package:medi_source_apitest/pages/cart_page.dart';
import 'package:medi_source_apitest/pages/flash_product_page.dart';
import 'package:medi_source_apitest/pages/order_list_page.dart';
import 'package:medi_source_apitest/pages/profile_page.dart';
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
  void dispose() {
    searchController.dispose();
    scrollController.dispose();
    super.dispose();
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
            padding: const EdgeInsets.symmetric(horizontal: 8),
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
          Row(
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
          )
        ],
      )),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(onPressed: () => Get.toNamed(OrderListScreen.routeName),
              icon: const Icon(Icons.shopping_bag)),  IconButton(onPressed:
              () => Get.toNamed(ProfileScreen.routeName),
              icon: const Icon(CupertinoIcons.profile_circled)), IconButton(onPressed: () => Get
              .toNamed(CartScreen.routeName),
              icon: const Icon(CupertinoIcons.shopping_cart)),
          IconButton(
              onPressed: () {
                Get.toNamed(ProductFlashScreen.routeName);
              },
              icon: const Icon(Icons.flash_auto))
        ],
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(Icons.menu),
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
              child: const CustomTextField(
                hintText: 'Search Product',
                isEnable: false,
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
            Obx(() {
              if (HomeController.to.allProductLoading.value) {
                return const CircularProgressIndicator();
              }
              if (HomeController.to.productList.isEmpty) {
                return const Text('there is no product');
              }
              return GridView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: HomeController.to.productList.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                ),
                itemBuilder: (context, index) {
                  final product = HomeController.to.productList[index];
                  return ProductCardWidget(product: product);
                },
              );
            }),
            Obx(() => HomeController.to.homeProductLoadMore.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : const SizedBox.shrink())
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

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomNetworkImage(
          networkImagePath: product.image ?? '',
          height: 100,
        ),
        Obx(() {
          final cartItem = HomeController.to.cartList.firstWhere(
            (e) => e.product.id == product.id,
            orElse: () => CartModel(id: -1, product: product, quantity: 0),
          );
          return cartItem.id == -1
              ? CustomButton(
            marginVertical: 0,
                  label: 'Add '
                      'to Cart',
                  onPressed: () {
                    HomeController.to.addToCart(product, 1);
                  },
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: () {
                          HomeController.to
                              .updateCart(cartItem.id, cartItem.quantity + 1);
                        },
                        icon: const Icon(CupertinoIcons.plus)),
                    Text(cartItem.quantity.toString()),
                    IconButton(
                        onPressed: () {
                          if (cartItem.quantity > 1) {
                            HomeController.to
                                .updateCart(cartItem.id, cartItem.quantity - 1);
                          } else {
                            HomeController.to.removeFromCart(cartItem.id);
                          }
                        },
                        icon: const Icon(CupertinoIcons.minus)),
                  ],
                );
        })
      ],
    );
  }
}
