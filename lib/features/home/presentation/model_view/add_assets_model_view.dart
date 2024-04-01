import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:xapp/core/dtos/currencies.dart';
import 'package:xapp/core/dtos/user_currency.dart';
import 'package:xapp/core/services/assets_firebase_services.dart';
import 'package:xapp/core/styles.dart';
import 'package:xapp/features/home/presentation/model_view/current_prices_model_view.dart';

class AddAssetsModelView extends GetxController {
  final AssetsFirebaseServices firebaseServices = AssetsFirebaseServices();
  final CurrentPricesModelView _currentPricesModelView = Get.find();
  Rx<Currency> selectedCurrency = Currency(buyingPrice: "0").obs;
  Rx<String> selectedCurrencyPrice = "".obs;
  Rx<String> sumCurrency = "0".obs;
  Rx<bool> isLoading = false.obs;
  Rx<int> amount = 0.obs;
  Rx<CurrentAssets> selectedCurrentAssets = CurrentAssets().obs;
  TextEditingController textEditingController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  setCurrentAssets(CurrentAssets currentAssets) =>
      selectedCurrentAssets.value = currentAssets;

  onChangeAssetType(val) {
    textEditingController.clear();
    sumCurrency.value = "0";
    selectedCurrency.value = val;
    amount.value = 0;
  }

  onChangeAmount(String val) {
    if (val.isNotEmpty) {
      amount.value = int.parse(val);

      if (selectedCurrentAssets.value.assetsTitle == "GOLD") {
        handleGoldPrice(val, selectedCurrency.value.sellingPrice);
      } else if (selectedCurrentAssets.value.assetsTitle == "HİSSE SENEDİ") {
        handleStockPrice(val, selectedCurrency.value.sellingPrice);
      } else if (selectedCurrentAssets.value.assetsTitle == "DÖVİZ") {
        handleStockPrice(val, selectedCurrency.value.sellingPrice);
      } else if (selectedCurrentAssets.value.assetsTitle == "EMTİA") {
        handleEmtiaPrice(val, selectedCurrency.value.sellingPrice);
      } else {
        handleCryptoPrice(val, selectedCurrency.value.sellingPrice);
      }
    } else {
      sumCurrency.value = "0";
    }
  }

  handleGoldPrice(amount, buyingPrice) {
    final oCcy = new NumberFormat("#,##0.00", "tr_TR");
    selectedCurrencyPrice.value = buyingPrice.toString();
    var sum = oCcy
        .format(double.parse(selectedCurrencyPrice.value) * int.parse(amount));
    //Kaldırıldı
    /*String sum = formatStrings(
        (int.parse(buyingPrice.toString().replaceAll(".", "")) *
                int.parse(amount))
            .toString());*/
    sumCurrency.value = sum;
  }

  void handleStockPrice(String val, String? buyingPrice) {
    selectedCurrencyPrice.value = buyingPrice.toString();
    sumCurrency.value = removeDecimalPart(
        (double.parse(val) * double.parse(buyingPrice!)).toString());
  }

  void handleEmtiaPrice(String val, String? buyingPrice) {
    selectedCurrencyPrice.value = buyingPrice.toString();

    sumCurrency.value = removeDecimalPart(
        (double.parse(val) * removeDot(buyingPrice!)).toString());
  }

  void handleCryptoPrice(String val, String? buyingPrice) {
    selectedCurrencyPrice.value = buyingPrice.toString();

    sumCurrency.value = removeDecimalPart(
            (double.parse(val) * double.parse(buyingPrice!)).toString())
        .toString();
  }

  double removeDot(String metin) {
    String sonuc = metin.replaceAll('.', '').replaceAll(',', '.');

    return double.parse(sonuc);
  }

  String removeDecimalPart(String input) {
    int dotIndex = input.indexOf('.');

    if (dotIndex == -1 || dotIndex == input.length - 1) {
      return input;
    }

    String result = input.substring(0, dotIndex);

    return formatStrings(result);
  }

  String formatStrings(string) {
    String formattedString = "";
    int length = string.length;
    int count = 0;

    for (int i = length - 1; i >= 0; i--) {
      formattedString = string[i] + formattedString;
      count++;
      if (count == 3 && i > 0) {
        formattedString = '.$formattedString';
        count = 0;
      }
    }

    return formattedString;
  }

