import 'dart:convert';

class Country {
  final List callingCodes;
  final String flags;
  final String name;
  Country({
    required this.callingCodes,
    required this.flags,
    required this.name,
  });

  factory Country.fromMap(Map<String, dynamic> map) {
    return Country(
      callingCodes: map['callingCodes'] ?? '',
      flags: map['flags']['png'] ?? 'https://flagcdn.com/no.svg',
      name: map['name'] ?? '',
    );
  }

  factory Country.fromJson(String source) =>
      Country.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Country &&
        other.callingCodes == callingCodes &&
        other.flags == flags &&
        other.name == name;
  }

  @override
  int get hashCode => callingCodes.hashCode ^ flags.hashCode ^ name.hashCode;
}
