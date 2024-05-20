// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/business_logic/Cubit/attrs_categories/attrs_categories_cubit.dart';
import 'package:shopping/business_logic/Cubit/categories/categories_cubit.dart';
import 'package:shopping/business_logic/Cubit/sub_cate_create_adv/sub_cate_create_adv_cubit.dart';
import 'package:shopping/core/helper/header.dart';
import 'package:shopping/core/utils/colors.dart';
import 'package:shopping/core/utils/strings.dart';
import 'package:shopping/data/models/categories_attrs_model.dart';
import 'package:shopping/data/models/categories_model.dart';
import 'package:shopping/data/models/sub_cate.dart';
import 'package:shopping/data/services/apis.dart';
import 'package:shopping/main.dart';
import 'package:shopping/presentation/screens/advertisements/choose_atrr._container.dart';
import 'package:shopping/presentation/screens/advertisements/choose_cat.dart';
import 'package:shopping/presentation/screens/advertisements/choose_sub.dart';
import 'package:shopping/presentation/screens/advertisements/second_sub_choose.dart';
import 'package:shopping/presentation/screens/advertisements/select_attrs.dart';
import 'package:shopping/presentation/screens/advertisements/third_sub_container.dart';

import 'package:shopping/presentation/screens/countries/choose_city_container.dart';
import 'package:shopping/presentation/screens/countries/choose_country_container.dart';
import 'package:shopping/presentation/widgets/countries_row.dart';
import 'package:shopping/presentation/widgets/custom_text_field.dart';
import 'package:video_player/video_player.dart';

// ignore: must_be_immutable
class AdvertiseScreen extends StatefulWidget {
  AdvertiseScreen({super.key, this.id});
  String? id;
  String? cityId;
  @override
  State<AdvertiseScreen> createState() => _AdvertiseScreenState();
}

class _AdvertiseScreenState extends State<AdvertiseScreen> {
  ApiServices apiServices = ApiServices();
  SubCategoriesModel? subCategoriesModel;
  CategoriesModel? categoriesModel;

  GetCateAttrsModel? getCateAttrsModel;
  bool shows1 = false;
  bool shows2 = false;
  bool shows3 = false;
  bool showCity = false;
  bool showAttrs = false;
  bool showAttrs2 = false;
  bool showAttrs3 = false;
  bool selectattrs = false;
  bool numAttrs = false;
  bool sringAttrs = false;
  String type = '';
  // int? length;
  String? value;
  TextEditingController nameOfProduct = TextEditingController();
  TextEditingController priceOfProduct = TextEditingController();
  // late List<TextEditingController> emptyValueProduct;

  TextEditingController locattion = TextEditingController();
  TextEditingController sellerName = TextEditingController();
  TextEditingController describtion = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController price = TextEditingController();

