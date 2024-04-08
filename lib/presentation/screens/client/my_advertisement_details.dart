import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:shopping/core/utils/colors.dart';
import 'package:shopping/core/utils/strings.dart';

import 'package:shopping/data/models/my_advertise_model.dart';
import 'package:shopping/data/services/apis.dart';
import 'package:shopping/data/services/comments_api.dart';
import 'package:shopping/data/services/favorite_api.dart';
import 'package:shopping/main.dart';
import 'package:shopping/presentation/screens/advertisements/video.dart';
import 'package:shopping/presentation/screens/client/profile.dart';
import 'package:video_player/video_player.dart';

enum Source { Asset, NetWork }

// ignore: must_be_immutable
class MyAdvertisementDetails extends StatefulWidget {
  MyAdvertisementDetails(
      {super.key,
      this.id,
      this.comments,
      this.subdescribtion,
      this.price,
      this.description,
      required this.attributes,
      this.name,
      this.files,
      this.phone,
      this.sellername,
      this.commentername,
      this.address,
      required this.videoUrl});
  int? id;
  int? categoryId;
  int? userId;
  String? sellername;
  String? commentername;
  String? name;
  String? subdescribtion;
  String? description;
  int? cityId;
  int? price;
  List<Files>? files;
  List<MyAttributes>? attributes;
  String? createdAt;
  String? updatedAt;
  String? phone;
  String? address;
  List<MyComments>? comments;
  final String videoUrl;
  @override
  State<MyAdvertisementDetails> createState() => _MyAdvertisementDetailsState();
}

class _MyAdvertisementDetailsState extends State<MyAdvertisementDetails> {
  bool isAdmine = false;
  ApiServices apiServices = ApiServices();
  TextEditingController content = TextEditingController();
  String? img;

  void imgf() async {
    img = sharedpref.getString("img_path")!;
    setState(() {
      img;
    });
    print(img);
  }

