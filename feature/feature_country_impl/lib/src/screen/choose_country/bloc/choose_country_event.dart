import 'package:feature_country_api/feature_country_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'choose_country_event.freezed.dart';

@freezed
@immutable
class ChooseCountryEvent with _$ChooseCountryEvent {
  const factory ChooseCountryEvent.init() = Init;
  const factory ChooseCountryEvent.choose(Country country) = Choose;
}
