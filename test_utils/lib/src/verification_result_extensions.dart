import 'package:mockito/mockito.dart';

extension VerificationResultExt on VerificationResult {
  T capturedSingle<T>() => captured.single as T;
}
