import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/business_logic/Cubit/cityCubit/cities_cubit.dart';
import 'package:shopping/business_logic/Cubit/government_cubit/government_cubit.dart';

import 'package:shopping/core/utils/colors.dart';
import 'package:shopping/core/utils/strings.dart';
import 'package:shopping/data/models/city_model.dart';
import 'package:shopping/data/models/government_model.dart';

class CenterChooseContainer extends StatefulWidget {
  const CenterChooseContainer({super.key});

  @override
  State<CenterChooseContainer> createState() => _CenterChooseContainerState();
}

class _CenterChooseContainerState extends State<CenterChooseContainer> {
  GovernmentModel? governmentModel;
  CityModel? cityModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<GovernmentCubit>(context).getGovernmentData();
    BlocProvider.of<CitiesCubit>(context).getCitiesCubit();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 20),
        width: .75 * mediawidth(context),
        height: .15 * mediaHiegh(context),
        decoration:
            BoxDecoration(color: grey, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            BlocBuilder<GovernmentCubit, GovernmentState>(
              builder: (context, state) {
                governmentModel =
                    BlocProvider.of<GovernmentCubit>(context).governmentModel;
                if (state is GovernmentLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is GovernmentSuccess) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 100,
                        height: 40,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: governmentModel!.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.only(top: 10, right: 10),
                              width: 75,
                              height: 22,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: lightbrawn),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.clear,
                                    size: 13,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    governmentModel!.data![index].nameAr
                                        .toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: Text("Somtheing went wrong"),
                  );
                }
              },
            ),
            SizedBox(
              height: 10,
            ),
            BlocBuilder<CitiesCubit, CitiesState>(
              builder: (context, state) {
                cityModel = BlocProvider.of<CitiesCubit>(context).cityModel;
                if (state is CitiesLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is CitiesSuccess) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 100,
                        height: 40,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: cityModel!.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.only(top: 10, right: 10),
                              width: 75,
                              height: 22,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: lightbrawn),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.clear,
                                    size: 13,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    cityModel!.data![index].nameAr.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: Text("Something went wrong"),
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
