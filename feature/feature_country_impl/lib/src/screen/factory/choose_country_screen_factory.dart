import 'package:feature_country_api/feature_country_api.dart';
import 'package:feature_country_impl/feature_country_impl.dart';
import 'package:feature_country_impl/src/repository/country_repository.dart';
import 'package:feature_country_impl/src/screen/choose_country/choose_country.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';

class ChooseCountryScreenFactory implements IChooseCountryScreenFactory {
  ChooseCountryScreenFactory({required CountryFeatureDependencies dependencies})
      : _dependencies = dependencies;

  final CountryFeatureDependencies _dependencies;

  @override
  Widget create(void Function(Country country) callback) {
    return MultiProvider(
      providers: <Provider<dynamic>>[
        Provider<ILocalizationManager>(
          create: (BuildContext context) => _dependencies.localizationManager,
        ),
      ],
      child: BlocProvider<ChooseCountryBloc>(
        create: (BuildContext context) => ChooseCountryBloc(
          args: ChooseCountryArgs(callback: callback),
          //todo get from feature component
          countryRepository: const CountryRepository(),
        )..add(const ChooseCountryEvent.init()),
        child: const ChooseCountyPage(),
      ),
    );
  }
}
