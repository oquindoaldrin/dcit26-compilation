import 'dart:async';
import 'dart:convert';

import 'package:material_ui/material_ui.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

const kGreen = Color(0xFF1B6B3A);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 7 - Networking',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: kGreen),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: kGreen,
          foregroundColor: Colors.white,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

/// Small typed model. Credential fields (password, salt, md5, sha1, sha256)
/// are intentionally never read.
class RandomUser {
  final String title, first, last, gender, email, username, uuid;
  final String street, city, state, country, postcode, timezone;
  final String dob, age, registered, phone, cell;
  final String idName, idValue, nationality, picture;

  RandomUser({
    required this.title,
    required this.first,
    required this.last,
    required this.gender,
    required this.email,
    required this.username,
    required this.uuid,
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.postcode,
    required this.timezone,
    required this.dob,
    required this.age,
    required this.registered,
    required this.phone,
    required this.cell,
    required this.idName,
    required this.idValue,
    required this.nationality,
    required this.picture,
  });

  String get fullName =>
      [title, first, last].where((s) => s.isNotEmpty).join(' ');
  String get shortName => [first, last].where((s) => s.isNotEmpty).join(' ');

  static String _s(dynamic v) => v == null ? '' : v.toString();

  static Map<String, dynamic> _m(dynamic v) =>
      v is Map<String, dynamic> ? v : <String, dynamic>{};

  static String _date(dynamic v) {
    final s = _s(v);
    return s.length >= 10 ? s.substring(0, 10) : s;
  }

  factory RandomUser.fromJson(Map<String, dynamic> j) {
    final name = _m(j['name']);
    final loc = _m(j['location']);
    final street = _m(loc['street']);
    final tz = _m(loc['timezone']);
    final login = _m(j['login']);
    final dob = _m(j['dob']);
    final reg = _m(j['registered']);
    final id = _m(j['id']);
    final pic = _m(j['picture']);

    final streetText = [
      _s(street['number']),
      _s(street['name']),
    ].where((s) => s.isNotEmpty).join(' ');
    final tzText = [
      _s(tz['offset']),
      _s(tz['description']),
    ].where((s) => s.isNotEmpty).join(' - ');

    return RandomUser(
      title: _s(name['title']),
      first: _s(name['first']),
      last: _s(name['last']),
      gender: _s(j['gender']),
      email: _s(j['email']),
      username: _s(login['username']),
      uuid: _s(login['uuid']),
      street: streetText,
      city: _s(loc['city']),
      state: _s(loc['state']),
      country: _s(loc['country']),
      postcode: _s(loc['postcode']),
      timezone: tzText,
      dob: _date(dob['date']),
      age: _s(dob['age']),
      registered: _date(reg['date']),
      phone: _s(j['phone']),
      cell: _s(j['cell']),
      idName: _s(id['name']),
      idValue: _s(id['value']),
      nationality: _s(j['nat']),
      picture: _s(pic['large']),
    );
  }
}

Future<RandomUser> fetchRandomUser() async {
  final response = await http
      .get(Uri.parse('https://randomuser.me/api/'))
      .timeout(const Duration(seconds: 15));
  if (response.statusCode != 200) {
    throw Exception('Failed to load user');
  }
  final data = jsonDecode(response.body) as Map<String, dynamic>;
  final results = data['results'] as List<dynamic>?;
  if (results == null || results.isEmpty) {
    throw const FormatException('No user data returned');
  }
  final user = results.first as Map<String, dynamic>;
  return RandomUser.fromJson(user);
}

/// Circular network image with loading indicator and error fallback.
class UserAvatar extends StatelessWidget {
  final String url;
  final double radius;
  const UserAvatar({super.key, required this.url, required this.radius});

