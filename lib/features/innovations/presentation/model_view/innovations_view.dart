import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:xapp/core/dtos/currencies.dart';
import 'package:xapp/core/dtos/user_currency.dart';
import 'package:xapp/core/dtos/user_dto.dart';
import 'package:xapp/core/repository/all_currency_repository.dart';
import 'package:xapp/core/repository/crypto_repository.dart';
import 'package:xapp/core/repository/emtia_reposirory%20copy.dart';
import 'package:xapp/core/repository/gold_reposirory.dart';
import 'package:xapp/core/repository/stock_repository.dart';
import 'package:xapp/core/services/assets_firebase_services.dart';
import 'package:xapp/core/services/auth_services.dart';

class InnovationsModelView extends GetxController {
  final AuthServices authServices = AuthServices();
  Rx<UserDTO> userDTO = UserDTO().obs;
  final user = FirebaseAuth.instance.currentUser;
  RxList<UserCurrency> userCurrency = <UserCurrency>[].obs;
  final AssetsFirebaseServices firebaseServices = AssetsFirebaseServices();
  RxList<Map<String, dynamic>> allpricedata = <Map<String, dynamic>>[].obs;

  final GoldRepository goldRepository = GoldRepository();
  final StockRepository stockRepository = StockRepository();
  final CryptoRepository cryptoRepository = CryptoRepository();
  final EmtiaRepository emtiaRepository = EmtiaRepository();
  final AllCurrencyRepository allCurrencyRepository = AllCurrencyRepository();

  RxList<CurrentAssets> currentAssets = <CurrentAssets>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    if (user != null) {
      getUserInfo();
      getAllCurrency();
    }
    super.onInit();
  }

  getUserInfo() async {
    userDTO.value = await authServices.getUserInfo();
  }

  Future getAllCurrency() async {
    int totalAssets = 0;
    userCurrency.value = await firebaseServices.getAllUserAssets();

    userCurrency.refresh();

    userCurrency.refresh();
    userCurrency.value.forEach((currency) {
      if (currency.assets!.isNotEmpty) {
        currency.assets!.forEach((asset) {
          allpricedata.add({
            'isim': asset.assetType,
            'fiyat': double.parse(asset.price.toString()),
          });
          totalAssets += 1;
        });
      }
    });

    Map<String, dynamic>? minItem;
    Map<String, dynamic>? maxItem;
    double? minNumber = 0.0;
    double? maxNumber = 0.0;
    if (allpricedata.isNotEmpty) {
      minItem = allpricedata.reduce((a, b) => a['fiyat'] < b['fiyat'] ? a : b);
      maxItem = allpricedata.reduce((a, b) => a['fiyat'] > b['fiyat'] ? a : b);
      minNumber = minItem['fiyat'];
      maxNumber = maxItem['fiyat'];
    }

    NumberFormat formatter = NumberFormat("#,##0.0", "tr_TR");
    String minPriceFormatted = formatter.format(minNumber) + ' ₺';
    String maxPriceFormatted = formatter.format(maxNumber) + ' ₺';

    print('En düşük değer: ${minItem?['isim']} - $minPriceFormatted');
    print('En büyük değer: ${maxItem?['isim']} - $maxPriceFormatted');

    int totalCurrancies = 0;

    await allCurrencyRepository.getAllCurrency().then((value) {
      totalCurrancies += value.currencies!.length;
    });

    await goldRepository.getGoldPrices().then((value) {
      totalCurrancies += value.currencies!.length;
    });

    await stockRepository.getStockPrices().then((value) {
      totalCurrancies += value.currencies!.length;
    });

    await cryptoRepository.getCryptoPrices().then((value) {
      totalCurrancies += value.currencies!.length;
    });

    await emtiaRepository.getEmtiaPrices().then((value) {
      totalCurrancies += value.currencies!.length;
    });

    print( "$totalAssets / $totalCurrancies" );
  }
}
