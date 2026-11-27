import 'package:material_ui/material_ui.dart';
import '/app_drawer.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      drawer: const AppDrawer(currentRoute: '/'),
     body: Center(
  child: Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Welcome Home',
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) => const ProfileScreen(),
              ),
            );
          },
          child: const Text('OPEN PROFILE'),
        ),
      ],
    ),
  ),
),
    );
  }
} 
