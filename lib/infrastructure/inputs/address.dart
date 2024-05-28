import 'package:formz/formz.dart';

enum AddressError { empty }

class AddressInput extends FormzInput<String, AddressError> {
  
  const AddressInput.pure() : super.pure('');

  const AddressInput.dirty(super.value) : super.dirty();

  String? get errorMessage {

    if( isValid || isPure ) return null;

    if( displayError == AddressError.empty ) return 'Campo requerido';

    return null;

  }

  @override
  AddressError? validator(String value) {
    
    if( value.trim().isEmpty ) return AddressError.empty;
    
    return null;
  }

}