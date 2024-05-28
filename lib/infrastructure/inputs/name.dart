
import 'package:formz/formz.dart';

enum NameError { empty }

class NameInput extends FormzInput<String, NameError> {


  const NameInput.pure() : super.pure('');

  const NameInput.dirty( super.value ) : super.dirty();

  String? get errorMessage {

    if( isValid || isPure ) return null;

    if( displayError == NameError.empty ) return 'Campo requerido';

    return null;

  }

  @override
  NameError? validator(String value) {
    
    if( value.isEmpty || value.trim().isEmpty ) return NameError.empty;

    return null;

  }

}