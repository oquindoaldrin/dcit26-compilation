import 'package:material_ui/material_ui.dart';

class AppDrawer extends StatelessWidget {
  final String currentRoute;
  const AppDrawer({super.key, required this.currentRoute});

  void _go(BuildContext context, String route) {
    Navigator.pop(context);
    if (route == currentRoute) return;
    Navigator.pushNamedAndRemoveUntil(
      context,
      route,
      (r) => route == '/' ? false : r.isFirst,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF247048)),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text('Lab 5 - Navigation',
                  style: TextStyle(color: Colors.white, fontSize: 22)),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            selected: currentRoute == '/',
            onTap: () => _go(context, '/'),
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            selected: currentRoute == '/about',
            onTap: () => _go(context, '/about'),
          ),
        ],
      ),
    );
  }
}
