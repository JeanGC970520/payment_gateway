
import 'package:formz/formz.dart';

enum ZipcodeError { empty, format }

class Zipcode extends FormzInput<String, ZipcodeError> {

  static final RegExp zipcodeRegex = RegExp(r'^\d{5}$');
  
  const Zipcode.pure() : super.pure('');

  const Zipcode.dirty(super.value) : super.dirty();

  String? get errorMessage {

    if( displayError == ZipcodeError.empty ) return 'Campo requerido';

    if( displayError == ZipcodeError.format ) return 'Formato invalido';

    return null;

  }

  @override
  ZipcodeError? validator(String value) {
    
    if( value.trim().isEmpty ) return ZipcodeError.empty;

    if( !zipcodeRegex.hasMatch(value) ) return ZipcodeError.format;

    return null;

  }
}