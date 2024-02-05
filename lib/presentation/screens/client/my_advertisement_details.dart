import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/business_logic/Cubit/my_advertise/my_advertisement_cubit.dart';
import 'package:shopping/core/utils/colors.dart';
import 'package:shopping/core/utils/strings.dart';

import 'package:shopping/data/models/my_advertise_model.dart';
import 'package:shopping/data/services/apis.dart';

// ignore: must_be_immutable
class MyAdvertisementDetails extends StatefulWidget {
  MyAdvertisementDetails(
      {super.key,
       this.id,
      this.comments,
      this.subdescribtion,
      this.price,
      this.description,
       this.name,
       this.imgPath,
       this.phone,
      this.address});
  int? id;
  int? categoryId;
  int? userId;
  String? name;
  String? subdescribtion;
  String? description;
  int? cityId;
  int? price;
  String? imgPath;
  String? createdAt;
  String? updatedAt;
  String? phone;
  String? address;
  List<MyComments>? comments;
  @override
  State<MyAdvertisementDetails> createState() => _MyAdvertisementDetailsState();
}

class _MyAdvertisementDetailsState extends State<MyAdvertisementDetails> {
  bool ontapcar = false;

  bool ontapchar1 = false;

  bool ontapproduct = false;

  bool ontapchar2 = false;
  bool isAdmine = false;
  ApiServices apiServices = ApiServices();
  TextEditingController content = TextEditingController();
  String choose() {
    if (ontapcar == true) {
      return 'car';
    } else if (ontapchar1 == true) {
      return 'char1';
    } else if (ontapchar2 == true) {
      return 'char2';
    } else if (ontapproduct == true) {
      return 'product';
    } else {
      return '';
    }
  }

  String img() {
    if (ontapcar == true) {
      return 'images/car.png';
    } else if (ontapchar1 == true) {
      return 'images/char2.png';
    } else if (ontapchar2 == true) {
      return 'images/char4.png';
    } else if (ontapproduct == true) {
      return 'images/product.png';
    } else {
      return '';
    }
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
                    const Icon(Icons.favorite_border),
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
                        Navigator.pop(context);
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
                        width: double.infinity,
                        height: 200,
                        color: Colors.white,
                        child: choose() == 'char1' ||
                                choose() == 'product' ||
                                choose() == 'char2'
                            ? Image.asset(img())
                            : Image.network(
                                "https://buyandsell2024.com/${widget.imgPath}",
                                errorBuilder: (BuildContext context,
                                    Object error, StackTrace? stackTrace) {
                                // Error callback, display another image when the network image is not found
                                return Image.asset('images/car.png');
                              })),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              ontapchar1 = !ontapchar1;
                            });
                          },
                          child: Container(
                            width: 90,
                            height: 80,
                            color: grey,
                            child: ontapchar1
                                ? Image.asset("images/car.png")
                                : Image.asset("images/char2.png"),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              ontapproduct == !ontapproduct;
                            });
                          },
                          child: Container(
                            width: 90,
                            height: 80,
                            color: grey,
                            child: Image.asset("images/product.png"),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              ontapchar2 = !ontapchar2;
                            });
                          },
                          child: Container(
                            width: 90,
                            height: 80,
                            color: grey,
                            child: Image.asset("images/char4.png"),
                          ),
                        )
                      ],
                    ),
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
                          child: Text("${widget.price ?? 0}"),
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
                    // Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //     children: List.generate(
                    //       widget.attributes?.length ?? 2,
                    //       (index) => Text(
                    //         widget.attributes?[index].value ?? "no value",
                    //         style: GoogleFonts.plusJakartaSans(
                    //             fontWeight: FontWeight.w600),
                    //       ),
                    //     )),
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
                        const Spacer(),
                        const Padding(
                          padding: EdgeInsets.only(right: 30, top: 10),
                          child: CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 20,
                            backgroundImage:
                                ExactAssetImage("images/person.png"),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Column(
                            children: [
                              Text(
                                "انت",
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
                                        await apiServices.deleteComment(
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
                                      "${widget.comments?[index].userId ?? " 0 "}",
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
