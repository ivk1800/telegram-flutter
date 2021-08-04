import 'package:equatable/equatable.dart';
import 'package:feature_country_api/feature_country_api.dart';

abstract class ChooseCountryEvent extends Equatable {
  const ChooseCountryEvent();

  @override
  List<Object> get props => <Object>[];
}

class InitEvent extends ChooseCountryEvent {
  const InitEvent();
}

class ChooseEvent extends ChooseCountryEvent {
  const ChooseEvent({required this.country});

  final Country country;
}
