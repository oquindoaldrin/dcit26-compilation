import 'package:flutter/material.dart';

import 'app_drawer.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      drawer: const AppDrawer(currentRoute: '/about'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
    );
  }
}
