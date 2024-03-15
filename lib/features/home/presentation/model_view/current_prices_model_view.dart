import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:xapp/core/const.dart';
import 'package:xapp/core/dtos/currencies.dart';
import 'package:xapp/core/dtos/user_currency.dart';
import 'package:xapp/core/repository/all_currency_repository.dart';
import 'package:xapp/core/repository/crypto_repository.dart';
import 'package:xapp/core/repository/emtia_reposirory%20copy.dart';
import 'package:xapp/core/repository/gold_reposirory.dart';
import 'package:xapp/core/repository/stock_repository.dart';
import 'package:xapp/core/services/assets_firebase_services.dart';
import 'package:xapp/core/styles.dart';
import 'package:xapp/core/utils/currency_utils.dart';
import 'package:xapp/features/home/presentation/view/home_page.dart';

class CurrentPricesModelView extends GetxController {
  final GoldRepository goldRepository = GoldRepository();
  final StockRepository stockRepository = StockRepository();
  final CryptoRepository cryptoRepository = CryptoRepository();
  final EmtiaRepository emtiaRepository = EmtiaRepository();
  final AllCurrencyRepository allCurrencyRepository = AllCurrencyRepository();

  Rx<CurrentAssets> exchangesCurrencies = CurrentAssets().obs;
  RxList<CurrentAssets> currentAssets = <CurrentAssets>[].obs;
  RxList<CurrentAssets> filterCurrentAsets = <CurrentAssets>[].obs;
  final AssetsFirebaseServices firebaseServices = AssetsFirebaseServices();

  User? user = FirebaseAuth.instance.currentUser;
  Rx<bool> isLoading = false.obs;
  Rx<String> usdPrice = "26.0".obs;
  RxList<UserCurrency> userCurrency = <UserCurrency>[].obs;
  Rx<String> usersTotalAssets = "₺0.000.00".obs;
  Rx<double> percentageGain = 0.0.obs;
  Rx<double> tlGain = 0.0.obs;
  RxList<SalesData> chartList = <SalesData>[].obs;

  Rx<int> allDeteleIcon = 0.obs;

  var totalPrice = 0.0;
  String totalPriceStr = "";

  @override
  void onInit() {
    getAllData().then((value) {
      filterCurrentAsets.assignAll(copyCurrentAssetList(currentAssets.value));
      if (user != null) {
        getUserCurrency()
            .then((value) => calculateTotalAssets())
            .then((value) => isLoading.value = true);
      }
    }).then((value) {
      if (user == null) {
        isLoading.value = true;
      }
    });
    super.onInit();
  }

  Future getUserCurrency() async {
    userCurrency.value = await firebaseServices.getAllUserAssets();
    userCurrency.refresh();
  }

  Future getAllData() async {
    await Future.wait([
      getGold(),
      getStock(),
      getCrypto(),
      getEmtia(),
      getAllCurrency(),
    ]);
  }

  List<CurrentAssets> copyCurrentAssetList(List<CurrentAssets> fields) {
    return fields
        .map((element) => CurrentAssets(
            searchTerm: "",
            assetsTitle: element.assetsTitle,
            svgPath: element.svgPath,
            currencies: getCurrency(element.currencies!)))
        .toList();
  }

  CurrentAssets copyCurrentAssets(CurrentAssets fields) {
    return CurrentAssets(
        searchTerm: "",
        assetsTitle: fields.assetsTitle,
        svgPath: fields.svgPath,
        currencies: getCurrency(fields.currencies!));
  }

  List<Currency> getCurrency(List<Currency> fields) {
    return fields
        .map((e) => Currency(
            name: e.name,
            buyingPrice: e.buyingPrice,
            sellingPrice: e.sellingPrice,
            date: e.date))
        .toList();
  }

  Future getGold() async {
    await goldRepository.getGoldPrices().then((value) {
      currentAssets.add(value);
      currentAssets.refresh();
    });
  }

  Future getStock() async {
    await stockRepository.getStockPrices().then((value) {
      currentAssets.add(value);
      currentAssets.refresh();
    });
  }

