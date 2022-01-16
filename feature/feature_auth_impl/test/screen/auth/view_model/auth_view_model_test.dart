// @dart=2.9

import 'package:auth_manager_api/auth_manager_api.dart';
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
    MockSpec<ILocalizationManager>(returnNullOnMissingStub: true),
    MockSpec<IAuthFeatureRouter>(returnNullOnMissingStub: true),
    MockSpec<ICountryRepository>(returnNullOnMissingStub: true),
    MockSpec<IAuthenticationManager>(returnNullOnMissingStub: true),
  ],
)
void main() {
  AuthViewModel viewModel;
  MockILocalizationManager mockLocalizationManager;
  MockIAuthFeatureRouter mockAuthFeatureRouter;
  MockICountryRepository mockCountryRepository;
  MockIAuthenticationManager mockAuthenticationManager;

  setUp(() {
    mockLocalizationManager = MockILocalizationManager();
    mockAuthFeatureRouter = MockIAuthFeatureRouter();
    mockCountryRepository = MockICountryRepository();
    mockAuthenticationManager = MockIAuthenticationManager();

    viewModel = AuthViewModel(
      localizationManager: mockLocalizationManager,
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
