import 'package:material_ui/material_ui.dart';

import '../models/random_user.dart';
import '../widgets/user_photo.dart';

class ProfileScreen extends StatelessWidget {
  final RandomUser user;

  const ProfileScreen({
    super.key,
    required this.user,
  });

  Widget info(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF206B4B),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget section(String title, List<Widget> fields) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF206B4B),
              ),
            ),
            const Divider(),
            ...fields,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF206B4B),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Center(
              child: UserPhoto(
                url: user.pictureUrl,
                size: 120,
              ),
            ),

            const SizedBox(height: 15),

            Text(
              user.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Color(0xFF206B4B),
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Generated sample profile',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 25),

            section('Personal Information', [
              info('Name', user.name),
              info('Gender', user.gender),
              info('Date of Birth', user.birthDate),
              info('Age', user.age),
              info('Nationality', user.nationality),
            ]),

            section('Location', [
              info('Street', user.street),
              info('City', user.city),
              info('State', user.state),
              info('Country', user.country),
              info('Postcode', user.postcode),
              info('Timezone', user.timezone),
            ]),

            section('Contact Information', [
              info('Email', user.email),
              info('Phone', user.phone),
              info('Cellphone', user.cell),
            ]),

            section('Account Information', [
              info('Registration Date',
                  user.registrationDate),
              info('Username', user.username),
              info('UUID', user.uuid),
              info('ID Name', user.idName),
              info('ID Value', user.idValue),
            ]),

            const SizedBox(height: 15),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFF206B4B),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(15),
              ),
              child: const Text('GO BACK'),
            ),
          ],
        ),
      ),
    );
  }
}
