import 'dart:convert';

import 'package:material_ui/material_ui.dart';
import 'package:http/http.dart' as http;

import '../models/random_user.dart';
import '../widgets/user_photo.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RandomUser? _user;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  Future<void> _fetchUser() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final response = await http
          .get(
            Uri.parse('https://randomuser.me/api/'),
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode != 200) {
        throw Exception('Failed to load user');
      }

      final data =
          jsonDecode(response.body) as Map<String, dynamic>;

      final results = data['results'] as List<dynamic>?;

      if (results == null || results.isEmpty) {
        throw const FormatException(
          'No user data returned',
        );
      }

      final userData =
          results.first as Map<String, dynamic>;

      final newUser = RandomUser.fromJson(userData);

      if (!mounted) return;

      setState(() {
        _user = newUser;
        _loading = false;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _loading = false;
        _error =
            'Unable to load a user. '
            'Check your internet connection and try again.';
      });
    }
  }

  Widget _buildContent() {
    if (_loading) {
      return const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 15),
          Text('Loading user...'),
        ],
      );
    }

    if (_error != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.wifi_off,
            size: 55,
            color: Colors.redAccent,
          ),

          const SizedBox(height: 15),

          Text(
            _error!,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: _fetchUser,
            child: const Text('RETRY'),
          ),
        ],
      );
    }

    final user = _user;

    if (user == null) {
      return const Text('No user available.');
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ProfileScreen(user: user),
              ),
            );
          },
          child: UserPhoto(
            url: user.pictureUrl,
            size: 130,
          ),
        ),

        const SizedBox(height: 20),

        Text(
          user.name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF206B4B),
          ),
        ),

        const SizedBox(height: 8),

        Text(
          user.email,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),

        const SizedBox(height: 12),

        const Text(
          'Tap the picture to view profile',
          style: TextStyle(fontSize: 13),
        ),

        const SizedBox(height: 25),

        SizedBox(
          width: 200,
          child: ElevatedButton(
            onPressed: _fetchUser,
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  const Color(0xFF206B4B),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(15),
            ),
            child: const Text('NEW USER'),
          ),
        ),

        const SizedBox(height: 15),

        const Text(
          'Generated sample data',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Random User',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF206B4B),
      ),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: _buildContent(),
          ),
        ),
      ),
    );
  }
}