  Future getCrypto() async {
    await cryptoRepository.getCryptoPrices().then((value) {
      currentAssets.add(value);

      currentAssets.refresh();
    });
  }

  Future getEmtia() async {
    await emtiaRepository.getEmtiaPrices().then((value) {
      currentAssets.add(value);
      currentAssets.refresh();
    });
  }

  Future getAllCurrency() async {
    await allCurrencyRepository.getAllCurrency().then((value) {
      for (Currency currency in value.currencies!) {
        if (currency.name == "USD") {
          usdPrice.value = currency.buyingPrice!;
        }
      }
      currentAssets.add(value);

      currentAssets.refresh();
    });
  }

  varlikArtisHesapla(String varlikTuru, String varlik, String alinanFiyat) {
    var varlikTuruData =
        currentAssets.where((p0) => p0.assetsTitle == varlikTuru).toList();
    var varlikData = varlikTuruData[0]
        .currencies!
        .where((element) => element.name == varlik)
        .first;

    var alisFiyati = double.parse(alinanFiyat);
    var guncelFiyat = double.parse(varlikData.buyingPrice.toString());
    return (alisFiyati < guncelFiyat
        ? AppConst.yukariPiyasaIcon
        : AppConst.dropdownIcon);
  }

  searchAssets(CurrentAssets currentAsset, String searchTerm) {
    List<Currency> searchList = [];
    if (searchTerm.isNotEmpty) {
      for (var i = 0; i < currentAssets.value.length; i++) {
        if (currentAssets.value[i].assetsTitle! == currentAsset.assetsTitle) {
          filterCurrentAsets.value[i].searchTerm = searchTerm;

          for (var j = 0; j < currentAssets.value[i].currencies!.length; j++) {
            if (currentAssets.value[i].currencies![j].name!
                .toLowerCase()
                .contains(searchTerm.toLowerCase())) {
              searchList.add(currentAssets.value[i].currencies![j]);
            }
          }

          filterCurrentAsets.value[i].currencies = getCurrency(searchList);
          filterCurrentAsets.refresh();
        }
      }
    } else {
      filterCurrentAsets.value
          .assignAll(copyCurrentAssetList(currentAssets.value));
      for (var i = 0; i < filterCurrentAsets.value.length; i++) {
        filterCurrentAsets[i].searchTerm = "";
      }
      filterCurrentAsets.refresh();
    }
  }

  clearSearch(CurrentAssets currentAsset) {
    for (var i = 0; i < currentAssets.value.length; i++) {
      if (currentAssets.value[i].assetsTitle! == currentAsset.assetsTitle) {
        filterCurrentAsets.value[i] = copyCurrentAssets(currentAssets.value[i]);

        filterCurrentAsets.refresh();
      }
    }
  }

  calculateTotalAssets() {
    var total = 0.0000;
    for (var m = 0; m < currentAssets.length; m++) {
      for (int i = 0; i < userCurrency.value.length; i++) {
        if (userCurrency.value[i].assetsTitle == currentAssets[m].assetsTitle) {
          for (var j = 0; j < userCurrency.value[i].assets!.length; j++) {
            for (var k = 0; k < currentAssets[m].currencies!.length; k++) {
              if (userCurrency.value[i].assets![j].assetType ==
                  currentAssets[m].currencies![k].name) {
                if (currentAssets[m].assetsTitle == "GOLD") {
                  total = total +
                      handleGoldPrice(userCurrency.value[i].assets![j].amount,
                          currentAssets[m].currencies![k].buyingPrice);
                } else if (currentAssets[m].assetsTitle == "HİSSE SENEDİ") {
                  total = total +
                      handleStockPrice(userCurrency.value[i].assets![j].amount,
                          currentAssets[m].currencies![k].buyingPrice);
                } else if (currentAssets[m].assetsTitle == "DÖVİZ") {
                  total = total +
                      handleStockPrice(userCurrency.value[i].assets![j].amount,
                          currentAssets[m].currencies![k].buyingPrice);
                } else if (currentAssets[m].assetsTitle == "EMTİA") {
                  total = total +
                      (handleEmtiaPrice(userCurrency.value[i].assets![j].amount,
                              currentAssets[m].currencies![k].buyingPrice)) *
                          double.parse(usdPrice.value);
                } else {
                  total = total +
                      (handleCryptoPrice(
                              userCurrency.value[i].assets![j].amount,
                              currentAssets[m].currencies![k].buyingPrice)) *
                          double.parse(usdPrice.value);
                }
              }
            }
          }
        }
      }
    }
    usersTotalAssets.value =
        "₺${CurrencyUtils.removeDecimalPart(total.toString())}";
  }

