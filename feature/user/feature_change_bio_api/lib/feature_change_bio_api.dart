library feature_change_bio_api;

import 'package:flutter/widgets.dart';

abstract class IChangeBioFeatureApi {
  IChangeBioScreenFactory get changeBioScreenFactory;
}

abstract class IChangeBioScreenFactory {
  Widget create();
}
