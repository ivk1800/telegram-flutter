import 'package:feature_country_api/feature_country_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'choose_country_state.freezed.dart';

@freezed
@immutable
class ChooseCountryState with _$ChooseCountryState {
  const factory ChooseCountryState.loading() = Loading;
  const factory ChooseCountryState.done() = Done;
  const factory ChooseCountryState.data(List<Country> countries) = Data;
}
