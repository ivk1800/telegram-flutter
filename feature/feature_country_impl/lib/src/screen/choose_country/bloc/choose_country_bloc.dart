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
        super(const ChooseCountryState.loading()) {
    _init();
  }

  final ChooseCountryArgs _args;
  final CountryRepository _countryRepository;

  void _init() {
    on<Init>((Init event, Emitter<ChooseCountryState> emit) async {
      final List<Country> countries = await _countryRepository.getCountries();
      emit(ChooseCountryState.data(countries));
    });
    on<Choose>((Choose event, Emitter<ChooseCountryState> emit) {
      // TODO: close screen through router
      emit(const ChooseCountryState.done());
      _args.callback.call(event.country);
    });
  }
}
