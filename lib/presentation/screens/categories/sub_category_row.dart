import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/business_logic/Cubit/subCategories/sub_categories_cubit.dart';
import 'package:shopping/core/utils/colors.dart';
import 'package:shopping/data/models/sub_cate.dart';
import 'package:shopping/data/services/apis.dart';
import 'package:shopping/presentation/screens/categories/sub_cate_adve.dart';

class SubCategoryRow extends StatefulWidget {
  const SubCategoryRow({super.key});

  @override
  State<SubCategoryRow> createState() => _SubCategoryRowState();
}

class _SubCategoryRowState extends State<SubCategoryRow> {
  SubCategoriesModel? subCategoriesModel;
  ApiServices apiServices = ApiServices();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SubCategoriesCubit>(context).getSubCategoriesCubit();
  }

  @override
  Widget build(BuildContext context) {
    int itemsPerRow = 2;
    return BlocBuilder<SubCategoriesCubit, SubCategoriesState>(
      builder: (context, state) {
        subCategoriesModel =
            BlocProvider.of<SubCategoriesCubit>(context).subCategoriesModel;
        if (state is SubCategoriesLoading) {
          return Center(
              child: SpinKitDualRing(
            color: brawn,
          ));
        } else if (state is SubCategoriesSuccess) {
          return SizedBox(
              height: 500,
              child: ListView.builder(
                  itemCount: (subCategoriesModel!.data!.categories!.length /
                          itemsPerRow)
                      .ceil(),
                  itemBuilder: (BuildContext context, int rowIndex) {
                    int startIndex = rowIndex * itemsPerRow;
                    int endIndex = (rowIndex + 1) * itemsPerRow;

                    if (endIndex >
                        subCategoriesModel!.data!.categories!.length) {
                      endIndex = subCategoriesModel!.data!.categories!.length;
                    }

                    List<SubCategories> currentRowItems = subCategoriesModel!
                        .data!.categories!
                        .sublist(startIndex, endIndex);
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        for (var item in currentRowItems)
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString(
                                      'sub_category_id', item.id.toString());

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => SubCategoryAdvertise(
                                                sub_cate_id: item.id.toString(),
                                              )));
                                },
                                child: Container(
                                  width: 156,
                                  height: 200,
                                  child: Image.network(
                                      "https://buyandsell2024.com/${item.imgPath}",
                                      errorBuilder: (BuildContext context,
                                          Object error,
                                          StackTrace? stackTrace) {
                                    // Error callback, display another image when the network image is not found
                                    return Image.asset('images/car_two.jpeg');
                                  }),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 70),
                                child: Text(
                                  item.nameAr.toString(),
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "PlusJakartaSans",
                                    color: Colors.grey,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Container(
                                width: 120,
                                child: Text(
                                  item.parent!.nameAr.toString(),
                                  softWrap: true,
                                  style: TextStyle(
                                    fontFamily: "PlusJakartaSans-Bold",
                                    fontSize: 14,
                                    color: Color(0xff111111),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              )
                            ],
                          ),
                      ],
                    );
                  }));
        } else {
          return Center(
            child: Text("Something went wrong"),
          );
        }
      },
    );
  }
}
