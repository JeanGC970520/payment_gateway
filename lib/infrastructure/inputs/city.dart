

import 'package:formz/formz.dart';

enum CityError { empty }

class CityInput extends FormzInput<String, CityError> {
  
  const CityInput.pure() : super.pure('');

  const CityInput.dirty(super.value) : super.dirty();

  String? get errorMessage {

    if( isValid || isPure ) return null;

    if( displayError == CityError.empty ) return 'Campo requerido';

    return null;
  }

  @override
  CityError? validator(String value) {
    
    if( value.trim().isEmpty ) return CityError.empty;
    
    return null;
  }
}