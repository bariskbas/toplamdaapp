import 'package:xapp/core/dtos/gold_response_dto.dart';
import 'package:xapp/core/services/base_services.dart';

class GoldServices extends BaseService {
  Future<GoldResponseDTO> getGoldPrices() async {
    final headers = {
      "Content-Type": "application/json",
      "authorization": "apikey 13ZBlhNLmHPZ4vwus5fPNx:1Gw0R9Dim9Z0ITHo72bwaj"
    };
    return await getRequest(
      "https://api.collectapi.com/economy/goldPrice",
      headers,
      GoldResponseDTO(),
    );
  }
}
