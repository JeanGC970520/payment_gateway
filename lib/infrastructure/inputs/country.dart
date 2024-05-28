import 'package:formz/formz.dart';

enum CountryError { empty, format }

class CountryInput extends FormzInput<String, CountryError> {

  static final RegExp countryCode = RegExp(r'^[A-Za-z]{2}$');

  const CountryInput.pure() : super.pure('');

  const CountryInput.dirty(super.value) : super.dirty();

  String? get errorMessage {

    if( displayError == CountryError.empty ) return 'Campo requerido';

    if( displayError == CountryError.format ) return 'Formato invalido';

    return null;

  }

  @override
  CountryError? validator(String value) {
    
    if( value.trim().isEmpty ) return CountryError.empty;

    if( !countryCode.hasMatch(value) ) return CountryError.format;
    
    return null;
  }
}