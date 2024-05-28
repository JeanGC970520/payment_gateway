part of 'user_form_cubit.dart';

class UserFormState extends Equatable {
  const UserFormState({
    this.isValid = false,
    this.name = const NameInput.pure(),
    this.address = const AddressInput.pure(), 
    this.city = const CityInput.pure(), 
    this.stateInput = const StateInput.pure(), 
    this.country = const CountryInput.pure(), 
    this.zipcode = const ZipcodeInput.pure(), 
  });

  final bool isValid;
  final NameInput name;
  final AddressInput address;
  final CityInput city;
  final StateInput stateInput;
  final CountryInput country;
  final ZipcodeInput zipcode;

  @override
  List<Object> get props => [ isValid, name, address, city, stateInput, country, zipcode ];

  UserFormState copyWith({
    bool? isValid,
    NameInput? name,
    AddressInput? address,
    CityInput? city,
    StateInput? stateInput,
    CountryInput? country,
    ZipcodeInput? zipcode,
  }) {
    return UserFormState(
      isValid: isValid ?? this.isValid,
      name: name ?? this.name,
      address: address ?? this.address,
      city: city ?? this.city,
      stateInput: stateInput ?? this.stateInput,
      country: country ?? this.country,
      zipcode: zipcode ?? this.zipcode,     
    );
  }
}

