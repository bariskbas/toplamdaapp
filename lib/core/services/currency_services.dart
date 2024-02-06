import 'package:xapp/core/dtos/currency_response_dto.dart';
import 'package:xapp/core/services/base_services.dart';

class CurrencyServices extends BaseService {
  Future<AllCurrencyResponseDTO> getAllCurrencyPrices() async {
    final headers = {
      "Content-Type": "application/json",
      "authorization": "apikey 13ZBlhNLmHPZ4vwus5fPNx:1Gw0R9Dim9Z0ITHo72bwaj"
    };
    return await getRequest(
      "https://api.collectapi.com/economy/allCurrency",
      headers,
      AllCurrencyResponseDTO(),
    );
  }
}
