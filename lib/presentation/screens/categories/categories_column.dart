import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/business_logic/Cubit/categories/categories_cubit.dart';
import 'package:shopping/core/utils/colors.dart';

import 'package:shopping/core/utils/strings.dart';
import 'package:shopping/data/models/categories_model.dart';
import 'package:shopping/data/services/apis.dart';
import 'package:shopping/presentation/screens/categories/sub_cate_adve.dart';

import 'package:shopping/presentation/screens/categories/sub_categories.dart';

class CategoriesColumn extends StatefulWidget {
  const CategoriesColumn({super.key});

  @override
  State<CategoriesColumn> createState() => _CategoriesColumnState();
}

class _CategoriesColumnState extends State<CategoriesColumn> {
  CategoriesModel? categoriesModel;
  ApiServices apiServices = ApiServices();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CategoriesCubit>(context).getCategoriesCubit();
  }

  @override
  Widget build(BuildContext context) {
    int itemsPerRow = 2;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state) {
          categoriesModel =
              BlocProvider.of<CategoriesCubit>(context).categoriesModel;
          if (state is CategoriesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CategoriesSuccess) {
            return SizedBox(
              height: 500,
              child: ListView.builder(
                  itemCount:
                      (categoriesModel!.data!.categories!.length / itemsPerRow)
                          .ceil(),
                  itemBuilder: (BuildContext context, int rowIndex) {
                    int startIndex = rowIndex * itemsPerRow;
                    int endIndex = (rowIndex + 1) * itemsPerRow;

                    if (endIndex > categoriesModel!.data!.categories!.length) {
                      endIndex = categoriesModel!.data!.categories!.length;
                    }

                    List<Categories> currentRowItems = categoriesModel!
                        .data!.categories!
                        .sublist(startIndex, endIndex);
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        for (int i = 0; i < currentRowItems.length; i++)
                          Column(
                            children: [
                              Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      SharedPreferences sharedPreferences =
                                          await SharedPreferences.getInstance();
                                      sharedPreferences.setString(
                                          "categories_id",
                                          currentRowItems[i].id.toString());

                                      if (currentRowItems[i]
                                              .haveSubCategories ==
                                          0) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    SubCategoryAdvertise(
                                                        sub_cate_id:
                                                            currentRowItems[i]
                                                                .id
                                                                .toString())));
                                      } else if (currentRowItems[i]
                                              .haveSubCategories ==
                                          1) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    SubCategorieScreen(id: currentRowItems[i].id.toString(),)));
                                      }
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(10),
                                      width: .42 * mediawidth(context),
                                      height: 140,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Image.network(
                                          "https://buyandsell2024.com/${currentRowItems[i].imgPath}",
                                          fit: BoxFit.cover, errorBuilder:
                                              (BuildContext context,
                                                  Object error,
                                                  StackTrace? stackTrace) {
                                        // Error callback, display another image when the network image is not found
                                        return Image.asset(
                                            'images/car_two.jpeg');
                                      }),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 10,
                                    left: 10,
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      width: 147,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: brawn),
                                        color: const Color(0xffFFFFFF),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: FittedBox(
                                          child: Text(
                                            currentRowItems[i].nameAr!,
                                            style: TextStyle(
                                              fontFamily: "",
                                              fontSize: 15,
                                              color: Color(0xff935C09),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                      ],
                    );
                  }),
            );
          } else {
            return Center(
              child: Text("something went wrong "),
            );
          }
        },
      ),
    );
  }
}
