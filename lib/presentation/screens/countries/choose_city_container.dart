import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/business_logic/Cubit/cityCubit/cities_cubit.dart';
import 'package:shopping/core/utils/colors.dart';
import 'package:shopping/core/utils/strings.dart';
import 'package:shopping/data/models/city_model.dart';
import 'package:shopping/presentation/widgets/countries_row.dart';

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
        cityModel!.data!.length,
        (index) => PopupMenuItem(
            onTap: () async {
              setState(() {
                text = cityModel!.data![index].nameAr.toString();
              });
              SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              sharedPreferences.setString(
                  'city_id', cityModel!.data![index].id.toString());
              sharedPreferences.setInt(
                  'id_of_city', cityModel!.data![index].id!);
            },
            value: 1,
            child: StatefulBuilder(
              builder: (BuildContext context,
                  void Function(void Function()) setState) {
                return CountiesRow(
                    country_name: cityModel!.data![index].nameAr.toString());
              },
            )),
      ),
    );
  }
}
