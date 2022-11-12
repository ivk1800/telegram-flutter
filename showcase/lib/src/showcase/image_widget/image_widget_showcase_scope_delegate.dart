import 'package:coreui/coreui.dart';
import 'package:scope_generator_annotation/scope_generator_annotation.dart';

@scope
abstract class IImageWidgetShowcaseScopeDelegate {
  ImageWidgetFactory getImageWidgetFactory();
}
