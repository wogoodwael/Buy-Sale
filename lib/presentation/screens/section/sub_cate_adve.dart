import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/business_logic/Cubit/advertisement/advertisment_cubit.dart';
import 'package:shopping/core/helper/fav_provider.dart';
import 'package:shopping/core/utils/colors.dart';
import 'package:shopping/data/models/advertisement_model.dart';
import 'package:shopping/data/services/apis.dart';
import 'package:shopping/presentation/screens/advertisements/advertisement_details.dart';

import 'package:shopping/presentation/widgets/search_container.dart';

class SubCategoryAdvertise extends StatefulWidget {
  const SubCategoryAdvertise({super.key});

  @override
  State<SubCategoryAdvertise> createState() => _SubCategoryAdvertiseState();
}

class _SubCategoryAdvertiseState extends State<SubCategoryAdvertise> {
  AdvertismentModel? advertismentModel;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AdvertismentCubit>(context).getAdvertismentCubit();
  }

  TextEditingController searchname = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // List img = [
    //   'images/chair.png',
    //   'images/char2.png',
    //   'images/char3.png',
    //   'images/char4.png',
    //   'images/char5.png'
    // ];
    bool? isAddedToFavorites;
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 10),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: grey, borderRadius: BorderRadius.circular(30)),
                child: Icon(
                  Icons.arrow_back,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SearchContainer(),
            SizedBox(
              height: 30,
            ),
            BlocBuilder<AdvertismentCubit, AdvertismentState>(
              builder: (context, state) {
                advertismentModel = BlocProvider.of<AdvertismentCubit>(context)
                    .advertismentModel;

                if (state is AdvertismentLoading) {
                  return Center(
                    child: SpinKitDualRing(
                      color: brawn,
                    ),
                  );
                } else if (state is AdvertismentSuccess) {
                 
                  return Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 500,
                        height: 500,
                        child: ListView.builder(
                            // shrinkWrap: true,
                            itemCount: advertismentModel!.data!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Stack(children: [
                                          GestureDetector(
                                            onTap: () async {
                                              SharedPreferences
                                                  sharedPreferences =
                                                  await SharedPreferences
                                                      .getInstance();
                                              sharedPreferences.setInt(
                                                  'id_adv',
                                                  advertismentModel!
                                                      .data![index].id!);
                                              int id = sharedPreferences
                                                  .getInt("id_adv")!;
                                              print(
                                                  "========================$id");
                                              String? des = advertismentModel!
                                                  .data![index].description;
                                              print(
                                                  "========================${des}");

                                              // ignore: use_build_context_synchronously
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          AdvertismentDetails(
                                                            advId:
                                                                id.toString(),
                                                            sellername:
                                                                advertismentModel!
                                                                    .data![
                                                                        index]
                                                                    .user!
                                                                    .firstName,
                                                            name:
                                                                advertismentModel!
                                                                    .data![
                                                                        index]
                                                                    .name
                                                                    .toString(),
                                                            subdescribtion:
                                                                des!,
                                                            attributes:
                                                                advertismentModel!
                                                                    .data![
                                                                        index]
                                                                    .attributes!,
                                                            location:
                                                                advertismentModel!
                                                                    .data![
                                                                        index]
                                                                    .address
                                                                    .toString(),
                                                            price:
                                                                advertismentModel!
                                                                    .data![
                                                                        index]
                                                                    .price
                                                                    .toString(),
                                                            sellerPhone:
                                                                advertismentModel!
                                                                    .data![
                                                                        index]
                                                                    .phone
                                                                    .toString(),
                                                            fullDescribition:
                                                                advertismentModel!
                                                                    .data![
                                                                        index]
                                                                    .description
                                                                    .toString(),
                                                            comments: advertismentModel
                                                                    ?.data?[
                                                                        index]
                                                                    .comments ??
                                                                [],
                                                            imgPath: advertismentModel
                                                                    ?.data?[
                                                                        index]
                                                                    .files?[0]
                                                                    .filePath ??
                                                                "assets/images/car.png",
                                                          )));
                                              setState(() {
                                                advertismentModel
                                                    ?.data?[index].comments;
                                              });
                                            },
                                            child: Container(
                                                width: 150,
                                                height: 100,
                                                child: Image.network(
                                                    "https://buyandsell2024.com/${advertismentModel!.data![index].imgPath}",
                                                    errorBuilder:
                                                        (BuildContext context,
                                                            Object error,
                                                            StackTrace?
                                                                stackTrace) {
                                                  // Error callback, display another image when the network image is not found
                                                  return Image.asset(
                                                      'images/chair.png');
                                                })),
                                          ),
                                          Positioned(
                                              top: 10,
                                              right: 10,
                                              child: Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      SharedPreferences
                                                          sharedPreferences =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      sharedPreferences.setInt(
                                                          'id_adv',
                                                          advertismentModel!
                                                              .data![index]
                                                              .id!);
                                                      int id = sharedPreferences
                                                          .getInt("id_adv")!;
                                                      await ApiServices()
                                                          .addToFav(context,
                                                              id: id);
                                                    
                                                    },
                                                    
                                                    child: Center(
                                                        child: Icon(
                                                      Icons.favorite,
                                                      color: Colors.red,
                                                      size: 20,
                                                    )),
                                                  )))
                                        ]),
                                        SizedBox(width: 20),
                                        Text(
                                            advertismentModel!.data![index].name
                                                .toString(),
                                            style: GoogleFonts.plusJakartaSans(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600)),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                ),
                              );
                            }),
                      )
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
