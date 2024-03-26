import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:shopping/business_logic/Cubit/attrs_categories/attrs_categories_cubit.dart';
import 'package:shopping/core/utils/colors.dart';
import 'package:shopping/core/utils/strings.dart';
import 'package:shopping/data/models/categories_attrs_model.dart';

// ignore: must_be_immutable
class ChooseAttributeContainer extends StatefulWidget {
  ChooseAttributeContainer(
      {super.key, required this.top, this.ontap, this.type, this.text});
  final double top;
  Function()? ontap;
  String? type;
  String? text;
  @override
  State<ChooseAttributeContainer> createState() =>
      _ChooseAttributeContainerState();
}

class _ChooseAttributeContainerState extends State<ChooseAttributeContainer> {
  GetCateAttrsModel? getCateAttrsModel;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttrsCategoriesCubit, AttrsCategoriesState>(
      builder: (context, state) {
        getCateAttrsModel =
            BlocProvider.of<AttrsCategoriesCubit>(context).getCateAttrsModel;
        if (state is AttrsCategoriesLoading) {
          return Center(
            child: SpinKitDualRing(
              color: brawn,
            ),
          );
        } else if (state is AttrsCategoriesSuccess) {
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
                    // onHorizontalDragCancel: ,
                    onTap: widget.ontap,

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
                      widget.text ?? "",
                      style: TextStyle(color: brawn, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Center(
            child: FittedBox(
              child: Text(
                "لا يوجد بيانات اختياريه لهذا المنتج\n من فضلك ادخل البيانات يدويا",
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
          );
        }
      },
    );
  }
}
