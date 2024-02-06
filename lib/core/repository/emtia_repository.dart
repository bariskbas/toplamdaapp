import 'package:xapp/core/const.dart';
import 'package:xapp/core/dtos/currencies.dart';
import 'package:xapp/core/dtos/emtia_response_dto.dart';
import 'package:xapp/core/services/emtia_services.dart';

class EmtiaRepository {
  final EmtiaServices emtiaServices = EmtiaServices();

  Future<CurrentAssets> getEmtiaPrices() async {
    final EmtiaResponseDTO data = await emtiaServices.getEmtiaPrices();
    CurrentAssets currentAssets =
        CurrentAssets(assetsTitle: "EMTİA", svgPath: AppConst.emtiaIcon);
    if (data.success!) {
      currentAssets.currencies =
          data.result!.map((e) => Currency.fromEmtia(e)).toList();
    }

    return currentAssets;
  }
}