  String? userName;
  getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('user_name')!;
    setState(() {
      userName = username;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserName();
    imgf();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 16),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          addToFav(context, id: widget.id!);
                        },
                        child: const Icon(Icons.favorite_border)),
                    Center(
                        child: Text(
                      "التفاصيل",
                      style: TextStyle(
                        fontFamily: "PlusJakartaSans-Bold",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff1111111),
                      ),
                    )),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => ProfileScreen()));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: grey,
                            borderRadius: BorderRadius.circular(30)),
                        child: Icon(
                          Icons.arrow_forward,
                          size: 20,
                        ),
                      ),
                    ),
                  ]),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only(bottom: 10),
                        width: double.infinity,
                        height: 200,
                        color: Colors.white,
                        child: widget.files!.isEmpty
                            ? Center(child: Text("لم تضف اي صور لاعلانك "))
                            : widget.files?[0].type == 'video'
                                ? VideoPlayerScreen(
                                    url:
                                        "https://buyandsell2024.com/${widget.files?[0].filePath}")
                                : CarouselSlider(
                                    items: List.generate(
                                        widget.files?.length ?? 1, (index) {
                                      return Image.network(
                                          "https://buyandsell2024.com/${widget.files?[index].filePath}",
                                          errorBuilder: (BuildContext context,
                                              Object error,
                                              StackTrace? stackTrace) {
                                        // Error callback, display another image when the network image is not found
                                        return Image.asset(
                                            'images/car_two.jpeg');
                                      });
                                    }),
                                    options: CarouselOptions(
                                      height: 200,
                                      aspectRatio: 16 / 9,
                                      viewportFraction: 0.5,
                                      initialPage: 0,
                                      enableInfiniteScroll: false,
                                      reverse: false,
                                      autoPlay: false,
                                      autoPlayInterval: Duration(seconds: 1),
                                      autoPlayAnimationDuration:
                                          Duration(milliseconds: 3000),
                                      autoPlayCurve: Curves.linear,
                                      enlargeCenterPage: true,
                                      enlargeFactor: 0.3,
                                      // onPageChanged: callbackFunction,
                                      scrollDirection: Axis.horizontal,
                                    ))),

                    Padding(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 20),
                      child: Row(
                        children: [
                          Icon(Icons.star, color: Colors.orange),
                          Text(
                            "4.4  ",
                            style: TextStyle(
                                fontFamily: "",
                                fontSize: 15,
                                color: Colors.orange),
                            textAlign: TextAlign.end,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 80),
                            child: Text(
                              "(52)",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                          Spacer(),
                          Text(
                            widget.name ?? "no name",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontFamily: "",
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 30),
                          child: Text(
                            widget.subdescribtion ?? "no subdescribtion",
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Row(
                      children: [
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.only(right: 60),
                          child: Row(
                            children: [
                              Text("${widget.price ?? "no price"}"),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                ": السعر ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          widget.address ?? "no location",
                          style: TextStyle(
                            fontFamily: "",
                            fontSize: 14,
                            color: Color(0xff9CA4AB),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.location_on,
                            size: 25,
                            color: Color(0xff9CA4AB),
                          ),
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: List.generate(
                            widget.attributes?.length ?? 2,
                            (index) => FittedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      widget.attributes?[index].value ??
                                          "no value",
                                      style: GoogleFonts.plusJakartaSans(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      ":${widget.attributes?[index].attribute?.name}",
                                      style: GoogleFonts.plusJakartaSans(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Share.share('${widget.id}');
                          },
                          child: GestureDetector(
                            onTap: () {
                              Share.share(
                                  "https://buyandsell2024.com/?code=advDetails");
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                  color: grey,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Icon(
                                Icons.share,
                                color: brawn,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: EdgeInsets.only(right: 30, top: 10),
                          child: CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 20,
                            backgroundImage:
                                NetworkImage("https://buyandsell2024.com/$img"),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Column(
                            children: [
                              Text(
                                widget.sellername ?? "انت",
                                style: GoogleFonts.plusJakartaSans(
                                    fontWeight: FontWeight.w600, fontSize: 14),
                              ),
                              Text(
                                widget.phone ?? "no seller phone",
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "وصف",
                            style: GoogleFonts.plusJakartaSans(
                                fontWeight: FontWeight.w600, fontSize: 17),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 40),
                        child: Text(
                          widget.description ?? "",
                          textAlign: TextAlign.end,
                          style: GoogleFonts.plusJakartaSans(fontSize: 14),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: grey,
                      thickness: 1,
                      endIndent: 30,
                      indent: 30,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "اظهار الكل",
                          style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: darkbrawn),
                        ),
                        Text(
                          "التعليقات",
                          style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //   children: [
                    //     Column(
                    //       children: [
                    //         Text(
                    //           userName ?? "",
                    //           style: GoogleFonts.plusJakartaSans(
                    //               fontSize: 16, fontWeight: FontWeight.w600),
                    //         ),
                    //       ],
                    //     ),
                    //   ],
                    // ),
                    Column(
                        children: List.generate(
                            widget.comments?.length ?? 1,
                            (index) => Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                        size: 20,
                                      ),
                                      onPressed: () async {
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        prefs.setString(
                                            "comment_id",
                                            widget.comments?[index].id
                                                    .toString() ??
                                                '0');
                                        prefs.setString(
                                            "comment_content",
                                            widget.comments?[index].content
                                                    .toString() ??
                                                '');
                                        String id =
                                            prefs.getString("comment_id")!;
                                        await deleteComment(
                                            id: id, context: context);

                                        setState(() {
                                          widget.comments!
                                              .remove(widget.comments![index]);
                                        });
                                      },
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: .1 * mediawidth(context)),
                                      child: Text(
                                        widget.comments?[index].content ??
                                            "no comments",
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ),
                                    Text(
                                      "${widget.comments?[index].createdAt ?? " / / "}",
                                      style: GoogleFonts.plusJakartaSans(
                                          color: Colors.grey),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "${widget.comments?[index].user?.firstName ?? " 0 "}",
                                      style: GoogleFonts.plusJakartaSans(
                                          color: Colors.grey),
                                    ),
                                  ],
                                ))),
                    SizedBox(
                      height: 200,
                    ),
                  ],
                ),
              ],
            )
          ]),
        ),
      )),
    );
  }
}
