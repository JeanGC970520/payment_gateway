

class User {

  final String name;
  final String address;
  final String city;
  final String stateCode;
  final String countryCode;
  final String zipcode;

  User({
    required this.name, 
    required this.address, 
    required this.city, 
    required this.stateCode, 
    required this.countryCode, 
    required this.zipcode,
  });

  @override
  String toString() {
    return 'User( $name, $address, $city, $stateCode, $countryCode, $zipcode )';
  }

}