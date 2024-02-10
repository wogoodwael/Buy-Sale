// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/business_logic/Cubit/attrs_categories/attrs_categories_cubit.dart';
import 'package:shopping/core/helper/header.dart';
import 'package:shopping/core/utils/colors.dart';
import 'package:shopping/core/utils/strings.dart';
import 'package:shopping/data/models/categories_attrs_model.dart';
import 'package:shopping/data/models/sub_cate.dart';
import 'package:shopping/data/services/apis.dart';
import 'package:shopping/presentation/screens/advertisements/choose_atrr._container.dart';
import 'package:shopping/presentation/screens/advertisements/choose_cat.dart';
import 'package:shopping/presentation/screens/advertisements/choose_sub.dart';
import 'package:shopping/presentation/screens/advertisements/select_attrs.dart';
import 'package:shopping/presentation/screens/countries/center_choose_container.dart';
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
  GetCateAttrsModel? getCateAttrsModel;
  bool show = false;
  bool showCity = false;
  bool showAttrs = false;
  String type = '';
  int? length;
  String? value;
  TextEditingController nameOfProduct = TextEditingController();
  TextEditingController priceOfProduct = TextEditingController();
  TextEditingController locattion = TextEditingController();
  TextEditingController sellerName = TextEditingController();
  TextEditingController describtion = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController price = TextEditingController();
  String? text;
  String? texts;
  String? number;
  DropdownMenu? select;
  TextEditingController textController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  int selectValue = 1;
  List<Widget> widgets = [];
  List<String> textList = [];
  List<String> numList = [];
  Map<String, dynamic>? attributesMap;
  Map<String, dynamic>? filesMap;
  bool picked = false;
  bool isLoading = false;
  Widget? image;
  VideoPlayerController? _controller;
  File? _videoFile;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _pickVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    if (result != null) {
      setState(() {
        _videoFile = File(result.files.single.path!);
        _controller = VideoPlayerController.file(_videoFile!)
          ..initialize().then((_) {
            setState(() {
              _controller?.play();
            });
          });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const AdvertisementHeader(),
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
                    show = true;
                  });
                },
              ),
            ),
            (show == true)
                ? const Padding(
                    padding: EdgeInsets.only(right: 30, top: 10, bottom: 5),
                    child: Text(
                      "اختر القسم الفرعي ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  )
                : Container(),
            (show == true)
                ? ChooseSubCategContainer(
                    top: .42 * mediaHiegh(context),
                    ontap: () {
                      setState(() {
                        showAttrs = true;
                        // getArrtibute();
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
            const CenterChooseContainer(),
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
            (showAttrs == true)
                ? const Padding(
                    padding: EdgeInsets.only(right: 30, top: 10, bottom: 5),
                    child: Text(
                      "مواصفات المنتج ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ))
                : Container(),
            (showAttrs == true)
                ? ChooseAttributeContainer(
                    text: text,
                    top: .5 * mediaHiegh(context),
                    ontap: () async {
                      branshMenu(
                        context,
                        .5 *
                            mediaHiegh(
                              context,
                            ),
                      );

                      SharedPreferences sharedPreferences =
                          await SharedPreferences.getInstance();
                      type = sharedPreferences.getString("type")!;
                      text = sharedPreferences.getString('text') ?? "";
                      print("!!!!!!!!!!$type");

                      setState(() {
                        type = type;
                        text = text;
                      });
                    },
                  )
                : Container(),
            (type == 'select')
                ? SelectAttribute(
                    ontap: () async {
                      SharedPreferences sharedPreferences =
                          await SharedPreferences.getInstance();
                      branshMenuSelect(
                        context,
                        .5 * mediaHiegh(context),
                      );
                      texts = sharedPreferences.getString('texts') ?? "";
                      setState(() {
                        texts = texts;
                      });
                    },
                    text: texts,
                  )
                : (type == 'number')
                    ? Column(
                        children: [
                          const Padding(
                              padding: EdgeInsets.only(
                                  right: 30, top: 10, bottom: 5),
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
                              onSubmitted: (value) {
                                attributesMap = {
                                  'attributes[0][id]': getCateAttrsModel!
                                      .data![1].attribute!.id!
                                      .toString(),
                                  'attributes[0][value]': priceOfProduct.text
                                };
                              },
                              controller: priceOfProduct,
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                            ),
                          )),
                        ],
                      )
                    : Column(
                        children: [
                          const Padding(
                              padding: EdgeInsets.only(
                                  right: 30, top: 10, bottom: 5),
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
                              textDirection: TextDirection.rtl,
                              controller: priceOfProduct,
                              decoration:
                                  InputDecoration(border: InputBorder.none),
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
              child: Container(
                width: .8 * mediawidth(context),
                height: 150,
                decoration: BoxDecoration(
                    color: grey, borderRadius: BorderRadius.circular(10)),
                child: GestureDetector(
                  onTap: () async {
                    await pickFiles();
                    //!add
                    filesMap = {
                      'files[0][file_path]': files,
                      'files[0][type]': files.first.extension!
                    };
                    setState(() {
                      picked = true;
                    });
                    print("filesssssssss${files[0].path}");
                    print("filesssssssss${files.first.extension!}");
                  },
                  child: picked
                      ? image
                      : Center(
                          child: CircleAvatar(
                            backgroundColor: brawn,
                            child: const Icon(Icons.add),
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
                padding: EdgeInsets.only(right: 30, top: 10, bottom: 5),
                child: Text(
                  "فديو المنتج   ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
            Center(
                child: Container(
              width: .8 * mediawidth(context),
              height: 150,
              decoration: BoxDecoration(
                  color: grey, borderRadius: BorderRadius.circular(10)),
              child: MaterialButton(
                  onPressed: _pickVideo,
                  child: _videoFile == null
                      ? const Icon(Icons.video_library)
                      : _controller != null && _controller!.value.isInitialized
                          ? AspectRatio(
                              aspectRatio: _controller!.value.aspectRatio,
                              child: VideoPlayer(_controller!),
                            )
                          : const CircularProgressIndicator()),
            )),
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
                    controller: describtion,
                    decoration: InputDecoration(border: InputBorder.none),
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

                  List ciryid = [sharedPreferences.getInt("id_of_city")!, 15];
                  String categoriesId = sharedPreferences.getString("sub_id")!;
                  setState(() {
                    isLoading = true;
                  });
//!post adv
                  await apiServices.postAdvertise(
                    name: nameOfProduct.text,
                    cityId: jsonEncode(ciryid),
                    categoriesId: categoriesId,
                    description: describtion.text,
                    files: filesMap!.values.first,
                    phone: phone.text,
                    adress: locattion.text,
                    price: price.text,
                    atrributes0: attributesMap!.values.first,
                    atrributes1: attributesMap!.values.last,
                    filetype: 'image',
                    context: context,
                  );
                  setState(() {
                    isLoading = false;
                  });
                  print("cooshen category $categoriesId");
                  print("uploaded file ${filesMap!.values.first}");
                  print("uploaded attributes $attributesMap");

                  print("file type ${files.first.extension}");
                  print("city id $ciryid");
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

          // Assign the files property of the FilePickerResult object
        });

        print(files.first.extension);
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void branshMenu(
    BuildContext context,
    double top,
  ) {
    BlocProvider.of<AttrsCategoriesCubit>(context).getCategoriesAttrsCubit();
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
        getCateAttrsModel!.data!.length,
        (index) => PopupMenuItem(
            onTap: () async {
              SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              setState(() {
                text = getCateAttrsModel!.data![index].attribute!.nameAr;
                type = getCateAttrsModel!.data![index].attribute!.type!;
                if (getCateAttrsModel!.data![index].attribute!.type ==
                    'select') {
                  value = getCateAttrsModel!
                      .data![index].attribute!.values![index].value;
                }
                length =
                    getCateAttrsModel!.data![index].attribute!.values!.length;
                sharedPreferences.setString(
                    "type", getCateAttrsModel!.data![index].attribute!.type!);
                sharedPreferences.setString(
                    "text", getCateAttrsModel!.data![index].attribute!.nameAr!);
                print("ttttttttt${type}");
                sharedPreferences.setInt("lenght",
                    getCateAttrsModel!.data![index].attribute!.values!.length);

                length = sharedPreferences.getInt('lenght');
                print("lenght of values list${length}");
                sharedPreferences.setString('attr0_id',
                    getCateAttrsModel!.data![0].attribute!.id.toString());
                // BlocProvider.of<AttrsCategoriesCubit>(context)
                //     .getCategoriesAttrsCubit();
                // for (var idElement in getCateAttrsModel!.data!) {
                //   id.add(idElement.attributeId!);
                // }
                // jsonEncode(id);

                // for (var element in getCateAttrsModel!.data!) {
                //   attrsList.add(element.attribute!);
                // }
                // jsonEncode(attrsList);

                sharedPreferences.setString('attr1_id',
                    getCateAttrsModel!.data![1].attribute!.id.toString());
                sharedPreferences.setString(
                    'attr1_value',
                    getCateAttrsModel!.data![1].attribute!.values![1].value
                        .toString());
              });
            },
            value: 1,
            child: StatefulBuilder(
              builder: (BuildContext context,
                  void Function(void Function()) setState) {
                return CountiesRow(
                    country_name: getCateAttrsModel!
                        .data![index].attribute!.nameAr
                        .toString());
              },
            )),
      ),
    );
  }

//!attrs
  void branshMenuSelect(
    BuildContext context,
    double top,
  ) {
    BlocProvider.of<AttrsCategoriesCubit>(context).getCategoriesAttrsCubit();
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
        length!,
        (index) => PopupMenuItem(
            onTap: () async {
              SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              setState(() {
                texts = getCateAttrsModel!
                    .data![1].attribute!.values![index].value
                    .toString();
                sharedPreferences.setString(
                    "texts",
                    getCateAttrsModel!.data![1].attribute!.values![index].value
                        .toString());
                attributesMap = {
                  'attributes[0][id]':
                      getCateAttrsModel!.data![1].attribute!.id!.toString(),
                  'attributes[0][value]': texts
                };
                print(attributesMap);
              });
            },
            value: 1,
            child: StatefulBuilder(
              builder: (BuildContext context,
                  void Function(void Function()) setState) {
                return CountiesRow(
                    country_name: getCateAttrsModel!
                        .data![1].attribute!.values![index].value
                        .toString());
              },
            )),
      ),
    );
  }
}
