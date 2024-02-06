import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:xapp/core/const.dart';
import 'package:xapp/core/styles.dart';
import 'package:xapp/features/home/presentation/model_view/home_model_view.dart';
import 'package:xapp/features/home/presentation/widgets/duzenle_modal.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({
    super.key,
  });

  final HomeModelView homeModelView = Get.put(HomeModelView());
  final List svgPath = [
    AppConst.duzenleIcon,
    AppConst.varlikIcon,
    AppConst.gecmisKayitIcon,
    AppConst.ekraniBolIcon
  ];
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomNavigationBar(
        currentIndex: homeModelView.selectedBody.value,
        backgroundColor: const  Color(0xFFecb08b),
        elevation: 0,
        onTap: (value) {
          if (value == 0) {
            showDialog(
              context: context,
              builder: (context) => DuzenleModal(),
            );
          }
          homeModelView.onChangeBody(value);
        },
        type: BottomNavigationBarType.fixed,
        items: List.generate(
          4,
          (index) => BottomNavigationBarItem(
            icon: BottomNavbarIcon(
              assetName: svgPath[index],
              isSelected: index == homeModelView.selectedBody.value,
            ),
            label: "",
          ),
        ),
      ),
    );
  }
}

class BottomNavbarIcon extends StatelessWidget {
  const BottomNavbarIcon({
    super.key,
    this.assetName,
    this.isSelected,
  });

  final String? assetName;
  final bool? isSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          assetName!,
          color: Styles.textColor,
        ),
        isSelected!
            ? Container(
                width: 50,
                height: 1,
                margin: const EdgeInsets.only(top: 10),
                color: Styles.textColor,
              )
            : Container(),
      ],
    );
  }
}
