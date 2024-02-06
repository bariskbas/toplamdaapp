import 'package:xapp/core/const.dart';
import 'package:xapp/core/dtos/currencies.dart';
import 'package:xapp/core/dtos/gold_response_dto.dart';
import 'package:xapp/core/services/gold_services.dart';

class GoldRepository {
  final GoldServices goldServices = GoldServices();

  Future<CurrentAssets> getGoldPrices() async {
    final GoldResponseDTO data = await goldServices.getGoldPrices();
    CurrentAssets currentAssets =
        CurrentAssets(assetsTitle: "GOLD", svgPath: AppConst.altinIcon);
    if (data.success!) {
      currentAssets.currencies =
          data.result!.map((e) => Currency.fromGold(e)).toList();
    }

    return currentAssets;
  }
}
