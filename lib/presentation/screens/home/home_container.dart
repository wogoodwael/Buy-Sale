import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shopping/business_logic/Cubit/categories/categories_cubit.dart';
import 'package:shopping/core/utils/colors.dart';

import 'package:shopping/core/utils/strings.dart';
import 'package:shopping/data/models/categories_model.dart';
import 'package:shopping/presentation/screens/categories/categories_screen.dart';
import 'package:shopping/presentation/screens/categories/sub_categories.dart';

class HomeContainer extends StatefulWidget {
  const HomeContainer({super.key});

  @override
  State<HomeContainer> createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  CategoriesModel? categoriesModel;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CategoriesCubit>(context).getCategoriesCubit();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        categoriesModel =
            BlocProvider.of<CategoriesCubit>(context).categoriesModel;

        if (state is CategoriesLoading) {
          return Center(
              child: SpinKitDualRing(
            color: brawn,
          ));
        } else if (state is CategoriesSuccess) {
          return Container(
            height: 300,
            width: mediawidth(context),
            child: Column(
              children: [
                CarouselSlider(
                    items: List.generate(
                        categoriesModel!.data!.categories!.length,
                        (index) => GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CategoriesScreen(),
                                  ),
                                );
                              },
                              child: Image.network(
                                  "https://buyandsell2024.com/${categoriesModel!.data!.categories![index].imgPath}",
                                  errorBuilder: (BuildContext context,
                                      Object error, StackTrace? stackTrace) {
                                // Error callback, display another image when the network image is not found
                                return Image.asset('images/car_two.jpeg');
                              }),
                            )),
                    options: CarouselOptions(
                      height: 100,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.3,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 1),
                      autoPlayAnimationDuration: Duration(milliseconds: 3000),
                      autoPlayCurve: Curves.linear,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.3,
                      // onPageChanged: callbackFunction,
                      scrollDirection: Axis.horizontal,
                    )),
                SizedBox(
                  height: 10,
                ),
                CarouselSlider(
                    items: List.generate(
                        categoriesModel!.data!.categories!.length,
                        (index) => Image.network(
                              "https://buyandsell2024.com/${categoriesModel!.data!.categories![index].imgPath}",
                              errorBuilder: (BuildContext context, Object error,
                                  StackTrace? stackTrace) {
                                // Error callback, display another image when the network image is not found
                                return Image.asset('images/real_house.jpeg');
                              },
                            )),
                    options: CarouselOptions(
                      height: 100,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.3,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 1),
                      autoPlayAnimationDuration: Duration(milliseconds: 3000),
                      autoPlayCurve: Curves.linear,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.3,
                      // onPageChanged: callbackFunction,
                      scrollDirection: Axis.horizontal,
                    )),
              ],
            ),
          );
        } else {
          return Center(
            child: Text("Something went wrong "),
          );
        }
      },
    );
  }
}
