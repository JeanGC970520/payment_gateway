
import 'package:formz/formz.dart';

enum StateError { empty, format }

class StateInput extends FormzInput<String, StateError> {
  
  static final RegExp stateCode = RegExp(r'^[A-Za-z]{2}$');

  const StateInput.pure() : super.pure('');

  const StateInput.dirty(super.value) : super.dirty();

  String? get errorMessage {

    if( isValid || isPure ) return null;

    if( displayError == StateError.empty ) return 'Campo requerido';

    if( displayError == StateError.format ) return 'Formato invalido';

    return null;

  }

  @override
  StateError? validator(String value) {
    
    if( value.trim().isEmpty ) return StateError.empty;

    if( !stateCode.hasMatch(value) ) return StateError.format;

    return null;
  }
}