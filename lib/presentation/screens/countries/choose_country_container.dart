import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/business_logic/Cubit/cityCubit/cities_cubit.dart';
import 'package:shopping/business_logic/Cubit/government_cubit/government_cubit.dart';

import 'package:shopping/core/utils/colors.dart';
import 'package:shopping/core/utils/strings.dart';
import 'package:shopping/data/models/government_model.dart';
import 'package:shopping/presentation/widgets/countries_row.dart';

class ChooseCountryContainer extends StatefulWidget {
  ChooseCountryContainer({super.key, required this.top, this.id, this.ontap});
  final double top;
  String? id;
  void Function()? ontap;

  @override
  State<ChooseCountryContainer> createState() => _ChooseCountryContainerState();
}

class _ChooseCountryContainerState extends State<ChooseCountryContainer> {
  String? text;
  GovernmentModel? governmentModel;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GovernmentCubit>(context).getGovernmentData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GovernmentCubit, GovernmentState>(
      builder: (context, state) {
        governmentModel =
            BlocProvider.of<GovernmentCubit>(context).governmentModel;
        if (state is GovernmentLoading) {
          return Center(
              child: SpinKitDualRing(
            color: brawn,
          ));
        } else if (state is GovernmentSuccess) {
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
                      style: TextStyle(color: brawn, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(
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
        governmentModel!.data!.length,
        (index) => PopupMenuItem(
            onTap: () async {
              SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              sharedPreferences.setString(
                  "government_id", governmentModel!.data![index].id.toString());
              print(sharedPreferences.getString("government_id"));
              setState(() {
                text = governmentModel!.data![index].nameAr.toString();
                widget.id = governmentModel!.data![index].id.toString();
                sharedPreferences.setString("government_choosen_id",
                    governmentModel!.data![index].id.toString());
                BlocProvider.of<CitiesCubit>(context).getCitiesCubit();
              });
            },
            value: 1,
            child: StatefulBuilder(
              builder: (BuildContext context,
                  void Function(void Function()) setState) {
                return CountiesRow(
                    country_name:
                        governmentModel!.data![index].nameAr.toString());
              },
            )),
      ),
    );
  }
}
