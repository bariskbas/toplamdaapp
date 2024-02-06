import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:xapp/core/const.dart';
import 'package:xapp/core/dtos/user_currency.dart';

class AssetsFirebaseServices {
  final assets = FirebaseFirestore.instance.collection("assets");
  final firebaseAuth = FirebaseAuth.instance;

  // Future<void> saveAssets(collection) async {
  //   print("object");
  //   final value = await getAssetsDocsId(collection);
  //   print(value);
  //   await assets
  //       .doc(firebaseAuth.currentUser!.uid)
  //       .collection(collection)
  //       .doc(value)
  //       .update(
  //     {
  //       "assetsTitle": "Doviz",
  //       "assetsSvgPath": "doviz.svg",
  //       "assets": [
  //         {"assetType": "EUR", "amount": 2, "price": 27.02, "sumAmount": 54.04}
  //       ]
  //     },
  //   );
  // }

  // get() {}

  Future<String> getAssetsDocsId(collectionName) async {
    final value = await assets
        .doc(firebaseAuth.currentUser!.uid)
        .collection(collectionName)
        .get();

    return value.docs.first.id;
  }

  Future<UserCurrency> getAssetsData(collectionName) async {
    final value = await getAssetsDocsId(collectionName);

    final data = await assets
        .doc(firebaseAuth.currentUser!.uid)
        .collection(collectionName)
        .doc(value)
        .get();
    return UserCurrency.fromJson(data.data()!);
  }

  Future<List<UserCurrency>> getAllUserAssets() async {
    List<UserCurrency> userCurencies = [];

    for (var collectionName in AppConst.assetsCollections) {
      final value = await getAssetsDocsId(collectionName);

      final data = await assets
          .doc(firebaseAuth.currentUser!.uid)
          .collection(collectionName)
          .doc(value)
          .get();

      userCurencies.add(UserCurrency.fromJson(data.data()!));
    }
    return userCurencies;
  }

  Future updateAssets(collectionName, Assets newAssets) async {
    final value = await getAssetsDocsId(collectionName);
    UserCurrency currentAssets = await getAssetsData(collectionName);

    currentAssets.assets!.add(newAssets);

    await assets
        .doc(firebaseAuth.currentUser!.uid)
        .collection(collectionName)
        .doc(value)
        .set(
          currentAssets.toJson(),
        );
  }

  Future deleteAssets(collectionName, Assets newAssets) async {
    final value = await getAssetsDocsId(collectionName);
    UserCurrency currentAssets = await getAssetsData(collectionName);

    for (var i = 0; i < currentAssets.assets!.length; i++) {
      if (newAssets.assetType == currentAssets.assets![i].assetType) {
        currentAssets.assets!.removeAt(i);
      }
    }

    await assets
        .doc(firebaseAuth.currentUser!.uid)
        .collection(collectionName)
        .doc(value)
        .set(
          currentAssets.toJson(),
        );
  }
}
