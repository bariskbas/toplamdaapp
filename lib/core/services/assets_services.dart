import 'package:xapp/core/dtos/currencies.dart';
import 'package:xapp/core/services/base_services.dart';

class AssetsServices extends BaseService {
  Future<CurrentAssets> getExchangeData() async {
    final headers = {
      "Content-Type": "application/json",
    };
    return await getRequest(
      "https://api.genelpara.com/embed/para-birimleri.json",
      headers,
      CurrentAssets(),
    );
  }
}
