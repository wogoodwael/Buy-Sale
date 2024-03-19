import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/business_logic/Cubit/cityCubit/cities_cubit.dart';
import 'package:shopping/business_logic/Cubit/government_cubit/government_cubit.dart';

import 'package:shopping/core/utils/colors.dart';
import 'package:shopping/core/utils/strings.dart';
import 'package:shopping/data/models/government_model.dart';
import 'package:shopping/main.dart';
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
              child: FittedBox(
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
    List<int> selectedValues = [];

    List<String> selectedGovernmentNames =
        []; // List to hold selected government names
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
              String selectedName =
                  governmentModel!.data![index].nameAr.toString();
              selectedGovernmentNames
                  .add(selectedName); // Add selected name to the list
              text = selectedName;
              widget.id = governmentModel!.data![index].id.toString();
              sharedPreferences.setString("government_choosen_id",
                  governmentModel!.data![index].id.toString());
              BlocProvider.of<CitiesCubit>(context).getCitiesCubit(
                  countryId: governmentModel!.data![index].id.toString());
            });
          },
          value: 1,
          child: StatefulBuilder(
            builder: (BuildContext context,
                void Function(void Function()) setState) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        governmentModel!.data![index].nameAr.toString(),
                        style: TextStyle(fontSize: 20),
                      ),
                      Checkbox(
                        fillColor: MaterialStateProperty.resolveWith((states) {
                          if (!states.contains(MaterialState.selected)) {
                            return Colors.white;
                          }
                          return null;
                        }),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2)),
                        side: BorderSide(
                          color: Colors.white,
                          width: 1,
                        ),
                        activeColor: Colors.green,
                        checkColor: Colors.white,
                        value: selectedValues
                            .contains(governmentModel!.data![index].id),
                        onChanged: (val) {
                          setState(() {
                            if (val!) {
                              selectedValues
                                  .add(governmentModel!.data![index].id!);
                              selectedGovernmentNames.add(governmentModel!
                                  .data![index].nameAr
                                  .toString());
                            } else {
                              selectedValues
                                  .remove(governmentModel!.data![index].id!);
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      )..addAll(
          // Add the "تم" button at the end
          [
            PopupMenuItem(
              child: Center(
                child: Container(
                  width: 50,
                  height: 30,
                  color: brawn,
                  child: Center(
                    child: Text(
                      "تم",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ),
              ),
              onTap: () {
                setState(() {
                  if (selectedValues.isNotEmpty) {
                    widget.id = selectedValues.first.toString();
                    text = selectedGovernmentNames.first;
                    saveSelectedGovernmentNames([
                      selectedGovernmentNames.first
                    ]); // Save only the first selected government name

                    sharedpref.setString("government_choosen_id", widget.id!);
                    text = selectedGovernmentNames.join(", ");
                  }
                });
                // Save selected values
                saveSelectedValues(selectedValues);
                // Close the menu
                BlocProvider.of<CitiesCubit>(context).getCitiesCubit(
                    countryId: sharedpref.getString("government_choosen_id")!);
                // Save selected values

                // Close the menu
              },
            )
          ],
        ),
    );
  }

  void saveSelectedValues(
    List<int> selectedValues,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // Save selected values
    sharedPreferences.setStringList(
        'selected_cities', selectedValues.map((id) => id.toString()).toList());
    sharedPreferences.setStringList('selected_cities_names',
        selectedValues.map((nameAr) => nameAr.toString()).toList());
    print(
        "%%%%%%%%%%%%%%%%%%% ${sharedPreferences.getStringList('selected_cities')}");
  }

  void saveSelectedGovernmentNames(
    List<String> selecteNames,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // Save selected values

    sharedPreferences.setStringList('selected_government_names',
        selecteNames.map((nameAr) => nameAr.toString()).toList());

    print(
        "!!!!!!!!!!!!!!!!!!!!!!! ${sharedPreferences.getStringList('selected_government_names')}");
  }
}
