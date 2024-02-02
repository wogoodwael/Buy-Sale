import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/business_logic/Cubit/categories/categories_cubit.dart';

import 'package:shopping/core/utils/strings.dart';
import 'package:shopping/data/models/categories_model.dart';
import 'package:shopping/data/services/apis.dart';

import 'package:shopping/presentation/screens/section/sub_categories.dart';

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
                        for (var item in currentRowItems)
                          Column(
                            children: [
                              Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      SharedPreferences sharedPreferences =
                                          await SharedPreferences.getInstance();
                                      sharedPreferences.setString(
                                          "categories_id", item.id.toString());

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  SubCategorieScreen()));
                                    },
                                    child: Container(
                                      width: .42 * mediawidth(context),
                                      height: 145,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: const DecorationImage(
                                          image:
                                              AssetImage("images/product.png"),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 10,
                                    left: 10,
                                    child: Container(
                                      width: 147,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: const Color(0xffFFFFFF),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: FittedBox(
                                          child: Text(
                                            item.nameAr!,
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
