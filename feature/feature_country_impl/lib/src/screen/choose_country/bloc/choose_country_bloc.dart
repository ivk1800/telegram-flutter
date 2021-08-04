import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:feature_country_api/feature_country_api.dart';
import 'package:feature_country_impl/src/repository/country_repository.dart';
import 'package:feature_country_impl/src/screen/choose_country/choose_country_args.dart';

import 'choose_country_event.dart';
import 'choose_country_state.dart';

class ChooseCountryBloc extends Bloc<ChooseCountryEvent, ChooseCountryState> {
  ChooseCountryBloc({
    required ChooseCountryArgs args,
    required CountryRepository countryRepository,
  })  : _args = args,
        _countryRepository = countryRepository,
        super(const LoadingState()) {
    _countryRepository
        .getCountries()
        .then((List<Country> value) => emit(DataState(countries: value)));
  }

  final ChooseCountryArgs _args;
  final CountryRepository _countryRepository;

  @override
  Stream<ChooseCountryState> mapEventToState(ChooseCountryEvent event) async* {
    switch (event.runtimeType) {
      case InitEvent:
        {
          final List<Country> countries =
              await _countryRepository.getCountries();
          yield DataState(countries: countries);
          break;
        }
      case ChooseEvent:
        {
          yield const DoneState();
          _args.callback.call((event as ChooseEvent).country);
          break;
        }
    }
  }
}
