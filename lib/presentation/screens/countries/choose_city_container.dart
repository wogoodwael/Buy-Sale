import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/business_logic/Cubit/cityCubit/cities_cubit.dart';
import 'package:shopping/core/utils/colors.dart';
import 'package:shopping/core/utils/strings.dart';
import 'package:shopping/data/models/city_model.dart';
import 'package:shopping/main.dart';

class ChooseCityContainer extends StatefulWidget {
  const ChooseCityContainer({super.key, required this.top});
  final double top;

  @override
  State<ChooseCityContainer> createState() => _ChooseCityContainerState();
}

class _ChooseCityContainerState extends State<ChooseCityContainer> {
  CityModel? cityModel;
  @override
  void initState() {
    super.initState();
  }

  String? text;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CitiesCubit, CitiesState>(
      builder: (context, state) {
        cityModel = BlocProvider.of<CitiesCubit>(context).cityModel;
        if (state is CitiesLoading) {
          return Center(
              child: SpinKitDualRing(
            color: brawn,
          ));
        } else if (state is CitiesSuccess) {
          return Center(
            child: Container(
              width: .8 * mediawidth(context),
              height: 40,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
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
                        style: TextStyle(color: brawn, fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Center(
            child: Text("يرجي اختيار المحافظه اولا  "),
          );
        }
      },
    );
  }

  void branshMenu(BuildContext context, double top) {
    BlocProvider.of<CitiesCubit>(context).getCitiesCubit();
    // Track selected values
    List<int> selectedValues = [];
    List<String> selectedNames = [];
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
        cityModel!.data!.length + 1, // Add 1 for the "Done" button
        (index) {
          if (index == cityModel!.data!.length) {
            // Last item, add the "Done" button
            return PopupMenuItem(
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
                  text = selectedNames.join(", ");
                });
                // Save selected values
                saveSelectedValues(selectedValues);
                saveNamedValues(selectedNames);

                // Close the menu
              },
            );
          } else {
            // Regular city item
            return PopupMenuItem(
              onTap: () async {
                setState(() {
                  // Toggle selection
                  if (selectedValues.contains(cityModel!.data![index].id!)) {
                    selectedValues.remove(cityModel!.data![index].id!);
                  } else {
                    selectedValues.add(cityModel!.data![index].id!);
                    selectedNames
                        .add(cityModel!.data![index].nameAr.toString());
                  }
                  text = selectedNames.join(", ");
                  print(selectedValues);
                });
                SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                sharedPreferences.setString(
                    'city_id', cityModel!.data![index].id.toString());
                sharedPreferences.setInt(
                    'id_of_city', cityModel!.data![index].id!);
              },
              value: selectedValues.contains(cityModel!.data![index].id!)
                  ? cityModel!.data![index].id
                  : null,
              child: StatefulBuilder(
                builder: (BuildContext context,
                    void Function(void Function()) setState) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            cityModel!.data![index].nameAr.toString(),
                            style: TextStyle(fontSize: 20),
                          ),
                          Checkbox(
                            fillColor:
                                MaterialStateProperty.resolveWith((states) {
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
                                .contains(cityModel!.data![index].id),
                            onChanged: (val) {
                              setState(() {
                                if (val!) {
                                  selectedValues
                                      .add(cityModel!.data![index].id!);
                                  selectedNames.add(cityModel!
                                      .data![index].nameAr
                                      .toString());
                                } else {
                                  selectedValues
                                      .remove(cityModel!.data![index].id!);
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
            );
          }
        },
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

  void saveNamedValues(
    List<String> selecteNames,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // Save selected values

    sharedPreferences.setStringList('selected_cities_names',
        selecteNames.map((nameAr) => nameAr.toString()).toList());

    print(
        "!!!!!!!!!!!!!!!!!!!!!!! ${sharedPreferences.getStringList('selected_cities_names')}");
  }
}