  saveAssets() {
    isLoading.value = true;

    if (selectedCurrency.value.sellingPrice != null && amount.value != 0) {
      Assets newAssets = Assets(
        amount: amount.value,
        assetType: selectedCurrency.value.name,
        price: selectedCurrencyPrice.value,
        sumAmount: sumCurrency.value,
      );
      firebaseServices
          .updateAssets(selectedCurrentAssets.value.assetsTitle, newAssets)
          .then((value) {
        isLoading.value = false;
        _currentPricesModelView.refreshData();
        Get.back();
        Get.back();
        _showSnackBar("Varlık başarıyla kaydedildi.", Styles.greenColor);
      });
    } else {
      isLoading.value = false;

      _showSnackBar("Lütfen tüm alanları doldurunuz.", Styles.warningRedColor);
    }
  }

  double a(String value) {
    if (value.isEmpty) {
      return 0.0;
    }

    value = value.replaceAll(',', '').replaceAll('.', '');

    int decimalIndex = value.indexOf('.');
    String integerPart = value.substring(0, decimalIndex);
    String decimalPart = value.substring(decimalIndex);

    double result = double.parse('$integerPart.$decimalPart');

    return result;
  }

  double stringToDoubleWithoutCommasAndDecimals(String value) {
    if (value.isEmpty) {
      return 0.0;
    }

    value = value.replaceAll(',', '').replaceAll('.', '');
    if (value.isEmpty) {
      return 0.0;
    }

    // Önce virgülü kaldırın, ardından noktayı değiştirin ve tekrar noktadan ayırın
    value = value.replaceAll(',', '').replaceAll('.', ',');

    // Noktadan önce ve sonra kısmı ayırın
    List<String> parts = value.split(',');

    if (parts.length == 1) {
      // Sadece tam sayı kısmı varsa
      return double.parse(parts[0]);
    } else if (parts.length == 2) {
      // Noktalı sayı kısmı da varsa
      return double.parse('${parts[0]}.${parts[1]}');
    } else {
      // Daha fazla virgül varsa, geçersiz bir değerdir
      throw FormatException("Geçersiz bir sayı formatı: $value");
    }
  }

  _showSnackBar(title, Color color) {
    Get.showSnackbar(GetSnackBar(
      backgroundColor: color,
      message: title,
      duration: const Duration(seconds: 3),
    ));
  }

  bitcoinCevirici(String price) {
    CurrentAssets assetsBul = _currentPricesModelView.currentAssets
        .where((p0) => p0.assetsTitle == "DÖVİZ")
        .first;
    var dolariBul =
        assetsBul.currencies!.where((element) => element.name == "USD").first;

    //doların güncel fiyatı
    double dolarprice = double.parse(dolariBul.buyingPrice.toString());

    //double bitcoinPriceInUSD = 0.0005103160425146261;
    double bitcoinPriceInUSD = double.parse(price);
    double usdToTryRate = dolarprice;
    double bitcoinPriceInTRY = bitcoinPriceInUSD * usdToTryRate;

    String formattedBitcoinPriceInTRY =
        NumberFormat.currency(locale: 'tr_TR', symbol: '₺')
            .format(bitcoinPriceInTRY);
    /*
        print('Bitcoin Değeri (USD): $bitcoinPriceInUSD');
        print('Bitcoin Değeri (TRY): $formattedBitcoinPriceInTRY');
    */
    return formattedBitcoinPriceInTRY;
  }

  bitcoinEkleCikar(String price, int index, int type) {
    var oldval = _currentPricesModelView
        .formkey.value.currentState!.fields['bitcoinValueText$index']!.value;
    if (type == 2) {
      if (oldval != "" && oldval != null) {
        print(oldval);
        int yeniDeger = int.parse(oldval) + 1;
        _currentPricesModelView
            .formkey.value.currentState!.fields['bitcoinValueText$index']!
            .didChange(yeniDeger.toString());
      } else {
        _currentPricesModelView
            .formkey.value.currentState!.fields['bitcoinValueText$index']!
            .didChange("1");
        update(['updatePrice$index']);
      }
    } else if (type == 1) {
      if (oldval != "" && oldval != null) {
        print(oldval);
        int yeniDeger = int.parse(oldval) - 1;
        _currentPricesModelView
            .formkey.value.currentState!.fields['bitcoinValueText$index']!
            .didChange(yeniDeger.toString());
      } else {
        _currentPricesModelView
            .formkey.value.currentState!.fields['bitcoinValueText$index']!
            .didChange("0");
        update(['updatePrice$index']);
      }
    }
    return "";
  }
}
