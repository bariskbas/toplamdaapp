import 'package:get/get.dart';
import 'package:xapp/core/services/assets_services.dart';

class HomeModelView extends GetxController {
  final AssetsServices assetsServices = AssetsServices();

  Rx<int> selectedBody = 0.obs;
  Rx<int> varlikTabIndex = 0.obs;
  Rx<bool> infoIsVisible = true.obs;

  onChangeBody(index) => selectedBody.value = index;
  onChangeVarlikTab(index) => varlikTabIndex.value = index;

  onChangeVisible() => infoIsVisible.value = !infoIsVisible.value;
}
