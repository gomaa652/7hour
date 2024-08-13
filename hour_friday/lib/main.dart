import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hour_friday/cubit/player_cubit.dart';
import 'package:hour_friday/firebase_options.dart';
import 'package:hour_friday/screen/football_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Read saved theme mode
  final prefs = await SharedPreferences.getInstance();
  final isDarkMode = prefs.getBool('isDarkMode') ?? true;  // Default to dark mode
  final themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;

  runApp(MyApp(themeMode: themeMode));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.themeMode});

  final ThemeMode themeMode;
  final ValueNotifier<ThemeMode> _themeNotifier = ValueNotifier(ThemeMode.dark);

  @override
  Widget build(BuildContext context) {

    
    _themeNotifier.value = themeMode;

    return ValueListenableBuilder<ThemeMode>(
      valueListenable: _themeNotifier,
      builder: (context, themeMode, _) {
        return BlocProvider(
          create: (context) => PlayerCubit(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: themeMode,
            theme: ThemeData(
              brightness: Brightness.light,
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepPurple,
                brightness: Brightness.light,
              ),
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepPurple,
                brightness: Brightness.dark,
              ),
              useMaterial3: true,
            ),
            home: FootballScreen(
              onThemeChanged: (newMode) {
                _themeNotifier.value = newMode;
                _saveThemeMode(newMode);
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> _saveThemeMode(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = themeMode == ThemeMode.dark;
    await prefs.setBool('isDarkMode', isDarkMode);
  }
}
