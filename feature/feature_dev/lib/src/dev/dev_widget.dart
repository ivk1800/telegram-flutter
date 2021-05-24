import 'package:feature_dev/feature_dev.dart';
import 'package:feature_dev/src/di/dev_component.dart';
import 'package:feature_dev/src/di/dev_component.jugger.dart';
import 'package:flutter/material.dart';

class DevWidget extends StatefulWidget {
  const DevWidget({
    Key? key,
    required this.child,
    required this.devFeature,
  }) : super(key: key);

  final Widget child;
  final DevFeature devFeature;

  @override
  DevWidgetState createState() => DevWidgetState();

  static DevWidgetState of(BuildContext context) =>
      context.findRootAncestorStateOfType<DevWidgetState>()!;
}

class DevWidgetState extends State<DevWidget> {
  DevFeature get devFeature => widget.devFeature;

  late DevComponent _devComponent;
  DevComponent get devComponent => _devComponent;

  @override
  void initState() {
    _devComponent = JuggerDevComponentBuilder().devFeature(devFeature).build();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
