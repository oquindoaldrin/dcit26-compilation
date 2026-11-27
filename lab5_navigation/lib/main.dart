import 'package:material_ui/material_ui.dart';

import 'home_screen.dart';
import 'about_screen.dart';

void main() => runApp(const Lab5App());

class Lab5App extends StatelessWidget {
  const Lab5App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 5 - Navigation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF247048)),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF247048),
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF247048),
            foregroundColor: Colors.white,
          ),
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/about': (context) => const AboutScreen(),
      },
    );
  }
}
