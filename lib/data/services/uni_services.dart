import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopping/business_logic/Cubit/advertisement/advertisment_cubit.dart';
import 'package:shopping/data/services/context_utility.dart';
import 'package:shopping/main.dart';
import 'package:shopping/presentation/screens/advertisements/advertise.dart';
import 'package:shopping/presentation/screens/advertisements/advertisement_details.dart';
import 'package:shopping/presentation/screens/categories/categories_screen.dart';
import 'package:shopping/presentation/screens/categories/sub_cate_adve.dart';
import 'package:shopping/presentation/screens/client/profile.dart';
import 'package:uni_links/uni_links.dart';

class UniServices {
  static String _code = '';
  static String get code => _code;
  static bool get hasCode => _code.isNotEmpty;
  static void reset() => _code = '';
  static init() async {
    try {
      final Uri? uri = await getInitialUri();
      uniHandler(uri);
    } on PlatformException {
      log("failed to recieve code ");
    } on FormatException {
      log("wrong formate code recieved ");
    }
    uriLinkStream.listen((Uri? uri) async {
      uniHandler(uri);
    }, onError: (error) {
      log("OnUriLink Error : $error");
    });
  }

  static uniHandler(Uri? uri) {
    if (uri == null || uri.queryParameters.isEmpty) {
      return;
    }
    Map<String, dynamic> param = uri.queryParameters;
    String recievedCode = param['code'] ?? "";
    if (recievedCode == "advDetails") {
      Navigator.push(
          ContextUtility.context!,
          MaterialPageRoute(
              builder: (_) => CategoriesScreen()));
    } else {
      Navigator.push(ContextUtility.context!,
          MaterialPageRoute(builder: (_) => ProfileScreen()));
    }
  }
}
