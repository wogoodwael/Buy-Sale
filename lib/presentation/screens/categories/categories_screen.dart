import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:shopping/business_logic/Cubit/categories/categories_cubit.dart';

import 'package:shopping/data/models/filter_model.dart';
import 'package:shopping/data/services/apis.dart';
import 'package:shopping/presentation/screens/menu.dart';
import 'package:shopping/presentation/screens/search/search_screen.dart';

import 'package:shopping/presentation/widgets/person_container.dart';
import 'package:shopping/presentation/widgets/search_container.dart';
import 'package:shopping/presentation/screens/categories/categories_column.dart';

class CategoriesScreen extends StatefulWidget {
  CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController searchname = TextEditingController();
  ApiServices apiServices = ApiServices();
  bool filterd = false;
  int itemsPerRow = 2;

  FilterModel? filterModel;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CategoriesCubit>(context).getCategoriesCubit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
          backgroundColor: Color(0xffd9d9d9),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30))),
          width: 250,
          child: MenuScreen()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            GestureDetector(
                onTap: () {
                  scaffoldKey.currentState!.openDrawer();
                },
                child: const PersonContainer()),
            SizedBox(
              height: 10,
            ),
            SearchContainer(
              onsub: () {
                // apiServices.getCategoryFilter(name: searchname.text);
                showSearch(context: context, delegate: SearchScreen());
              },
            ),
            SizedBox(
              height: 10,
            ),
            Text("الأقسام الرئيسية",
                style: GoogleFonts.cairo(
                    fontSize: 25, fontWeight: FontWeight.w600)),
            Container(
                width: 500,
                height: 700,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CategoriesColumn(),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
