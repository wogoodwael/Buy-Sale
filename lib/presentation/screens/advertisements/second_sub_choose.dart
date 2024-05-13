import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/business_logic/Cubit/attrs_categories/attrs_categories_cubit.dart';
import 'package:shopping/business_logic/Cubit/second_sub/second_sub_cubit.dart';
import 'package:shopping/business_logic/Cubit/sub_cate_create_adv/sub_cate_create_adv_cubit.dart';
import 'package:shopping/business_logic/Cubit/third_sub/third_sub_cubit.dart';
import 'package:shopping/core/utils/colors.dart';
import 'package:shopping/core/utils/strings.dart';
import 'package:shopping/data/models/categories_attrs_model.dart';
import 'package:shopping/data/models/sub_cate.dart';
import 'package:shopping/data/models/sub_categories_adv_model.dart';
import 'package:shopping/data/services/apis.dart';
import 'package:shopping/presentation/widgets/countries_row.dart';

// ignore: must_be_immutable
class SecondSubCategContainer extends StatefulWidget {
  SecondSubCategContainer({Key? key, required this.top, this.ontap})
      : super(key: key);
  final double top;
  final void Function()? ontap;

  @override
  State<SecondSubCategContainer> createState() =>
      _SecondSubCategContainerState();
}

class _SecondSubCategContainerState extends State<SecondSubCategContainer> {
  SubCategoriesModel? subCategoriesModel;
  GetCateAttrsModel? getCateAttrsModel;
  ApiServices apiServices = ApiServices();
  // int? lenght;
  void updateLength() async {
    setState(() {
      // lenght = BlocProvider.of<SecondSubCubit>(context).lenght;
    });
  }

  // void updateAttributesList() async {
  //   setState(() {
  //     getCateAttrsModel =
  //         BlocProvider.of<AttrsCategoriesCubit>(context).getCateAttrsModel;
  //     ;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // BlocProvider.of<SubCateCreateAdvCubit>(context).subCateCreateAdvCubit();
    // BlocProvider.of<AttrsCategoriesCubit>(context).getCategoriesAttrsCubit();
    // BlocProvider.of<AttrsCategoriesCubit>(context).getCategoriesAttrsCubit();
    // getCateAttrsModel =
    //     BlocProvider.of<AttrsCategoriesCubit>(context).getCateAttrsModel;
  }

  String? text;
  String? id;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SecondSubCubit, SecondSubState>(
      builder: (context, state) {
        subCategoriesModel =
            BlocProvider.of<SecondSubCubit>(context).subCategoriesModel;
        // lenght = BlocProvider.of<SecondSubCubit>(context).lenght;

        // print("second sub lenght $lenght");

        if (state is SecondSubLoading) {
          return Center(
            child: SpinKitDualRing(
              color: brawn,
            ),
          );
        } else if (state is SecondSubSuccess) {
          return Center(
            child: StatefulBuilder(
              builder: (BuildContext context, setState) {
                return Container(
                  width: .8 * mediawidth(context),
                  height: 40,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onHorizontalDragCancel: widget.ontap,
                        onTap: () async {
                          // print("liiiiiiiiii$lenght");
                          await showMenu(
                            context: context,
                            color: grey,
                            constraints: const BoxConstraints(
                              minWidth: 230,
                              minHeight: 300,
                            ),
                            shape: const RoundedRectangleBorder(
                                side: BorderSide(color: Colors.black)),
                            position:
                                RelativeRect.fromLTRB(70, widget.top, 40, 1),
                            items: List.generate(
                              subCategoriesModel?.data?.categories?.length ?? 1,
                              (index) => PopupMenuItem(
                                  onTap: () async {
                                    SharedPreferences sharedPreferences =
                                        await SharedPreferences.getInstance();
                                    setState(() {
                                      // lenght;
                                      text = subCategoriesModel!
                                          .data!.categories![index].nameAr
                                          .toString();
                                      id = subCategoriesModel!
                                              .data!.categories!.isEmpty
                                          ? subCategoriesModel!.data!.parent!.id
                                              .toString()
                                          : subCategoriesModel!
                                              .data!.categories![index].id
                                              .toString();
                                      print("############$id");

                                      sharedPreferences.setString(
                                          "second_sub_id",
                                          subCategoriesModel!
                                              .data!.categories![index].id
                                              .toString());
                                      BlocProvider.of<ThirdSubCubit>(context)
                                          .thirdSubCubit(id: id!);
                                      BlocProvider.of<AttrsCategoriesCubit>(
                                              context)
                                          .getCategoriesAttrsCubit(id: id!);

                                      //*set string length
                                    });
                                  },
                                  value: 1,
                                  child: StatefulBuilder(
                                    builder: (BuildContext context,
                                        void Function(void Function())
                                            setState) {
                                      setState(
                                        () {
                                          // lenght;
                                        },
                                      );
                                      return CountiesRow(
                                        country_name: subCategoriesModel!
                                            .data!.categories![index].nameAr
                                            .toString(),
                                      );
                                    },
                                  )),
                            ),
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
                          style: TextStyle(color: brawn, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        } else {
          return Center(
            child: Text(
              "لا يوجد قسم فرعي لهذا القسم ",
              style: TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold, fontSize: 17),
            ),
          );
        }
      },
    );
  }
}
