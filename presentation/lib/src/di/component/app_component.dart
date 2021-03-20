import 'package:core/core.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:presentation/src/di/module/app_module.dart';
import 'package:td_client/td_client.dart';
import 'package:presentation/src/page/page.dart';

@j.Component(modules: <Type>[
  AppModule,
])
abstract class AppComponent {
  TdClient getTdClient();

  IChatRepository getChatRepository();

  void injectDialogsState(DialogsPageState state);
}

@j.componentBuilder
abstract class AppComponentBuilder {
  AppComponent build();
}
