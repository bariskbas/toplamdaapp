import 'package:xapp/core/const.dart';
import 'package:xapp/core/dtos/currencies.dart';
import 'package:xapp/core/dtos/currency_response_dto.dart';
import 'package:xapp/core/services/currency_services.dart';

class AllCurrencyRepository {
  final CurrencyServices currencyServices = CurrencyServices();

  Future<CurrentAssets> getAllCurrency() async {
    final AllCurrencyResponseDTO data =
        await currencyServices.getAllCurrencyPrices();
    CurrentAssets currentAssets =
        CurrentAssets(assetsTitle: "DÖVİZ", svgPath: AppConst.dovizIcon);
    if (data.success!) {
      currentAssets.currencies =
          data.result!.map((e) => Currency.fromCurrency(e)).toList();
    }

    return currentAssets;
  }
}
