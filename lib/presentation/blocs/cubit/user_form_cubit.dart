import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:payment_gateway/domain/entities/user.dart';

import '../../../infrastructure/inputs/inputs.dart';

part 'user_form_state.dart';

class UserFormCubit extends Cubit<UserFormState> {
  
  UserFormCubit() : super(const UserFormState());

  void nameChange( String value ) {

    final name = NameInput.dirty(value);
    emit(
      state.copyWith(
        name: name,
        isValid: Formz.validate([
          name, 
          state.address,
          state.city,
          state.stateInput,
          state.country,
          state.zipcode,
        ]),
      )
    );

  }

  void addressChange( String value ) {

    final address = AddressInput.dirty(value);
    emit(
      state.copyWith(
        address: address,
        isValid: Formz.validate([
          state.name,
          address, 
          state.city,
          state.stateInput,
          state.country,
          state.zipcode,
        ]),
      )
    );

  }

  void cityChange( String value ) {

    final city = CityInput.dirty(value);
    emit(
      state.copyWith(
        city: city,
        isValid: Formz.validate([
          state.name,
          state.address,
          city, 
          state.stateInput,
          state.country,
          state.zipcode,
        ]),
      )
    );

  }

  void stateInputChange( String value ) {

    final stateInput = StateInput.dirty(value);
    emit(
      state.copyWith(
        stateInput: stateInput,
        isValid: Formz.validate([
          state.name,
          state.address,
          state.city,
          stateInput, 
          state.country,
          state.zipcode,
        ]),
      )
    );

  }

  void countryChange( String value ) {

    final country = CountryInput.dirty(value);
    emit(
      state.copyWith(
        country: country,
        isValid: Formz.validate([
          state.name,
          state.address,
          state.city,
          state.stateInput,
          country, 
          state.zipcode,
        ]),
      )
    );

  }

  void zipcodeChange( String value ) {

    final zipcode = ZipcodeInput.dirty(value);
    emit(
      state.copyWith(
        zipcode: zipcode,
        isValid: Formz.validate([
          state.name,
          state.address,
          state.city,
          state.stateInput,
          state.country,
          zipcode, 
        ]),
      )
    );

  }

  void onSubmit() {

    emit(
      state.copyWith(
        name: NameInput.dirty(state.name.value),
        address: AddressInput.dirty(state.address.value),
        city: CityInput.dirty(state.city.value),
        stateInput: StateInput.dirty(state.stateInput.value),
        country: CountryInput.dirty(state.country.value),
        zipcode: ZipcodeInput.dirty(state.zipcode.value),
        isValid: Formz.validate([
          state.name,
          state.address,
          state.city,
          state.stateInput,
          state.country,
          state.zipcode,
        ])
      )
    );

  }

  User getUser() {
    return User(
      name: state.name.value, 
      address: state.address.value, 
      city: state.city.value, 
      stateCode: state.stateInput.value, 
      countryCode: state.country.value, 
      zipcode: state.zipcode.value,
    );
  }

}