  @override
  Widget build(BuildContext context) {
    final size = radius * 2;
    return ClipOval(
      child: SizedBox(
        width: size,
        height: size,
        child: url.isEmpty
            ? _fallback()
            : Image.network(
                url,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stack) => _fallback(),
              ),
      ),
    );
  }

  Widget _fallback() => Container(
    color: Colors.grey.shade300,
    child: const Icon(Icons.broken_image_outlined, size: 40),
  );
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RandomUser? _user;
  bool _loading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load(); // request once on init, NOT inside build()
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final user = await fetchRandomUser();
      if (!mounted) return;
      setState(() => _user = user);
    } on TimeoutException {
      if (!mounted) return;
      setState(() => _error = 'The request timed out. Check your connection.');
    } on FormatException {
      if (!mounted) return;
      setState(() => _error = 'The server returned unexpected data.');
    } catch (_) {
      if (!mounted) return;
      setState(
        () => _error = 'Could not load user. Check your internet connection.',
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Random User')),
      body: Center(
        child: Padding(padding: const EdgeInsets.all(24), child: _buildBody()),
      ),
    );
  }

  Widget _buildBody() {
    if (_loading && _user == null) {
      return const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Loading user...'),
        ],
      );
    }

    if (_error != null && _user == null) {
      return _ErrorView(message: _error!, onRetry: _load);
    }

    final user = _user!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () => Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => ProfileScreen(user: user))),
          child: Hero(
            tag: user.uuid,
            child: UserAvatar(url: user.picture, radius: 64),
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Tap the picture to view profile',
          style: TextStyle(fontSize: 12, color: Colors.black54),
        ),
        const SizedBox(height: 16),
        Text(
          user.shortName,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        if (user.email.isNotEmpty)
          Text(user.email, style: const TextStyle(color: Colors.black54)),
        const SizedBox(height: 24),
        if (_error != null) ...[
          Text(_error!, style: const TextStyle(color: Colors.red)),
          const SizedBox(height: 12),
        ],
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            style: FilledButton.styleFrom(backgroundColor: kGreen),
            onPressed: _loading ? null : _load,
            child: _loading
                ? const SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Text('NEW USER'),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Generated sample data - not a real person.',
          style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic),
        ),
      ],
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.wifi_off, size: 56, color: Colors.red),
        const SizedBox(height: 12),
        Text(message, textAlign: TextAlign.center),
        const SizedBox(height: 16),
        FilledButton.icon(
          style: FilledButton.styleFrom(backgroundColor: kGreen),
          onPressed: onRetry,
          icon: const Icon(Icons.refresh),
          label: const Text('Retry'),
        ),
      ],
    );
  }
}

class ProfileScreen extends StatelessWidget {
  final RandomUser user; // exact user shown on Home, never refetched
  const ProfileScreen({super.key, required this.user});

  String _orDash(String v) => v.trim().isEmpty ? 'Not provided' : v;

  String get _location {
    final parts = [
      user.street,
      user.city,
      user.state,
      user.country,
      user.postcode,
    ].where((s) => s.trim().isNotEmpty).toList();
    return parts.isEmpty ? 'Not provided' : parts.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: Hero(
              tag: user.uuid,
              child: UserAvatar(url: user.picture, radius: 60),
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: Text(
              _orDash(user.fullName),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 4),
          const Center(
            child: Text(
              'Generated sample data - not a real person.',
              style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic),
            ),
          ),
          const SizedBox(height: 16),
          _section('Account', [
            _row(Icons.account_circle, 'Username', user.username),
            _row(Icons.fingerprint, 'UUID', user.uuid),
          ]),
          _section('Personal', [
            _row(Icons.person, 'Gender', user.gender),
            _row(
              Icons.cake,
              'Date of birth',
              user.dob.isEmpty ? '' : '${user.dob} (age ${user.age})',
            ),
            _row(Icons.flag, 'Nationality', user.nationality),
            _row(
              Icons.badge,
              'ID',
              [user.idName, user.idValue].where((s) => s.isNotEmpty).join(': '),
            ),
            _row(Icons.event, 'Registered', user.registered),
          ]),
          _section('Contact', [
            _row(Icons.email, 'Email', user.email),
            _row(Icons.phone, 'Phone', user.phone),
            _row(Icons.smartphone, 'Cell', user.cell),
          ]),
          _section('Location', [
            _row(
              Icons.location_on,
              'Address',
              _location == 'Not provided' ? '' : _location,
            ),
            _row(Icons.schedule, 'Timezone', user.timezone),
          ]),
        ],
      ),
    );
  }

  Widget _section(String title, List<Widget> rows) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: kGreen,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const Divider(),
            ...rows,
          ],
        ),
      ),
    );
  }

  Widget _row(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: kGreen),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
                Text(_orDash(value)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
