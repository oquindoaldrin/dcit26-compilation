class RandomUser {
  final String name;
  final String gender;
  final String email;
  final String street;
  final String city;
  final String state;
  final String country;
  final String postcode;
  final String timezone;
  final String birthDate;
  final String age;
  final String registrationDate;
  final String phone;
  final String cell;
  final String idName;
  final String idValue;
  final String nationality;
  final String username;
  final String uuid;
  final String pictureUrl;

  const RandomUser({
    required this.name,
    required this.gender,
    required this.email,
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.postcode,
    required this.timezone,
    required this.birthDate,
    required this.age,
    required this.registrationDate,
    required this.phone,
    required this.cell,
    required this.idName,
    required this.idValue,
    required this.nationality,
    required this.username,
    required this.uuid,
    required this.pictureUrl,
  });

  factory RandomUser.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> map(Object? value) {
      if (value is Map<String, dynamic>) return value;
      return {};
    }

    String raw(Object? value) {
      return value?.toString().trim() ?? '';
    }

    String display(Object? value) {
      final text = raw(value);
      return text.isEmpty ? 'Not provided' : text;
    }

    String date(Object? value) {
      final text = raw(value);
      if (text.isEmpty) return 'Not provided';
      return text.split('T').first;
    }

    final nameData = map(json['name']);
    final location = map(json['location']);
    final streetData = map(location['street']);
    final timezoneData = map(location['timezone']);
    final dob = map(json['dob']);
    final registered = map(json['registered']);
    final id = map(json['id']);
    final login = map(json['login']);
    final picture = map(json['picture']);

    final fullName = [
      raw(nameData['title']),
      raw(nameData['first']),
      raw(nameData['last']),
    ].where((part) => part.isNotEmpty).join(' ');

    final fullStreet = [
      raw(streetData['number']),
      raw(streetData['name']),
    ].where((part) => part.isNotEmpty).join(' ');

    final fullTimezone = [
      raw(timezoneData['offset']),
      raw(timezoneData['description']),
    ].where((part) => part.isNotEmpty).join(' - ');

    return RandomUser(
      name: display(fullName),
      gender: display(json['gender']),
      email: display(json['email']),
      street: display(fullStreet),
      city: display(location['city']),
      state: display(location['state']),
      country: display(location['country']),
      postcode: display(location['postcode']),
      timezone: display(fullTimezone),
      birthDate: date(dob['date']),
      age: display(dob['age']),
      registrationDate: date(registered['date']),
      phone: display(json['phone']),
      cell: display(json['cell']),
      idName: display(id['name']),
      idValue: display(id['value']),
      nationality: display(json['nat']),
      username: display(login['username']),
      uuid: display(login['uuid']),
      pictureUrl: raw(
        picture['large'] ?? picture['medium'],
      ),
    );
  }
}
