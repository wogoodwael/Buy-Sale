// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shopping/core/helper/fav_provider.dart';
// import 'package:shopping/data/services/apis.dart';

// class FavoriteScreen extends StatefulWidget {
//   const FavoriteScreen({super.key, required this.id});
//   final int id;

//   @override
//   State<FavoriteScreen> createState() => _FavoriteScreenState();
// }

// class _FavoriteScreenState extends State<FavoriteScreen> {
//   SharedPreferences? _prefs;

//   @override
//   void initState() {
//     super.initState();

//     SharedPreferences.getInstance()
//         .then((prefs) => setState(() => _prefs = prefs));
//   }

//   List _fetchList() {
//     return _prefs!.getStringList('fav_list')!;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("المفضلة"),
//       ),
//       body: FutureBuilder(builder: (context, snapshot){

//       },future: ApiServices().addToFav(context, id: widget.id),)
//     );
//   }
// }
