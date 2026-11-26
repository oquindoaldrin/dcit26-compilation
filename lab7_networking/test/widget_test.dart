import 'package:flutter_test/flutter_test.dart';
import 'package:lab7/main.dart';

void main() {
  testWidgets('Random User app builds', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    expect(find.text('Random User'), findsOneWidget);
  });

  test('RandomUser parses API data', () {
    final user = RandomUser.fromJson({
      'name': {'title': 'Ms', 'first': 'Ada', 'last': 'Lovelace'},
      'location': {
        'street': {'number': 1, 'name': 'St James Square'},
        'city': 'London',
        'state': 'England',
        'country': 'United Kingdom',
        'postcode': 'SW1',
        'timezone': {'offset': '+00:00', 'description': 'London'},
      },
      'gender': 'female',
      'email': 'ada@example.com',
      'login': {'username': 'ada', 'uuid': '123'},
      'dob': {'date': '1815-12-10T00:00:00Z', 'age': '211'},
      'registered': {'date': '2020-01-01T00:00:00Z'},
      'phone': '123',
      'cell': '456',
      'id': {'name': 'NINO', 'value': 'AB123'},
      'nat': 'GB',
      'picture': {'large': 'https://example.com/ada.jpg'},
    });

    expect(user.fullName, 'Ms Ada Lovelace');
    expect(user.dob, '1815-12-10');
  });
}
