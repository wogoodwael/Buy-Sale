import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/business_logic/Cubit/attrs_categories/attrs_categories_cubit.dart';

import 'package:shopping/core/utils/colors.dart';
import 'package:shopping/core/utils/strings.dart';
import 'package:shopping/data/models/categories_attrs_model.dart';
import 'package:shopping/data/models/sub_cate.dart';
import 'package:shopping/data/services/apis.dart';
import 'package:shopping/presentation/screens/advertisements/choose_atrr._container.dart';
import 'package:shopping/presentation/screens/advertisements/choose_cat.dart';
import 'package:shopping/presentation/screens/advertisements/choose_sub.dart';
import 'package:shopping/presentation/screens/advertisements/select_attrs.dart';
import 'package:shopping/presentation/screens/client/profile.dart';
import 'package:shopping/presentation/screens/countries/center_choose_container.dart';
import 'package:shopping/presentation/screens/countries/choose_city_container.dart';
import 'package:shopping/presentation/screens/countries/choose_country_container.dart';
import 'package:shopping/presentation/widgets/countries_row.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: mediawidth(context),
              height: .2 * mediaHiegh(context),
              decoration: BoxDecoration(
                  color: brawn,
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(50))),
              child: const Padding(
                padding: EdgeInsets.only(top: 50),
                child: Center(
                  child: Text(
                    "اضف اعلان",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
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
                decoration: InputDecoration(border: InputBorder.none),
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
                      // BlocProvider.of<AttrsCategoriesCubit>(context)
                      //     .getCategoriesAttrsCubit();
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
                              controller: priceOfProduct,
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                            ),
                          )),
                        ],
                      ),
            const Padding(
                padding: EdgeInsets.only(right: 30, top: 10, bottom: 5),
                child: Text(
                  "سعر  المنتج ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
            Center(
                child: Container(
              width: .85 * mediawidth(context),
              height: 40,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: TextField(
                controller: price,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            )),
            const Padding(
                padding: EdgeInsets.only(right: 30, top: 10, bottom: 5),
                child: Text(
                  "عنوان  البائع ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
            Center(
                child: Container(
              width: .85 * mediawidth(context),
              height: 40,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: TextField(
                controller: locattion,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            )),
            const Padding(
                padding: EdgeInsets.only(right: 30, top: 10, bottom: 5),
                child: Text(
                  "رقم موبايل  البائع ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
            Center(
                child: Container(
              width: .85 * mediawidth(context),
              height: 40,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: TextField(
                controller: phone,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            )),
            const Padding(
                padding: EdgeInsets.only(right: 30, top: 10, bottom: 5),
                child: Text(
                  "اسم البائع   ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
            Center(
                child: Container(
              width: .85 * mediawidth(context),
              height: 40,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: TextField(
                controller: sellerName,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            )),
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
                      'files[0][file_path]': files[0],
                      'files[0][type]': files.first.extension!
                    };
                    print("filesssssssss${files[0].path}");
                    print("filesssssssss${files.first.extension!}");
                  },
                  child: Center(
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
                      filetype: 'image');
                  print("cooshen category $categoriesId");
                  print("uploaded file ${filesMap!.values.first}");
                  print("uploaded attributes $attributesMap");

                  print("file type ${files.first.extension}");
                  print("city id $ciryid");
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.green,
                      margin: EdgeInsets.only(
                          bottom: MediaQuery.sizeOf(context).height - 100),
                      content: Text("تم انشاء الاعلان بنجاح")));
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => ProfileScreen()));
                },
                child: FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "نشر الاعلان ",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.upload_sharp,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }

  List files = [];
  // Changed the variable type to FilePickerResult

  Future<void> pickFiles() async {
    try {
      FilePickerResult? pickedFiles = await FilePicker.platform.pickFiles(
        // Removed allowMultiple: true
        allowMultiple: true, // Allow multiple files selection
        type: FileType.image,
      );
      if (pickedFiles != null) {
        setState(() {
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
