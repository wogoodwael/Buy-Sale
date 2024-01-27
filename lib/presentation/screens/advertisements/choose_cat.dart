import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/business_logic/Cubit/categories_cubit/categories_cubit.dart';
import 'package:shopping/core/utils/colors.dart';
import 'package:shopping/core/utils/strings.dart';
import 'package:shopping/data/models/categories_model.dart';
import 'package:shopping/presentation/widgets/countries_row.dart';

class ChooseCategoriesContainer extends StatefulWidget {
  const ChooseCategoriesContainer({super.key, required this.top});
  final double top;

  @override
  State<ChooseCategoriesContainer> createState() =>
      _ChooseCategoriesContainerState();
}

class _ChooseCategoriesContainerState extends State<ChooseCategoriesContainer> {
  String? text;
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
          return const Center(
            child: CircularProgressIndicator(),
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
                    onTap: () {
                      branshMenu(context, widget.top);
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

  void branshMenu(BuildContext context, double top) {
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
            onTap: () {
              setState(() {
                text =
                    categoriesModel!.data!.categories![index].nameAr.toString();
              });
            },
            value: 1,
            child: StatefulBuilder(
              builder: (BuildContext context,
                  void Function(void Function()) setState) {
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
