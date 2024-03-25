import 'package:xapp/core/dtos/crypto_response_dto.dart';
import 'package:xapp/core/services/base_services.dart';

class CryptoServices extends BaseService {
  Future<CryptoResponseDTO> getCryptoPrices() async {
    final headers = {
      "Content-Type": "application/json",
      "authorization": "apikey 13ZBlhNLmHPZ4vwus5fPNx:1Gw0R9Dim9Z0ITHo72bwaj"
    };
    return await getRequest(
      "https://api.collectapi.com/economy/cripto",
      headers,
      CryptoResponseDTO(),
    );
  }
}
//geri dönüş datası
// https://coinicons-api.vercel.app/api/icon/btc