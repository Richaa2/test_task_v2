import 'dart:convert';

class Country {
  final List callingCodes;
  final String flag;
  final String name;
  Country({
    required this.callingCodes,
    required this.flag,
    required this.name,
  });

  factory Country.fromMap(Map<String, dynamic> map) {
    return Country(
      callingCodes: map['callingCodes'] ?? '',
      flag: map['flag'] ?? '',
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
        other.flag == flag &&
        other.name == name;
  }

  @override
  int get hashCode => callingCodes.hashCode ^ flag.hashCode ^ name.hashCode;
}
