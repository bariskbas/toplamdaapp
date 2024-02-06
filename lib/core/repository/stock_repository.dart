import 'package:xapp/core/const.dart';
import 'package:xapp/core/dtos/currencies.dart';
import 'package:xapp/core/dtos/stock_response_dto.dart';
import 'package:xapp/core/services/stock_services.dart';

class StockRepository {
  final StockServices stockServices = StockServices();

  Future<CurrentAssets> getStockPrices() async {
    final StockResponseDTO data = await stockServices.getStockPrices();
    CurrentAssets currentAssets =
        CurrentAssets(assetsTitle: "HİSSE SENEDİ", svgPath: AppConst.hisseIcon);
    if (data.success!) {
      currentAssets.currencies =
          data.result!.map((e) => Currency.fromStock(e)).toList();
    }

    return currentAssets;
  }
}
