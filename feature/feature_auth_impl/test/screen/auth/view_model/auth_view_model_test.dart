/*
// TODO restore tests
// @dart=2.9

import 'package:auth_manager_api/auth_manager_api.dart';
import 'package:error_transformer_api/error_transformer_api.dart';
import 'package:feature_auth_impl/src/auth_feature_router.dart';
import 'package:feature_auth_impl/src/screen/auth/view_model/auth_view_model.dart';
import 'package:feature_country_api/feature_country_api.dart';
import 'package:localization_api/localization_api.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'auth_view_model_test.mocks.dart';

@GenerateMocks(
  <Type>[],
  customMocks: <MockSpec<dynamic>>[
    MockSpec<IStringsProvider>(),
    MockSpec<IAuthFeatureRouter>(),
    MockSpec<ICountryRepository>(),
    MockSpec<IAuthenticationManager>(),
    MockSpec<IErrorTransformer>(),
  ],
)
void main() {
  AuthViewModel viewModel;
  MockIStringsProvider mockStringsProvider;
  MockIAuthFeatureRouter mockAuthFeatureRouter;
  MockICountryRepository mockCountryRepository;
  MockIAuthenticationManager mockAuthenticationManager;
  MockIErrorTransformer mockErrorTransformer;

  setUp(() {
    mockStringsProvider = MockIStringsProvider();
    mockAuthFeatureRouter = MockIAuthFeatureRouter();
    mockCountryRepository = MockICountryRepository();
    mockAuthenticationManager = MockIAuthenticationManager();

    viewModel = AuthViewModel(
      errorTransformer: mockErrorTransformer,
      stringsProvider: mockStringsProvider,
      router: mockAuthFeatureRouter,
      countryRepository: mockCountryRepository,
      authenticationManager: mockAuthenticationManager,
    );
  });

  test('should navigate to choose country', () async {
    viewModel.onChangeCountryTap();
    verify(mockAuthFeatureRouter.toChooseCountry(any)).called(1);
  });

  // TODO: add more tests
}
*/