  handleGoldPrice(amount, buyingPrice) {
    /*
    final oCcy = new NumberFormat("#,##0.00", "tr_TR");
    var sum2 = oCcy.format(double.parse('$buyingPrice') * amount);
    */
    //düzenlenecek
    var noReplace = double.parse(buyingPrice) * amount;

    //Eski yapı
    var sum = (int.parse(buyingPrice.toString().replaceAll(".", "")) * amount);
    //Eski yapı
    return noReplace;
  }

  handleStockPrice(val, buyingPrice) {
    return (val * double.parse(buyingPrice!));
  }

  handleEmtiaPrice(val, buyingPrice) {
    return val * CurrencyUtils.removeDotWithDouble(buyingPrice!);
  }

  handleCryptoPrice(val, buyingPrice) {
    double dolarprice =
        double.parse(currentAssets[1].currencies![0].buyingPrice.toString());
    double buyingPriceParse = double.parse(buyingPrice.toString());
    return (val * (buyingPriceParse * dolarprice));
  }

  onSelectedChartAssets(value) {
    chartList.value = [];
    percentageGain.value = 0.0;
    tlGain.value = 0.0;
    double total = 0.0;
    int firstPrices = 0;
    for (var element in userCurrency.value) {
      if (element.assetsTitle == value.assetsTitle) {
        if (element.assets!.isNotEmpty) {
          for (var element in element.assets!) {
            firstPrices =
                firstPrices + int.parse(element.sumAmount!.replaceAll(".", ""));
          }
          chartList.value.add(SalesData(
              "İlk satın alma", double.parse(firstPrices.toString())));
        } else {
          chartList.value = [];
        }
      }
    }

    for (var userCurrency in userCurrency.value) {
      if (value.assetsTitle == userCurrency.assetsTitle) {
        if (userCurrency.assets!.isNotEmpty) {
          for (var i = 0; i < value.currencies.length; i++) {
            for (var element in userCurrency.assets!) {
              if (value.currencies[i].name == element.assetType) {
                if (value.assetsTitle == "GOLD") {
                  total = total +
                      handleGoldPrice(
                          element.amount!, value.currencies[i].buyingPrice!);
                } else if (value.assetsTitle == "HİSSE SENEDİ") {
                  total = total +
                      handleStockPrice(
                          element.amount!, value.currencies[i].buyingPrice!);
                } else if (value.assetsTitle == "DÖVİZ") {
                  total = total +
                      handleStockPrice(
                          element.amount!, value.currencies[i].buyingPrice!);
                } else if (value.assetsTitle == "EMTİA") {
                  total = total +
                      handleEmtiaPrice(
                          element.amount!, value.currencies[i].buyingPrice!);
                } else {
                  total = total +
                      handleCryptoPrice(
                          element.amount!, value.currencies[i].buyingPrice!);
                }
              }
            }
          }
          chartList.value.add(SalesData("Bugün", total.toPrecision(0)));
        }
      }
    }
    hesaplaKarZararYuzdesi();
  }

  List<double> removeCommasAndParseToDouble(List<String> values) {
    List<double> result = [];

    for (String value in values) {
      String cleanedValue = value.replaceAll(',', '');
      double parsedValue = double.tryParse(cleanedValue) ?? 0.0;
      result.add(parsedValue);
    }

    return result;
  }

  hesaplaKarZararYuzdesi() {
    if (chartList.length > 1) {
      tlGain.value = chartList.value[1].sales - chartList.value[0].sales;
      percentageGain.value = (tlGain.value / chartList.value[0].sales) * 100;
    }
  }

