import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shopping/business_logic/Cubit/attrs_categories/attrs_categories_cubit.dart';
import 'package:shopping/core/utils/colors.dart';
import 'package:shopping/core/utils/strings.dart';
import 'package:shopping/data/models/categories_attrs_model.dart';

// ignore: must_be_immutable
class SelectAttribute extends StatefulWidget {
  SelectAttribute(
      {super.key, this.top, required this.ontap, required this.text, required this.textofRow});
  final String textofRow;
  double? top;
  Function()? ontap;
  String? text;
  @override
  State<SelectAttribute> createState() => _SelectAttributeState();
}

class _SelectAttributeState extends State<SelectAttribute> {
  GetCateAttrsModel? getCateAttrsModel;

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
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                   Padding(
                      padding: EdgeInsets.only(right: 30, top: 10, bottom: 5),
                      child: Text(
                       widget. textofRow,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )),
                ],
              ),
              Center(
                child: Container(
                  width: .8 * mediawidth(context),
                  height: 40,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
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
              ),
            ],
          );
        } else {
          return Center(
            child: Text("something went wrong"),
          );
        }
      },
    );
  }
}
