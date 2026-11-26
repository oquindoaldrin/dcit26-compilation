import 'package:flutter/material.dart';

class SampleModal extends StatelessWidget {
  const SampleModal({super.key});

  static const Color green = Color(0xFF1B6B3A);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: green,
              padding: const EdgeInsets.all(12),
              child: const Text(
                'SampleModal',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/images/sample_modal_image.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Long text in a scrollable area. The body continues '
                      'beyond the visible section so users can scroll. '
                      'Keep the close action below it.\n\n'
                      'Lorem ipsum dolor sit amet, consectetur adipiscing '
                      'elit. Sed do eiusmod tempor incididunt ut labore et '
                      'dolore magna aliqua. Ut enim ad minim veniam, quis '
                      'nostrud exercitation ullamco laboris nisi ut aliquip '
                      'ex ea commodo consequat.\n\n'
                      'Duis aute irure dolor in reprehenderit in voluptate '
                      'velit esse cillum dolore eu fugiat nulla pariatur. '
                      'Excepteur sint occaecat cupidatat non proident, sunt '
                      'in culpa qui officia deserunt mollit anim id est '
                      'laborum.',
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: green,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('CLOSE'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
