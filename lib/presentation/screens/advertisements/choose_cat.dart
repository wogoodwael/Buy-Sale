import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/business_logic/Cubit/attrs_categories/attrs_categories_cubit.dart';
import 'package:shopping/business_logic/Cubit/categories/categories_cubit.dart';
import 'package:shopping/business_logic/Cubit/sub_cate_create_adv/sub_cate_create_adv_cubit.dart';
import 'package:shopping/core/utils/colors.dart';
import 'package:shopping/core/utils/strings.dart';
import 'package:shopping/data/models/categories_attrs_model.dart';
import 'package:shopping/data/models/categories_model.dart';
import 'package:shopping/presentation/widgets/countries_row.dart';

// ignore: must_be_immutable
class ChooseCategoriesContainer extends StatefulWidget {
  ChooseCategoriesContainer(
      {super.key, required this.top, this.id, this.ontap});
  final double top;
  String? id;
  void Function()? ontap;

  @override
  State<ChooseCategoriesContainer> createState() =>
      _ChooseCategoriesContainerState();
}

class _ChooseCategoriesContainerState extends State<ChooseCategoriesContainer> {
  String? text;
  CategoriesModel? categoriesModel;
  GetCateAttrsModel? getCateAttrsModel;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CategoriesCubit>(context).getCategoriesCubit();
    // BlocProvider.of<AttrsCategoriesCubit>(context).getCategoriesAttrsCubit();
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
            ),
          );
        } else if (state is CategoriesSuccess) {
          return Center(
            child: Container(
              width: .8 * mediawidth(context),
              height: 40,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onHorizontalDragCancel: widget.ontap,
                    // onTapCancel: widget.ontap,
                    onTap: () {
                      branshMenu(
                        context,
                        widget.top,
                      );
                    },
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: brawn,
                      weight: 20,
                      size: 30,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      text ?? "",
                      style: TextStyle(color: brawn, fontSize: 15),
                    ),
                  ),
                ],
              ),
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

  void branshMenu(
    BuildContext context,
    double top,
  ) {
    String? postId;
    showMenu(
      context: context,
      color: grey,
      constraints: const BoxConstraints(
        minWidth: 230,
        minHeight: 300,
      ),
      shape:
          const RoundedRectangleBorder(side: BorderSide(color: Colors.black)),
      position: RelativeRect.fromLTRB(70, top, 40, 1),
      items: List.generate(
        categoriesModel!.data!.categories!.length,
        (index) => PopupMenuItem(
            onTap: () async {
              SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              setState(() {
                text =
                    categoriesModel!.data!.categories![index].nameAr.toString();
                widget.id =
                    categoriesModel!.data!.categories![index].id.toString();
                if (categoriesModel!
                        .data!.categories![index].haveSubCategories ==
                    0) {
                  sharedPreferences.setString("postId",
                      categoriesModel!.data!.categories![index].id.toString());
                  postId = sharedPreferences.getString("postId");
                }
                print("postIddddddd$postId");
                sharedPreferences.setString("adv_category_id",
                    categoriesModel!.data!.categories![index].id.toString());
                sharedPreferences.setString("category_choosen_name", text!);
                text = sharedPreferences.getString("category_choosen_name");
                BlocProvider.of<SubCateCreateAdvCubit>(context)
                    .subCateCreateAdvCubit(
                        id: categoriesModel!.data!.categories![index].id
                            .toString());
                            
                BlocProvider.of<AttrsCategoriesCubit>(context)
                    .getCategoriesAttrsCubit(id: widget.id!);

                print("idinadv${widget.id}");
              });
            },
            value: 1,
            child: StatefulBuilder(
              builder: (BuildContext context,
                  void Function(void Function()) setState) {
                setState(
                  () {
                    text;
                  },
                );
                return CountiesRow(
                    country_name: categoriesModel!
                        .data!.categories![index].nameAr
                        .toString());
              },
            )),
      ),
    );
  }
}
