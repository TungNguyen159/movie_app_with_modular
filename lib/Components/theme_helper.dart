import 'package:movie_app2/app_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

final _appController = Modular.get<AppController>();

String getThemeImagePathWithController({
  required String light,
  required String dark,
}) {
  return _appController.isDarkMode ? dark : light;
}
