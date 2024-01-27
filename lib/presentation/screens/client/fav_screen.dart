import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/core/helper/fav_provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("المفضلة"),
      ),
      body: Consumer<Fav>(
        builder: (BuildContext context, value, Widget? child) {
          return ListView.builder(
              itemCount: value.favorite.length,
              itemBuilder: (context, index) {
                return ListTile(
                    title: Text(value.favorite[index].name.toString()),
                    leading: Container(
                        width: 150,
                        height: 100,
                        child: Image.network(
                            "https://buyandsell2024.com/${value.favorite[index].imgPath}",
                            errorBuilder: (BuildContext context, Object error,
                                StackTrace? stackTrace) {
                          // Error callback, display another image when the network image is not found
                          return Image.asset('images/chair.png');
                        })),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        value.remove(value.favorite[index]);
                      },
                    ));
              });
        },
      ),
    );
  }
}
