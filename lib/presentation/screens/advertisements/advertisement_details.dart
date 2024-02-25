import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:shopping/business_logic/Cubit/advertisement/advertisment_cubit.dart';
import 'package:shopping/core/utils/colors.dart';
import 'package:shopping/core/utils/strings.dart';
import 'package:shopping/data/models/advertisement_model.dart';
import 'package:shopping/data/services/apis.dart';
import 'package:shopping/data/services/comments_api.dart';

// ignore: must_be_immutable
class AdvertismentDetails extends StatefulWidget {
  AdvertismentDetails(
      {super.key,
      this.name,
      this.subdescribtion,
      this.location,
      this.price,
      this.attributes,
      this.sellerPhone,
      this.fullDescribition,
      this.comments,
   
      this.files,
      required this.advId,
      this.commentername,
      this.sellername,
      this.nameofattrs});
  String? name;
  String? subdescribtion;
  String? location;
  String? price;
  String? sellername;
  String? commentername;
  String? nameofattrs;
  List<Attributes>? attributes;
  String? sellerPhone;
  String? fullDescribition;
  final String advId;
  List<Comments>? comments;
  List<FilesAdv>? files;


  @override
  State<AdvertismentDetails> createState() => _AdvertismentDetailsState();
}

class _AdvertismentDetailsState extends State<AdvertismentDetails> {
  bool ontapcar = false;

  bool ontapchar1 = false;

  bool ontapproduct = false;

  bool ontapchar2 = false;
  bool isAdmine = false;
  ApiServices apiServices = ApiServices();
  TextEditingController content = TextEditingController();
 
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
                Container(
                    margin: EdgeInsets.only(bottom: 10),
                    width: double.infinity,
                    height: 200,
                    color: Colors.white,
                    child: widget.files!.isEmpty
                        ? Center(
                            child: Text("لم يتم اضافه اي صور لهذا الاعلان "))
                        : CarouselSlider(
                            items: List.generate(
                                widget.files?.length ?? 1,
                                (index) => Image.network(
                                        "https://buyandsell2024.com/${widget.files?[index].filePath}",
                                        errorBuilder: (BuildContext context,
                                            Object error,
                                            StackTrace? stackTrace) {
                                      // Error callback, display another image when the network image is not found
                                      return Image.asset('images/car_two.jpeg');
                                    })),
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
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 20),
                  child: Row(
                    children: [
                      Icon(Icons.star, color: Colors.orange),
                      Text(
                        "4.4  ",
                        style: TextStyle(
                            fontFamily: "", fontSize: 15, color: Colors.orange),
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
                      child: Text(widget.price ?? "no price"),
                    ),
                    Text(
                      widget.location ?? "no location",
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
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                      widget.attributes?.length ?? 2,
                      (index) => Row(
                        children: [
                          Text(
                            widget.attributes?[index].value ?? "no value",
                            style: GoogleFonts.plusJakartaSans(
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            widget.attributes?[index].attribute?.name ??
                                "no name",
                            style: GoogleFonts.plusJakartaSans(
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      margin: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          color: grey, borderRadius: BorderRadius.circular(20)),
                      child: Icon(
                        Icons.share,
                        color: brawn,
                      ),
                    ),
                    const Spacer(),
                    const Padding(
                      padding: EdgeInsets.only(right: 30, top: 10),
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 20,
                        backgroundImage: ExactAssetImage("images/person.png"),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Column(
                        children: [
                          Text(
                            widget.sellername ?? "",
                            style: GoogleFonts.plusJakartaSans(
                                fontWeight: FontWeight.w600, fontSize: 14),
                          ),
                          Text(
                            widget.sellerPhone ?? "no seller phone",
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
                      widget.fullDescribition!,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: List.generate(
                        widget.comments?.length ?? 1,
                        (index) => Row(
                          children: [
                            Text(
                              "${widget.comments?[index].content ?? "no comments"}",
                              style: TextStyle(color: Colors.black),
                            ),
                            SizedBox(
                              width: .09 * mediawidth(context),
                            ),
                            Text(
                              "${widget.comments?[index].createdAt ?? " / / "}",
                              style: GoogleFonts.plusJakartaSans(
                                  color: Colors.grey),
                            ),
                            SizedBox(
                              width: .1 * mediawidth(context),
                            ),
                            Text(
                              "${widget.comments?[index].user?.firstName ?? "0"}",
                              style: GoogleFonts.plusJakartaSans(
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 350,
                  height: 100,
                  decoration: BoxDecoration(
                      color: grey, borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                        textDirection: TextDirection.rtl,
                        controller: content,
                        decoration: InputDecoration(
                            prefixIcon: GestureDetector(
                                onTap: () async {
                                  await createComment(
                                      content: content.text,
                                      advId: widget.advId,
                                      context: context);
                                  setState(() {
                                    widget.comments!.last.content =
                                        content.text;
                                    content.clear();
                                    // widget.comments!
                                    //     .add(widget.comments!.last);
                                    // widget.comments!.length;
                                    BlocProvider.of<AdvertismentCubit>(context)
                                        .getAdvertismentCubit();
                                  });
                                },
                                child: Icon(Icons.send)),
                            border: InputBorder.none,
                            hintText: 'كتابه تعليق',
                            hintTextDirection: TextDirection.rtl)),
                  ),
                ),
                SizedBox(
                  height: 200,
                ),
              ],
            )
          ]),
        ),
      )),
    );
  }
}
