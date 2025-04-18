import 'package:flutter/material.dart';
import 'package:note_vault/view/photos_list.dart';
import 'package:note_vault/view/widget/no_internet_screen.dart';
import 'package:note_vault/view_model/network_status_provider.dart';
import 'package:provider/provider.dart';
import '../view_model/note_provider.dart';
import 'add_note_screen.dart';
import '../view_model/theme_provider.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("My Notes"),
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      body: Consumer<NetworkStatusProvider>(
        builder: (context, network, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                network.isOnline
                    ? Consumer<NoteProvider>(
                      builder: (context, provider, child) {
                        return provider.notes.isNotEmpty
                            ? GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                  ),
                              itemCount: provider.notes.length,
                              itemBuilder: (context, index) {
                                final note = provider.notes[index];
                                return Card(
                                  color: themeProvider.isDarkMode ? Colors.deepPurpleAccent : Colors.purple.shade50,
                                  elevation: 2,
                                  margin: EdgeInsets.all(4.0),
                                  child: ListTile(
                                    title: Text(note.title!),
                                    subtitle: Text(note.description!),
                                  ),
                                );
                              },
                            )
                            : Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(16.0),
                              height: MediaQuery.of(context).size.height,
                              // Ensures pull-to-refresh gesture works
                              child: const Text(
                                "No Notes added yet.",
                                maxLines: 2,
                                softWrap: true,
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            );
                      },
                    )
                    : NoInternetScreen(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_note');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