  double stringToDoubleWithoutCommasAndDecimals(String veri) {
    List<String> parcalanmisVeri = veri.split(',');

    String tamSayiKisim = parcalanmisVeri[0].replaceAll('.', '');

    String ondalikKisim = parcalanmisVeri[1];

    String yeniVeri = '$tamSayiKisim.$ondalikKisim';

    return double.parse(yeniVeri);
  }

  Future refreshData() async {
    await getUserCurrency().then((value) => calculateTotalAssets());
  }

  getTotalAssets(UserCurrency userCurrency) {
    double total = 0.0;
    totalPrice = 0;
    for (var currrentAsset in currentAssets) {
      if (currrentAsset.assetsTitle == userCurrency.assetsTitle) {
        if (userCurrency.assetsTitle == "GOLD") {
          for (var i = 0; i < userCurrency.assets!.length; i++) {
            for (var currency in currrentAsset.currencies!) {
              if (userCurrency.assets![i].assetType == currency.name) {
                total = total +
                    handleGoldPrice(
                      userCurrency.assets![i].amount!,
                      currency.buyingPrice,
                    );
              }
            }
          }
        } else if (userCurrency.assetsTitle == "HİSSE SENEDİ") {
          for (var i = 0; i < userCurrency.assets!.length; i++) {
            for (var currency in currrentAsset.currencies!) {
              if (userCurrency.assets![i].assetType == currency.name) {
                total = total +
                    handleStockPrice(
                      userCurrency.assets![i].amount!,
                      currency.buyingPrice,
                    );
              }
            }
          }
        } else if (userCurrency.assetsTitle == "DÖVİZ") {
          for (var i = 0; i < userCurrency.assets!.length; i++) {
            for (var currency in currrentAsset.currencies!) {
              if (userCurrency.assets![i].assetType == currency.name) {
                total = total +
                    handleStockPrice(
                      userCurrency.assets![i].amount!,
                      currency.buyingPrice,
                    );
              }
            }
          }
        } else if (userCurrency.assetsTitle == "EMTİA") {
          for (var i = 0; i < userCurrency.assets!.length; i++) {
            for (var currency in currrentAsset.currencies!) {
              if (userCurrency.assets![i].assetType == currency.name) {
                total = total +
                    handleEmtiaPrice(
                      userCurrency.assets![i].amount!,
                      currency.buyingPrice,
                    );
              }
            }
          }
        } else {
          for (var i = 0; i < userCurrency.assets!.length; i++) {
            for (var currency in currrentAsset.currencies!) {
              if (userCurrency.assets![i].assetType == currency.name) {
                total = total +
                    handleCryptoPrice(
                      userCurrency.assets![i].amount!,
                      currency.buyingPrice,
                    );
              }
            }
          }
        }
      }
    }

    totalPriceStr = "";

    totalPrice = totalPrice + total;
    final oCcy = new NumberFormat("#,##0.00", "tr_TR");
    var numberToPriceFormat =
        oCcy.format(int.parse(totalPrice.toStringAsFixed(0)));
    totalPriceStr = numberToPriceFormat;
    //sumList.add(numberToPriceFormat);
    print("veri alındı" + numberToPriceFormat);

    return CurrencyUtils.formatStrings(total.toStringAsFixed(0));
  }

  deleteAssets(String collectionName, Assets assets) {
    for (var i = 0; i < userCurrency.value.length; i++) {
      if (userCurrency.value[i].assetsTitle == collectionName) {
        for (var j = 0; j < userCurrency.value[i].assets!.length; j++) {
          if (userCurrency.value[i].assets![j].assetType == assets.assetType &&
              userCurrency.value[i].assets![j].sumAmount == assets.sumAmount) {
            userCurrency.value[i].assets!.removeAt(j);
          }
        }
      }
    }
    Get.back();

    _showSnackBar("Varlık başarıyla silindi.", Styles.greenColor);
    userCurrency.refresh();
    calculateTotalAssets();

    firebaseServices.deleteAssets(collectionName, assets);
  }

  _showSnackBar(title, Color color) {
    Get.showSnackbar(GetSnackBar(
      backgroundColor: color,
      message: title,
      duration: const Duration(seconds: 3),
    ));
  }
}
