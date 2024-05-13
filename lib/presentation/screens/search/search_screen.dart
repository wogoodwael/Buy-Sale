import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/core/utils/strings.dart';

import 'package:shopping/data/models/filter_model.dart';
import 'package:shopping/data/services/apis.dart';
import 'package:shopping/presentation/screens/categories/sub_categories.dart';

class SearchScreen extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios));
  }

  ApiServices apiServices = ApiServices();
  @override
  Widget buildResults(BuildContext context) {
    int itemsPerRow = 2;
    return FutureBuilder(
        future: apiServices.getCategoryFilter(name: query),
        builder: (BuildContext context, AsyncSnapshot<FilterModel> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('تاكد من كتابه الاسم بشكل صحيح'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return SizedBox(
            height: 500,
            child: ListView.builder(
                itemCount:
                    (snapshot.data!.data!.categories!.length / itemsPerRow)
                        .ceil(),
                itemBuilder: (BuildContext context, int rowIndex) {
                  int startIndex = rowIndex * itemsPerRow;
                  int endIndex = (rowIndex + 1) * itemsPerRow;

                  if (endIndex > snapshot.data!.data!.categories!.length) {
                    endIndex = snapshot.data!.data!.categories!.length;
                  }

                  List<CategoriesFilter> currentRowItems = snapshot
                      .data!.data!.categories!
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
                                            builder: (_) => SubCategorieScreen(
                                                  id: item.id.toString(),
                                                )));
                                  },
                                  child: Container(
                                    width: .42 * mediawidth(context),
                                    height: 145,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: const DecorationImage(
                                        image: AssetImage("images/product.png"),
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
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text(
        "ابحث هنا عما تريد",
        style: TextStyle(
          color: Colors.grey,
          fontSize: 14,
        ),
      ),
    );
  }
}