  String? text;
  String? texts;
  String? textModel;
  String? number;
  DropdownMenu? select;
  TextEditingController textController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController stringAttrs = TextEditingController();
  int selectValue = 1;
  List<Widget> widgets = [];
  List<String> textList = [];
  List<String> numList = [];
  Map<String, dynamic>? attributesMap;
  int? selectedId;
  List attrsListNumber = [];
  List attrsListSelect = [];
  List attrsListvalue = [];
  Map<String, dynamic>? filesMap;
  bool picked = false;
  bool pickedVideo = false;
  bool isLoading = false;
  Widget? image;
  VideoPlayerController? _controller;
  File? _videoFile;
  List<String> fileType = [];
  List testWithAttribute = [];
  List<String> testWithoutAttribute = [];
  List<TextEditingController> emptyValueProduct = [];
  List<bool> pressed = [];
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Update lists length when getCateAttrsModel is available
    final getCateAttrsModel =
        BlocProvider.of<AttrsCategoriesCubit>(context).getCateAttrsModel;
    if (getCateAttrsModel != null) {
      if (emptyValueProduct.length != getCateAttrsModel.data!.length) {
        emptyValueProduct = List.generate(
          getCateAttrsModel.data!.length,
          (_) => TextEditingController(),
        );
      }
      if (pressed.length != getCateAttrsModel.data!.length) {
        pressed = List.generate(getCateAttrsModel.data!.length, (_) => false);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCateAttrsModel =
        BlocProvider.of<AttrsCategoriesCubit>(context).getCateAttrsModel;
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  List<PlatformFile> filesVideos = [];
  List<String> cities = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const AdvertisementHeader(
              text: 'اضف اعلان',
            ),
            const Padding(
              padding: EdgeInsets.only(right: 30, top: 10, bottom: 5),
              child: Text(
                "اختر القسم الرئيسي ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            GestureDetector(
              child: ChooseCategoriesContainer(
                top: .3 * mediaHiegh(context),
                id: widget.id,
                ontap: () {
                  setState(() {
                    shows1 = true;
                  });
                },
              ),
            ),
            (shows1 == true)
                ? Padding(
                    padding: EdgeInsets.only(right: 30, top: 10, bottom: 5),
                    child: GestureDetector(
                      onTap: () {
                        print("heeeee${subCategoriesModel!.data!.parent!.id}");
                      },
                      child: Text(
                        "اختر القسم الفرعي ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  )
                : Container(),
            (shows1 == true)
                ? ChooseSubCategContainer(
                    top: .42 * mediaHiegh(context),
                    ontap: () {
                      setState(() {
                        showAttrs = true;
                        shows2 = true;
                      });
                    },
                  )
                : Container(),
            (shows2 == true)
                ? Padding(
                    padding: EdgeInsets.only(right: 30, top: 10, bottom: 5),
                    child: GestureDetector(
                      onTap: () {
                        print("heeeee${subCategoriesModel!.data!.parent!.id}");
                      },
                      child: Text(
                        " اختر القسم الفرعي الثاني",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  )
                : Container(),
            (shows2 == true)
                ? SecondSubCategContainer(
                    top: .42 * mediaHiegh(context),
                    ontap: () {
                      setState(() {
                        showAttrs2 = true;
                        shows3 = true;
                      });
                    },
                  )
                : Container(),
            (shows3 == true)
                ? Padding(
                    padding: EdgeInsets.only(right: 30, top: 10, bottom: 5),
                    child: GestureDetector(
                      onTap: () {
                        print("heeeee${subCategoriesModel!.data!.parent!.id}");
                      },
                      child: Text(
                        " اختر القسم الفرعي الثالث",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  )
                : Container(),
            (shows3 == true)
                ? ThirdSubCategContainer(
                    top: .42 * mediaHiegh(context),
                    ontap: () {
                      setState(() {
                        showAttrs3 = true;
                      });
                    },
                  )
                : Container(),

            const Padding(
              padding: EdgeInsets.only(right: 30, top: 10, bottom: 5),
              child: Text(
                "اختر المحافظة ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            ChooseCountryContainer(
              top: .54 * mediaHiegh(context),
              id: widget.cityId,
              ontap: () {
                setState(() {
                  showCity = true;
                });
              },
            ),
            (showCity == true)
                ? const Padding(
                    padding: EdgeInsets.only(right: 30, top: 10, bottom: 5),
                    child: Text(
                      "اختر المدينة ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  )
                : Container(),
            (showCity == true)
                ? ChooseCityContainer(
                    top: .5 * mediaHiegh(context),
                  )
                : Container(),
            // CenterChooseContainer(
            //   lenght: sharedpref.getStringList('selected_cities_names')?.length,
            // ),
            const Padding(
                padding: EdgeInsets.only(right: 30, top: 10, bottom: 5),
                child: Text(
                  "اسم  المنتج ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
            Center(
                child: Container(
              width: .85 * mediawidth(context),
              height: 40,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: TextField(
                controller: nameOfProduct,
                textDirection: TextDirection.rtl,
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            )),
            SizedBox(
              height: 20,
            ),
            (shows1 == true)
                ? BlocBuilder<AttrsCategoriesCubit, AttrsCategoriesState>(
                    builder: (context, state) {
                      if (state is AttrsCategoriesLoading) {
                        return CircularProgressIndicator(); // Or any loading widget
                      } else if (state is AttrsCategoriesSuccess) {
                        // Update getCateAttrsModel here
                        getCateAttrsModel =
                            BlocProvider.of<AttrsCategoriesCubit>(context)
                                .getCateAttrsModel;
                        if (getCateAttrsModel != null &&
                            getCateAttrsModel!.data != null) {
                          if (emptyValueProduct.length !=
                              getCateAttrsModel!.data!.length) {
                            emptyValueProduct = List.generate(
                              getCateAttrsModel!.data!.length,
                              (_) => TextEditingController(),
                            );
                          }
                          if (pressed.length !=
                              getCateAttrsModel!.data!.length) {
                            pressed = List.generate(
                                getCateAttrsModel!.data!.length, (_) => false);
                          }
                        }
                        return Column(
                          children: List.generate(
                              getCateAttrsModel!.data!.length,
                              (index) => Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: 30, bottom: 5),
                                            child: Text(
                                              getCateAttrsModel?.data?[index]
                                                      .attribute?.nameAr
                                                      .toString() ??
                                                  "",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                          ),
                                        ],
                                      ),
                                      getCateAttrsModel!.data![index].attribute!
                                                      .type ==
                                                  "select" &&
                                              getCateAttrsModel!.data![index]
                                                  .attribute!.nameAr!
                                                  .contains("نوع") &&
                                              getCateAttrsModel!.data![index]
                                                  .attribute!.values!.isNotEmpty
                                          ? SelectAttribute(
                                              ontap: () async {
                                                branshMenuType(
                                                    context,
                                                    .5 * mediaHiegh(context),
                                                    getCateAttrsModel!
                                                        .data![index]
                                                        .attribute!
                                                        .values!
                                                        .length);

                                                setState(() {
                                                  texts = texts;
                                                });
                                              },
                                              text: texts,
                                            )
                                          : getCateAttrsModel!.data![index]
                                                          .attribute!.type ==
                                                      "select" &&
                                                  getCateAttrsModel!
                                                          .data![index]
                                                          .attribute!
                                                          .nameAr ==
                                                      "موديل السيارة"
                                              ? SelectAttribute(
                                                  ontap: () async {
                                                    branshMenuModel(
                                                      context,
                                                      .5 * mediaHiegh(context),
                                                    );

                                                    setState(() {
                                                      textModel = textModel;
                                                    });
                                                  },
                                                  text: textModel,
                                                )
                                              : Center(
                                                  child: Container(
                                                  width:
                                                      .85 * mediawidth(context),
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.black)),
                                                  child: TextField(
                                                    controller:
                                                        emptyValueProduct[
                                                            index],
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    decoration: InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        prefixIcon: IconButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                pressed[index] =
                                                                    !pressed[
                                                                        index];
                                                              });
                                                              attrsListSelect
                                                                  .add({
                                                                'id': getCateAttrsModel!
                                                                    .data![
                                                                        index]
                                                                    .attributeId,
                                                                'value':
                                                                    emptyValueProduct[
                                                                            index]
                                                                        .text
                                                              });
                                                              print(
                                                                  "=========$attrsListSelect");
                                                            },
                                                            icon: Icon(
                                                              Icons
                                                                  .check_circle,
                                                              color: !pressed[
                                                                      index]
                                                                  ? Colors.grey
                                                                  : Colors
                                                                      .green,
                                                            ))),
                                                  ),
                                                )),
                                    ],
                                  )),
                        );
                      } else if (state is AttrsCategoriesFail) {
                        return Center(
                          child: Text(
                            "لا يوجد مواصفات لهذا المنتج",
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                        ); // Or any error widget
                      } else {
                        return Text("Failed to load attrs");
                      }
                    },
                  )
                : Container(),
            (type == 'number')
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Padding(
                          padding:
                              EdgeInsets.only(right: 30, top: 10, bottom: 5),
                          child: Text(
                            "  خصائص  المنتج الرقمية",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          )),
                      Center(
                          child: Container(
                        width: .85 * mediawidth(context),
                        height: 40,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: TextField(
                          textDirection: TextDirection.rtl,
                          controller: priceOfProduct,
                          onSubmitted: (val) {
                            String id = sharedpref.getString('id_of_attrs')!;
                            attrsListNumber
                                .add({'id': id, 'value': priceOfProduct.text});
                            setState(() {
                              numAttrs = true;
                              attrsListSelect = List.from(attrsListNumber);
                              print("=========$attrsListSelect");
                            });
                          },
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                        ),
                      )),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Padding(
                          padding:
                              EdgeInsets.only(right: 30, top: 10, bottom: 5),
                          child: Text(
                            "  خصائص  المنتج النصية",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          )),
                      Center(
                          child: Container(
                        width: .85 * mediawidth(context),
                        height: 40,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: TextField(
                          controller: stringAttrs,
                          onSubmitted: (val) {
                            attrsListSelect
                                .add({'name': stringAttrs.text, 'value': "5"});
                            setState(() {
                              numAttrs = true;
                              // attrsListSelect = List.from(attrsListvalue);
                              print("=========$attrsListSelect");
                            });
                          },
                          textDirection: TextDirection.rtl,
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                        ),
                      )),
                    ],
                  ),
            AdvTextField(
              text: 'سعر المنتج',
              controller: price,
            ),
            AdvTextField(text: "عنوان  البائع ", controller: locattion),
            AdvTextField(text: "رقم موبايل  البائع ", controller: phone),
            AdvTextField(text: "اسم البائع   ", controller: sellerName),
            const SizedBox(
              height: 20,
            ),
            const Padding(
                padding: EdgeInsets.only(right: 30, top: 10, bottom: 5),
                child: Text(
                  "صورة المنتج   ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Stack(
                children: [
                  Container(
                    width: .8 * mediawidth(context),
                    height: 150,
                    decoration: BoxDecoration(
                      color: grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        await pickFiles();
                        //!add

                        filesMap = {
                          'files[0][file_path]': files,
                          'files[0][type]': fileType
                        };

                        for (var i = 0; i < files.length; i++) {
                          if (files[i].extension == 'mp4') {
                            setState(() {
                              pickedVideo = true;
                            });
                          } else {
                            setState(() {
                              picked = true;
                            });
                          }
                        }

                        print("filesssssssss${files[0].path}");
                        print("filesssssssss${files.first.extension!}");
                      },
                      child: picked
                          ? image
                          : pickedVideo
                              ? _controller != null
                                  ? VideoPlayer(_controller!)
                                  : Container()
                              : Center(
                                  child: CircleAvatar(
                                    backgroundColor: brawn,
                                    child: const Icon(Icons.add),
                                  ),
                                ),
                    ),
                  ),
                  if (picked || pickedVideo)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          setState(() {
                            // Reset the picked state
                            picked = false;
                            pickedVideo = false;

                            // Optionally reset the picked image or video
                            _controller?.dispose();
                            _controller = null;
                            image = null;
                          });
                        },
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
                padding: EdgeInsets.only(right: 30, top: 10, bottom: 5),
                child: Text(
                  " وصف المنتج",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
            Center(
              child: Container(
                  margin: const EdgeInsets.only(left: 20),
                  width: .8 * mediawidth(context),
                  height: 120,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      color: grey,
                      borderRadius: BorderRadius.circular(2)),
                  child: TextField(
                    textDirection: TextDirection.rtl,
                    controller: describtion,
                    decoration: const InputDecoration(border: InputBorder.none),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: MaterialButton(
                minWidth: 200,
                color: brawn,
                onPressed: () async {
                  SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();

                  List<String> cityid =
                      sharedPreferences.getStringList('selected_cities')!;

                  String categoriesId = showAttrs3
                      ? sharedPreferences.getString("third_sub_id")!
                      : showAttrs2
                          ? sharedPreferences.getString("second_sub_id")!
                          : showAttrs
                              ? sharedPreferences.getString("sub_id")!
                              : sharedPreferences.getString("postId")!;
                  print("caaaaaaaaaaaaaaaaaaatid$categoriesId");
                  setState(() {
                    isLoading = true;
                  });
                  for (var i = 0; i < files.length; i++) {
                    if (files[i].extension == 'mp4') {
                      fileType.add('video');
                    } else {
                      fileType.add('image');
                    }
                  }

//!post adv
                  await apiServices.postAdvertise(
                    name: nameOfProduct.text,
                    cityId: cityid,
                    categoriesId: categoriesId,
                    description: describtion.text,
                    files: filesMap!.values.first,
                    phone: phone.text,
                    adress: locattion.text,
                    price: price.text,
                    atrributesid: attrsListSelect,
                    context: context,
                    filetype: fileType,
                  );
                  setState(() {
                    isLoading = false;
                  });

                  print("cooshen category $categoriesId");
                  print("uploaded file ${filesMap!.values.first}");

                  print("uploaded attributes  ${jsonEncode(attrsListSelect)}");
                  print(
                      "uploaded attributes value ${jsonEncode(attrsListvalue)}");

                  print("file type ${files.last.extension}");
                },
                child: FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "نشر الاعلان ",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      isLoading
                          ? const SpinKitDualRing(
                              color: Colors.white,
                            )
                          : const Icon(
                              Icons.upload_sharp,
                              color: Colors.white,
                            )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }

  List<PlatformFile> files = [];
  // Changed the variable type to FilePickerResult

  Future<void> pickFiles() async {
    try {
      FilePickerResult? pickedFiles = await FilePicker.platform.pickFiles(
        // Removed allowMultiple: true
        allowMultiple: true, // Allow multiple files selection
        type: FileType.any,
      );
      if (pickedFiles != null) {
        setState(() {
          image = Image.file(File(pickedFiles.files.first.path!));
          files = pickedFiles.files;
          _videoFile = File(pickedFiles.files.single.path!);
          _controller = VideoPlayerController.file(_videoFile!)
            ..initialize().then((_) {
              setState(() {
                _controller?.play();
              });
            });
          // Assign the files property of the FilePickerResult object
        });

        print(files.last.extension);
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // void branshMenu(
  //   BuildContext context,
  //   double top,
  // ) {
  //   BlocProvider.of<AttrsCategoriesCubit>(context).getCategoriesAttrsCubit();
  //   getCateAttrsModel =
  //       BlocProvider.of<AttrsCategoriesCubit>(context).getCateAttrsModel;
  //   showMenu(
  //     context: context,
  //     color: grey,
  //     constraints: const BoxConstraints(
  //       minWidth: 230,
  //       minHeight: 300,
  //     ),
  //     shape:
  //         const RoundedRectangleBorder(side: BorderSide(color: Colors.black)),
  //     position: RelativeRect.fromLTRB(70, top, 40, 1),
  //     items: List.generate(
  //       getCateAttrsModel!.data!.length,
  //       (index) => PopupMenuItem(
  //           onTap: () async {
  //             SharedPreferences sharedPreferences =
  //                 await SharedPreferences.getInstance();
  //             setState(() {
  //               text = getCateAttrsModel!.data![index].attribute!.nameAr;
  //               type = getCateAttrsModel!.data![index].attribute!.type!;
  //               // if (getCateAttrsModel!.data![index].attribute!.type ==
  //               //     'select') {
  //               //   value = getCateAttrsModel!
  //               //       .data![index].attribute!.values![index].value;
  //               // }

  //               sharedPreferences.setString(
  //                   "type", getCateAttrsModel!.data![index].attribute!.type!);
  //               sharedPreferences.setString(
  //                   "text", getCateAttrsModel!.data![index].attribute!.nameAr!);
  //               print("ttttttttt$type");
  //               sharedPreferences.setInt("lenght",
  //                   getCateAttrsModel!.data![index].attribute!.values!.length);
  //               sharedPreferences.setString("id_of_attrs",
  //                   getCateAttrsModel!.data![index].attribute!.id.toString());

  //               length = sharedPreferences.getInt('lenght');
  //               print("lenght of values list$length");
  //             });
  //           },
  //           value: 1,
  //           child: StatefulBuilder(
  //             builder: (BuildContext context,
  //                 void Function(void Function()) setState) {
  //               return CountiesRow(
  //                   country_name: getCateAttrsModel!
  //                       .data![index].attribute!.nameAr
  //                       .toString());
  //             },
  //           )),
  //     ),
  //   );
  // }

//!attrs
  void branshMenuType(BuildContext context, double top, int lenght) {
    // BlocProvider.of<AttrsCategoriesCubit>(context).getCategoriesAttrsCubit();
    getCateAttrsModel =
        BlocProvider.of<AttrsCategoriesCubit>(context).getCateAttrsModel;
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
        lenght,
        (index) => PopupMenuItem(
          onTap: () async {
            SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            setState(() {
              // Clear the testWithAttribute list before adding new items
              testWithAttribute.clear();

              texts = getCateAttrsModel!
                  .data![0].attribute!.values![index].value
                  .toString();
              print("ttttttt$texts");
              selectattrs = true;
              sharedPreferences.setString("texts", texts.toString());
              sharedPreferences.setInt("related_id",
                  getCateAttrsModel!.data![0].attribute!.values![index].id!);
              attrsListSelect.add({
                'id': getCateAttrsModel!.data![0].attributeId,
                'value': texts
              });
              for (var i = 0;
                  i <=
                      getCateAttrsModel!.data![1].attribute!.values!.length + 1;
                  i++) {
                var value =
                    getCateAttrsModel!.data![1].attribute!.values![i].value;
                var id = getCateAttrsModel!
                    .data![1].attribute!.values![i].relatedAttributeId;
                print(
                    "sssssssssssss${getCateAttrsModel!.data![0].attribute!.values![index].id!}");
                if (id ==
                    getCateAttrsModel!.data![0].attribute!.values![index].id) {
                  testWithAttribute.add(value!);
                }
              }

              print("With related attribute: $testWithAttribute");

              // // Pass the selected ID and filtered lists to branshMenuModel
              // branshMenuModel(context, top, testWithAttribute);
            });
          },
          value: 1,
          child: StatefulBuilder(
            builder: (BuildContext context,
                void Function(void Function()) setState) {
              return CountiesRow(
                  country_name: getCateAttrsModel!
                      .data![0].attribute!.values![index].value
                      .toString());
            },
          ),
        ),
      ),
    );
  }

  void branshMenuModel(
    BuildContext context,
    double top,
  ) {
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
        testWithAttribute.length,
        (index) => PopupMenuItem(
            onTap: () async {
              setState(() {
                textModel = testWithAttribute[index];

                selectattrs = true;

                attrsListSelect.add({
                  'id': getCateAttrsModel!.data![1].attributeId,
                  'value': textModel
                });

                print("clearrrrrrrrrrrrrrrrrr$testWithAttribute");
              });
            },
            value: 1,
            child: StatefulBuilder(
              builder: (BuildContext context,
                  void Function(void Function()) setState) {
                return CountiesRow(country_name: testWithAttribute[index]);
              },
            )),
      ),
    );
  }
}
