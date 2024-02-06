import 'package:xapp/core/const.dart';
import 'package:xapp/core/dtos/crypto_response_dto.dart';
import 'package:xapp/core/dtos/currencies.dart';
import 'package:xapp/core/services/crypto_services.dart';

class CryptoRepository {
  final CryptoServices cryptoServices = CryptoServices();

  Future<CurrentAssets> getCryptoPrices() async {
    final CryptoResponseDTO data = await cryptoServices.getCryptoPrices();
    CurrentAssets currentAssets =
        CurrentAssets(assetsTitle: "KRİPTO", svgPath: AppConst.bitcoinIcon);
    if (data.success!) {
      currentAssets.currencies =
          data.result!.map((e) => Currency.fromCrypto(e)).toList();
    }

    return currentAssets;
  }
}
