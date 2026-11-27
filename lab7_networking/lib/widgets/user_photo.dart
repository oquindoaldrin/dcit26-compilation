import 'package:material_ui/material_ui.dart';

class UserPhoto extends StatelessWidget {
  final String url;
  final double size;

  const UserPhoto({
    super.key,
    required this.url,
    this.size = 120,
  });

  @override
  Widget build(BuildContext context) {
    Widget fallback() {
      return Container(
        width: size,
        height: size,
        color: const Color(0xFFE4F1E9),
        child: Icon(
          Icons.person,
          size: size * 0.5,
          color: const Color(0xFF206B4B),
        ),
      );
    }

    return ClipOval(
      child: SizedBox(
        width: size,
        height: size,
        child: url.isEmpty
            ? fallback()
            : Image.network(
                url,
                fit: BoxFit.cover,
                loadingBuilder: (
                  context,
                  child,
                  loadingProgress,
                ) {
                  if (loadingProgress == null) {
                    return child;
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                errorBuilder: (
                  context,
                  error,
                  stackTrace,
                ) {
                  return fallback();
                },
              ),
      ),
    );
  }
}
