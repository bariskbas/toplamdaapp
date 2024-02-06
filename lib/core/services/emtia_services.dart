import 'package:xapp/core/dtos/emtia_response_dto.dart';
import 'package:xapp/core/services/base_services.dart';

class EmtiaServices extends BaseService {
  Future<EmtiaResponseDTO> getEmtiaPrices() async {
    final headers = {
      "Content-Type": "application/json",
      "authorization": "apikey 13ZBlhNLmHPZ4vwus5fPNx:1Gw0R9Dim9Z0ITHo72bwaj"
    };
    return await getRequest(
      "https://api.collectapi.com/economy/emtia",
      headers,
      EmtiaResponseDTO(),
    );
  }
}
