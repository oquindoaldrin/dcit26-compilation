import 'package:material_ui/material_ui.dart';

import 'app_drawer.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      drawer: const AppDrawer(currentRoute: '/about'),
      body: Center(
        child: Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
            const Text('About this app', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 8),
            const Text('A separate screen on a distinct route.'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context,
                '/',
                (route) => false,
              ),
              child: const Text('GO HOME'),
            ),
          ],
        ),
      ),
      )
    );
  }
}
