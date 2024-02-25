import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/business_logic/Cubit/my_advertise/my_advertisement_cubit.dart';
import 'package:shopping/core/helper/errors_snack.dart';
import 'package:shopping/core/utils/colors.dart';
import 'package:shopping/core/utils/strings.dart';
import 'package:shopping/data/models/advertisement_model.dart';
import 'package:shopping/data/models/my_advertise_model.dart';
import 'package:shopping/data/services/apis.dart';
import 'package:shopping/data/services/favorite_api.dart';
import 'package:shopping/presentation/screens/client/my_advertisement_details.dart';
import 'package:shopping/presentation/screens/home/home.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ApiServices apiServices = ApiServices();
  MyAdvertisementModel? myAdvertisementModel;
  String? img;
  @override
  void initState() {
  
    super.initState();
   
    BlocProvider.of<MyAdvertisementCubit>(context).getMyAdvertiseCubit();
    imgf();
    fetchFavorites(context: context);
  }

  void imgf() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    img = sharedPreferences.getString("img_path")!;
    setState(() {
      img;
    });
    print(img);
  }

  void getCommentId() async {
    myAdvertisementModel =
        BlocProvider.of<MyAdvertisementCubit>(context).myAdvertisementModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  SizedBox(width: .33 * mediawidth(context)),
                  Center(
                    child: Text("العودة إلى الرئيسية",
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 18, fontWeight: FontWeight.w700)),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => HomeScreen()));
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: grey, borderRadius: BorderRadius.circular(30)),
                      child: Icon(
                        Icons.arrow_forward,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Stack(children: [
                CircleAvatar(
                  radius: 38,
                  backgroundColor: darkbrawn,
                  child: CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    backgroundImage:
                        NetworkImage("https://buyandsell2024.com/$img"),

                    // Error callback, display another image when the network image is not found
                  ),
                ),
                Positioned(
                    right: 1,
                    bottom: 1,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, editProfile);
                      },
                      child: Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            color: darkbrawn,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 10,
                          ),
                        ),
                      ),
                    ))
              ]),
              SizedBox(
                height: 20,
              ),
              Text(
                "اعلاناتى",
                style: GoogleFonts.plusJakartaSans(
                    color: brawn, fontSize: 32, fontWeight: FontWeight.w600),
              ),
              BlocBuilder<MyAdvertisementCubit, MyAdvertisementState>(
                builder: (context, state) {
                  myAdvertisementModel =
                      BlocProvider.of<MyAdvertisementCubit>(context)
                          .myAdvertisementModel;
                  if (state is MyAdvertisementLoading) {
                    return Center(
                        child: SpinKitDualRing(
                      color: brawn,
                    ));
                  } else if (state is MyAdvertisementSuccess) {
                    return Container(
                      height: 250,
                      width: mediawidth(context),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: myAdvertisementModel!.data!.length > 1
                            ? myAdvertisementModel!.data!.length
                            : 1,
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            children: [
                              Column(children: [
                                Row(
                                  children: [
                                    Text(
                                      myAdvertisementModel!.data![index].name ??
                                          "".toString(),
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          apiServices.deleteAdv(
                                              context: context,
                                              id: myAdvertisementModel!
                                                  .data![index].id!);
                                          BlocProvider.of<MyAdvertisementCubit>(
                                                  context)
                                              .getMyAdvertiseCubit();
                                          CustomSnackBar(
                                              context,
                                              'لقد تم حذف الاعلان ',
                                              Colors.green);

                                          setState(() {
                                            myAdvertisementModel!.data!.length;
                                          });
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ))
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                MyAdvertisementDetails(
                                                  sellername:
                                                      myAdvertisementModel!
                                                          .data![index]
                                                          .user!
                                                          .firstName,
                                                  description:
                                                      myAdvertisementModel!
                                                          .data![index]
                                                          .description,
                                                  price: myAdvertisementModel!
                                                      .data![index].price,
                                                  id: myAdvertisementModel!
                                                      .data![index].id,
                                                  name: myAdvertisementModel!
                                                      .data![index].name,
                                                  files: myAdvertisementModel
                                                          ?.data?[index]
                                                          .files ??
                                                      [],
                                                  phone: myAdvertisementModel!
                                                      .data![index].phone,
                                                  address: myAdvertisementModel!
                                                      .data![index].address,
                                                  subdescribtion:
                                                      myAdvertisementModel!
                                                          .data![index]
                                                          .description!,
                                                  comments: myAdvertisementModel
                                                          ?.data?[index]
                                                          .mycomments ??
                                                      [],
                                                  videoUrl: myAdvertisementModel
                                                          ?.data?[index]
                                                          .files?[0]
                                                          .filePath ??
                                                      "",
                                                )));
                                  },
                                  child: Container(
                                    width: 150,
                                    height: 180,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(35),
                                    ),

                                    //files?[index].filePath
                                    child: myAdvertisementModel!
                                            .data![index].files!.isNotEmpty
                                        ? Image.network(
                                            "https://buyandsell2024.com/${myAdvertisementModel?.data?[index].files?[0].filePath}",
                                            errorBuilder: (BuildContext context,
                                                Object error,
                                                StackTrace? stackTrace) {
                                            // Error callback, display another image when the network image is not found
                                            return Image.asset(
                                                'images/cars.png');
                                          })
                                        : Image.asset('images/cars.png'),
                                  ),
                                ),
                              ]),
                            ],
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(
                      child: Text("something went wrong"),
                    );
                  }
                },
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "المفضلة",
                      style: GoogleFonts.plusJakartaSans(
                          color: brawn,
                          fontSize: 32,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              FutureBuilder<AdvertismentModel>(
                  future: fetchFavorites(context: context),
                  builder: (BuildContext context,
                      AsyncSnapshot<AdvertismentModel> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return Container(
                      height: 230,
                      width: mediawidth(context),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            children: [
                              Column(children: [
                                Row(
                                  children: [
                                    Text(
                                      snapshot.data!.data![index].name
                                          .toString(),
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    IconButton(
                                        onPressed: () async {
                                          addToFav(context,
                                              id: snapshot
                                                  .data!.data![index].id!);
                                          setState(() {
                                            snapshot.data!.data!.length;
                                          });
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ))
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (_) => FavoriteScreen(id: myAdvertisementModel!
                                    //                   .data![index].id!)));
                                  },
                                  child: Container(
                                    width: 150,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Image.network(
                                        "https://buyandsell2024.com/${snapshot.data!.data![index].imgPath}",
                                        errorBuilder: (BuildContext context,
                                            Object error,
                                            StackTrace? stackTrace) {
                                      // Error callback, display another image when the network image is not found
                                      return Image.asset('images/chair.png');
                                    }),
                                  ),
                                ),
                              ]),
                            ],
                          );
                        },
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
