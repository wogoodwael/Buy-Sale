import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/business_logic/Cubit/cityCubit/cities_cubit.dart';
import 'package:shopping/core/utils/colors.dart';
import 'package:shopping/core/utils/strings.dart';
import 'package:shopping/data/models/city_model.dart';
import 'package:shopping/data/models/government_model.dart';
import 'package:shopping/main.dart';

class CenterChooseContainer extends StatefulWidget {
  CenterChooseContainer({
    Key? key,
    this.lenght,
  });
  int? lenght;

  @override
  State<CenterChooseContainer> createState() => _CenterChooseContainerState();
}

class _CenterChooseContainerState extends State<CenterChooseContainer> {
  GovernmentModel? governmentModel;
  CityModel? cityModel;
  List selectedCities = [];
  List<bool> isDeletedList = [];
  List names = sharedpref.getStringList('selected_cities_names') ?? [];

  @override
  void initState() {
    super.initState();
  }

  void updateNamesList() {
    setState(() {
      widget.lenght;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 20),
        width: .75 * MediaQuery.of(context).size.width,
        height: .15 * MediaQuery.of(context).size.height,
        decoration:
            BoxDecoration(color: grey, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            BlocBuilder<CitiesCubit, CitiesState>(
              builder: (context, state) {
                cityModel = BlocProvider.of<CitiesCubit>(context).cityModel;
                if (state is CitiesLoading) {
                  widget.lenght;
                  return Center(
                    child: SpinKitDualRing(
                      color: brawn, // assuming you meant brown color
                    ),
                  );
                } else if (state is CitiesSuccess) {
                  return Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 5.0,
                        crossAxisSpacing: 5.0,
                        childAspectRatio:
                            4.0, // You can adjust this ratio as needed
                      ),
                      itemCount: cityModel!.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (isDeletedList.length <= index) {
                          isDeletedList.add(false);
                        }
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (selectedCities
                                  .contains(cityModel!.data![index])) {
                                selectedCities.remove(cityModel!.data![index]);
                              } else {
                                selectedCities.add(cityModel!.data![index]);
                              }
                              updateNamesList(); // Update names list
                            });
                          },
                          child: isDeletedList[index]
                              ? Container()
                              : Container(
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: selectedCities
                                            .contains(cityModel!.data![index])
                                        ? lightbrawn // Change to your selected color
                                        : lightGrey, // Change to your unselected color
                                  ),
                                  child: FittedBox(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isDeletedList[index] = true;
                                            });
                                          },
                                          child: Icon(
                                            Icons.close,
                                            size: 20,
                                            color: Colors.red,
                                          ),
                                        ),
                                        isDeletedList[index]
                                            ? Container()
                                            : Center(
                                                child: Text(
                                                  cityModel!.data![index].nameAr
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: selectedCities
                                                            .contains(cityModel!
                                                                .data![index])
                                                        ? Colors
                                                            .white // Change to your selected text color
                                                        : Colors
                                                            .black, // Change to your unselected text color
                                                  ),
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                        );
                      },
                    ),
                  );
                } else {
                  return Center(
                    child: Text("يجب اختيار المحافظة أولا"),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
