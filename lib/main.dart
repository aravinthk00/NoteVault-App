import 'package:flutter/material.dart';
import 'package:note_vault/utils/theme.dart';
import 'package:note_vault/view/add_note_screen.dart';
import 'package:note_vault/view/photos_list.dart';
import 'package:note_vault/view/favourites.dart';
import 'package:note_vault/view/note_screen.dart';
import 'package:note_vault/view/navigation_screen.dart';
import 'package:note_vault/view_model/network_status_provider.dart';
import 'package:note_vault/view_model/note_provider.dart';
import 'package:note_vault/view_model/photos_provider.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'model/note.dart';
import 'view_model/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());

  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NetworkStatusProvider()),
        ChangeNotifierProvider(create: (_) => PhotosProvider()),
        ChangeNotifierProvider(create: (_) => NoteProvider()..loadNotes()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Note Vault',
            themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            initialRoute: '/',
            routes: {
              '/': (context) => MainNavigation(),
              '/notes': (context) => const NotesScreen(),
              '/add_note': (context) => const AddNoteScreen(),
              '/photos': (context) => PhotosListScreen(),
              '/favourites': (context) => FavouritesScreen()
            },
          );
        },
      ),
    );
  }
}
