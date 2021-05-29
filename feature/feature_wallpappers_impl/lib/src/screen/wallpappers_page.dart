import 'package:coreui/coreui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:localization_api/localization_api.dart';
import 'wallpappers_controller.dart';

class WallpappersPage extends GetView<WallpappersController> {
  const WallpappersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: GetInstance().find<ConnectionStateWidgetFactory>().create(
              context,
              (BuildContext context) => Text(GetInstance()
                  .find<ILocalizationManager>()
                  .getString('ChatBackground'))),
        ),
        body: controller.obx((WallpappersState? state) => LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) =>
                  _buildGridView(state!.backgrounds, constraints.maxWidth),
            )),
      );

  Widget _buildGridView(List<ITileModel> tileModels, double width) {
    final ListAdapter listAdapter = GetInstance().find<ListAdapter>();

    return StaggeredGridView.countBuilder(
        crossAxisCount: CrossAxisCount,
        shrinkWrap: false,
        itemCount: tileModels.length,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        padding: const EdgeInsets.all(10.0),
        itemBuilder: (BuildContext context, int index) =>
            listAdapter.create(context, tileModels[index]),
        staggeredTileBuilder: (int index) {
          return StaggeredTile.extent(2, width / (CrossAxisCount / 2) * 1.5);
        });
  }

  static const int CrossAxisCount = 6;
}
