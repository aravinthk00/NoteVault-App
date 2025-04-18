import 'package:flutter/material.dart';
import 'package:note_vault/view_model/photos_provider.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import '../../model/photos.dart';
import '../../utils/util.dart';

class PhotoTileWidget extends StatelessWidget {
  final Photos myPhoto;
  final int index;

  const PhotoTileWidget({super.key, required this.myPhoto, required this.index});

  @override
  Widget build(BuildContext context) {

    final vm = Provider.of<PhotosProvider>(context);

    return InkWell(
      onTap: () => Utils.toastMessage("${myPhoto.id} clicked"),
      child: Card(
        elevation: 4,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  margin: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.orangeAccent.shade100)
                  ),
                  child:  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Center(
                        child: Image.network(
                          myPhoto.thumbnailUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (BuildContext context,
                              Object exception,
                              StackTrace? stackTrace) {
                            return Image.asset(
                              'assets/icon/icon.jpg',
                              opacity: const AlwaysStoppedAnimation(.6),
                            );
                          },
                          loadingBuilder: (BuildContext context,
                              Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                color: Colors.orangeAccent,
                                value: loadingProgress
                                    .expectedTotalBytes !=
                                    null
                                    ? loadingProgress
                                    .cumulativeBytesLoaded /
                                    loadingProgress
                                        .expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        )),
                  ),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              myPhoto.id.toString(),
                              maxLines: 1,
                              softWrap: true,
                              style: const TextStyle(color: Colors.black87, fontSize: 14,fontWeight: FontWeight.w400),
                            ),
                            IconButton(
                              icon: Icon(
                                  vm.isFavourite(myPhoto) ? Icons.favorite : Icons.favorite_border,
                                  color:  Colors.orange),
                              onPressed: () => {
                                vm.toggleFavourite(myPhoto),
                                Utils.toastMessage(vm.isFavourite(myPhoto) ?"Photo added to my favourites." : "Photo removed from my favourites.")},
                            )
                          ],
                        ),
                        Text(
                          myPhoto.title.toString(),
                          maxLines: 2,
                          softWrap: true,
                          style: const TextStyle( color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                        ),

                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
