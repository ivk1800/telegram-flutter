import 'package:feature_country_api/feature_country_api.dart';
import 'package:feature_country_impl/src/screen/choose_country/choose_country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';

class ChooseCountyPage extends StatelessWidget {
  const ChooseCountyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ILocalizationManager localizationManager = Provider.of(context);

    // todo implement search
    // todo add ConnectionState
    // todo implement sticky header for alphabet
    // todo implement fast side a-z scroll
    return Scaffold(
      appBar: AppBar(
        title: Text(localizationManager.getString('ChooseCountry')),
      ),
      body: BlocConsumer<ChooseCountryBloc, ChooseCountryState>(
        listener: (BuildContext context, ChooseCountryState state) {
          if (state is Done) {
            Navigator.of(context).pop();
          }
        },
        builder: (BuildContext context, ChooseCountryState state) {
          if (state is Data) {
            return ListView.builder(
              itemCount: state.countries.length,
              itemBuilder: (BuildContext context, int index) {
                final Country country = state.countries[index];
                return ListTile(
                  onTap: () {
                    context.read<ChooseCountryBloc>().add(
                          ChooseCountryEvent.choose(country),
                        );
                  },
                  title: Text(country.name),
                  trailing: Text(
                    '+${country.code}',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                );
              },
            );
          }

          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
