import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@immutable
@freezed
class AuthState with _$AuthState {
  const factory AuthState.phoneNumber({
    required bool blockInteraction,
    required String title,
    required String countryTitle,
  }) = PhoneNumberState;

  const factory AuthState.code({
    required bool blockInteraction,
    required String title,
  }) = CodeState;
}
//
// abstract class AuthState extends Equatable {
//   const AuthState({
//     required this.blockInteraction,
//     required this.title,
//   });
//
//   final bool blockInteraction;
//   final String title;
//
//   @override
//   List<Object> get props => <Object>[
//         blockInteraction,
//         title,
//       ];
// }
//
// class PhoneNumberState extends AuthState {
//   const PhoneNumberState({
//     required this.countryTitle,
//     required bool blockInteraction,
//     required String title,
//   }) : super(
//           blockInteraction: blockInteraction,
//           title: title,
//         );
//
//   final String countryTitle;
//
//   @override
//   List<Object> get props =>
//       super.props +
//       <Object>[
//         countryTitle,
//       ];
// }
//
// class CodeState extends AuthState {
//   const CodeState({
//     required bool blockInteraction,
//     required String title,
//   }) : super(
//           blockInteraction: blockInteraction,
//           title: title,
//         );
// }
//
// extension PhoneNumberStateExt on PhoneNumberState {
//   PhoneNumberState copy({
//     String? title,
//     String? countryTitle,
//     bool? blockInteraction,
//     String? phoneNumberMask,
//   }) =>
//       PhoneNumberState(
//         title: title ?? this.title,
//         blockInteraction: blockInteraction ?? this.blockInteraction,
//         countryTitle: countryTitle ?? this.countryTitle,
//       );
// }
//
// extension CodeStateExt on CodeState {
//   CodeState copy({
//     String? title,
//     bool? blockInteraction,
//   }) =>
//       CodeState(
//         title: title ?? this.title,
//         blockInteraction: blockInteraction ?? this.blockInteraction,
//       );
// }
