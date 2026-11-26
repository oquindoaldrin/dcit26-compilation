import 'package:flutter/material.dart';

import 'widgets/sample_modal.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: SampleModal.green),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Modal'),
        backgroundColor: SampleModal.green,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: SampleModal.green,
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            showDialog<void>(
              context: context,
              builder: (context) => const SampleModal(),
            );
          },
          child: const Text('OPEN MODAL'),
        ),
      ),
    );
  }
}
