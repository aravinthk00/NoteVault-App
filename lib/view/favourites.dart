import 'package:flutter/material.dart';
import 'package:note_vault/view/widget/photo_list_tile.dart';
import 'package:note_vault/view_model/photos_provider.dart';
import 'package:provider/provider.dart';

import '../view_model/theme_provider.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    final vm = Provider.of<PhotosProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Favourites",
        ),

        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios,
              color: themeProvider.isDarkMode ? Colors.black :  Colors.white,)),
      ),
      backgroundColor: Colors.white,
      body: vm.favourites.isNotEmpty
      ? GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 250),
        itemCount: vm.favourites.length,
        itemBuilder: (context, index) {
          final photo = vm.favourites[index];
          return PhotoTileWidget(myPhoto: photo, index: index);
        },
      )
      : SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        // Required for scroll even when content is small
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(16.0),
          height: MediaQuery.of(context).size.height,
          // Ensures pull-to-refresh gesture works
          child:  Text(
            "No favourites added yet.",

            maxLines: 2,
            softWrap: true,
            style: TextStyle(fontSize: 16, color: Colors.black,),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}