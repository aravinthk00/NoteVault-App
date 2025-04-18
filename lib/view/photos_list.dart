import 'package:flutter/material.dart';
import 'package:note_vault/view/widget/photo_list_tile.dart';
import 'package:note_vault/view/widget/no_internet_screen.dart';
import 'package:note_vault/view_model/photos_provider.dart';
import 'package:provider/provider.dart';
import '../../view_model/network_status_provider.dart';
import '../view_model/theme_provider.dart';

class PhotosListScreen extends StatefulWidget {
  const PhotosListScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PhotosListScreenState();
}

class _PhotosListScreenState extends State<PhotosListScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    final photoProvider = Provider.of<PhotosProvider>(context, listen: false);
    photoProvider.fetchPhotos();

    _scrollController =
        ScrollController()..addListener(() {
          if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200) {
            photoProvider.fetchPhotos();
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 35,
              height: 35,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Center(
                    child: Image.asset(
                      'assets/icon/icon.jpg',
                      fit: BoxFit.cover,
                      width: 30,
                      height: 30,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
                  "Photos",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: themeProvider.isDarkMode ? Colors.black : Colors.white,
                  ),
                ),
                Row(
                  children: [
                    const Text(
                      "Photos : ",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Consumer<PhotosProvider>(
                      builder: (context, provider, child) {
                        if (provider.isLoading) {
                          return const Text(
                            "00",
                            style: TextStyle(fontSize: 10),
                          );
                        }

                        return Text(
                          provider.myPhotosList.length.toString(),
                          style: const TextStyle(fontSize: 10),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: Consumer<NetworkStatusProvider>(
        builder: (context, network, child) {
          if (!network.isOnline) {
            return NoInternetScreen();
          }

          return Consumer<PhotosProvider>(
            builder: (context, provider, child) {

              if(provider.isLoading){
                return Center(child: CircularProgressIndicator(color: Colors.blueAccent,),);
              }

              return RefreshIndicator(
                color: Colors.blueAccent,
                onRefresh: () async => provider.fetchPhotos(),
                child: provider.myPhotosList.isNotEmpty
                        ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              mainAxisExtent: 250,

                            ),
                            controller: _scrollController,
                            itemCount:
                                provider.myPhotosList.length +
                                (provider.hasMore ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index < provider.myPhotosList.length) {
                                final photo = provider.myPhotosList[index];
                                return BookTileWidget(
                                  myPhoto: photo,
                                  index: index,
                                );
                              } else {
                                return Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                            },
                          ),
                        )
                        : SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          // Required for scroll even when content is small
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(16.0),
                            height: MediaQuery.of(context).size.height,
                            // Ensures pull-to-refresh gesture works
                            child: const Text(
                              "No data available. Please refresh the screen or try again later!!",
                              maxLines: 2,
                              softWrap: true,
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
