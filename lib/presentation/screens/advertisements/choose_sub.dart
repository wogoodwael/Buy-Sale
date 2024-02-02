import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/business_logic/Cubit/attrs_categories/attrs_categories_cubit.dart';

import 'package:shopping/business_logic/Cubit/sub_cate_create_adv/sub_cate_create_adv_cubit.dart';
import 'package:shopping/core/utils/colors.dart';
import 'package:shopping/core/utils/strings.dart';
import 'package:shopping/data/models/sub_cate.dart';
import 'package:shopping/data/services/apis.dart';
import 'package:shopping/presentation/screens/advertisements/advertise.dart';
import 'package:shopping/presentation/widgets/countries_row.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart' as admin;

class ChooseSubCategContainer extends StatefulWidget {
  ChooseSubCategContainer({super.key, required this.top, this.ontap});
  final double top;
  void Function()? ontap;

  @override
  State<ChooseSubCategContainer> createState() =>
      _ChooseSubCategContainerState();
}

class _ChooseSubCategContainerState extends State<ChooseSubCategContainer> {
  SubCategoriesModel? subCategoriesModel;
  ApiServices apiServices = ApiServices();
  int? lenght;
  void updateLength() async {
    setState(() {
      lenght = BlocProvider.of<SubCateCreateAdvCubit>(context).lenght;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  String? text;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubCateCreateAdvCubit, SubCateCreateAdvState>(
      builder: (context, state) {
        subCategoriesModel =
            BlocProvider.of<SubCateCreateAdvCubit>(context).subCategoriesModel;
        lenght = BlocProvider.of<SubCateCreateAdvCubit>(context).lenght;

        print(lenght);

        if (state is SubCateCreateAdvLoading) {
          return Center(
            child: SpinKitDualRing(
              color: brawn,
            ),
          );
        } else if (state is SubCateCreateAdvSuccess) {
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
                          print("liiiiiiiiii$lenght");
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
                              lenght ?? 1,
                              (index) => PopupMenuItem(
                                  onTap: () async {
                                    SharedPreferences sharedPreferences =
                                        await SharedPreferences.getInstance();
                                    setState(() {
                                      lenght;
                                      text = subCategoriesModel!
                                          .data!.categories![index].nameAr
                                          .toString();
                                      sharedPreferences.setString(
                                          "sub_id",
                                          subCategoriesModel!
                                              .data!.categories![index].id
                                              .toString());
                                      BlocProvider.of<AttrsCategoriesCubit>(
                                              context)
                                          .getCategoriesAttrsCubit();

                                      //*set string lenght
                                    });
                                  },
                                  value: 1,
                                  child: StatefulBuilder(
                                    builder: (BuildContext context,
                                        void Function(void Function())
                                            setState) {
                                      setState(
                                        () {
                                          lenght;
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
            child: Text("Something went wrong "),
          );
        }
      },
    );
  }

  // void branshMenu(
  //     BuildContext context, double top, SubCateCreateAdvCubit cubit) {
  //   BlocBuilder<SubCateCreateAdvCubit, SubCateCreateAdvState>(
  //     builder: (context, state) {
  //       return StatefulBuilder(
  //         builder: (BuildContext context, setState) {
  //           return showMenu(
  //             context: context,
  //             color: grey,
  //             constraints: const BoxConstraints(
  //               minWidth: 230,
  //               minHeight: 300,
  //             ),
  //             shape: const RoundedRectangleBorder(
  //                 side: BorderSide(color: Colors.black)),
  //             position: RelativeRect.fromLTRB(70, top, 40, 1),
  //             items: List.generate(
  //               cubit.lenght ?? 1,
  //               (index) => PopupMenuItem(
  //                   onTap: () {
  //                     setState(() {
  //                       text = subCategoriesModel!
  //                           .data!.categories![index].nameAr
  //                           .toString();
  //                       cubit.lenght;

  //                       //*set string lenght
  //                     });
  //                   },
  //                   value: 1,
  //                   child: StatefulBuilder(
  //                     builder: (BuildContext context,
  //                         void Function(void Function()) setState) {
  //                       setState(
  //                         () {
  //                           cubit.lenght;
  //                         },
  //                       );
  //                       return CountiesRow(
  //                         country_name: subCategoriesModel!
  //                             .data!.categories![index].nameAr
  //                             .toString(),
  //                       );
  //                     },
  //                   )),
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }
}
