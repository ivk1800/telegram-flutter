import 'package:equatable/equatable.dart';
import 'package:feature_country_api/feature_country_api.dart';

abstract class ChooseCountryState extends Equatable {
  const ChooseCountryState();

  @override
  List<Object?> get props => <dynamic>[];
}

class LoadingState extends ChooseCountryState {
  const LoadingState();
}

class DataState extends ChooseCountryState {
  const DataState({required this.countries});

  final List<Country> countries;

  @override
  List<Object> get props => <Object>[countries];
}

class DoneState extends ChooseCountryState {
  const DoneState();
}
