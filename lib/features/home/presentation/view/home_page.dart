import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:xapp/core/const.dart';
import 'package:xapp/core/dtos/currencies.dart';
import 'package:xapp/core/styles.dart';
import 'package:xapp/features/home/presentation/model_view/current_prices_model_view.dart';
import 'package:xapp/features/home/presentation/model_view/home_model_view.dart';
import 'package:xapp/features/home/presentation/widgets/bildirimler_modal.dart';
import 'package:xapp/features/home/presentation/widgets/bottom_nav_bar.dart';
import 'package:xapp/features/home/presentation/widgets/guncel_fiyatlar.dart';
import 'package:xapp/features/home/presentation/widgets/hesap_bilgi_alani.dart';
import 'package:xapp/features/home/presentation/widgets/ikiye_bol.dart';
import 'package:xapp/features/home/presentation/widgets/secenekler_modal.dart';
import 'package:xapp/features/home/presentation/widgets/tum_varliklarim.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<SalesData> data = [
    SalesData('İlk satın alma', 35),
    SalesData('Bugün', 40),
  ];

  final bodyList = [
    TumVarliklarim(),
    TumVarliklarim(),
    GuncelFiyatlar(),
    IkiyeBol(),
  ];

  final HomeModelView homeModelView = Get.put(HomeModelView());

  final CurrentPricesModelView currentPricesModelView =
      Get.put(CurrentPricesModelView());
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => currentPricesModelView.isLoading.value
          ? Scaffold(
              resizeToAvoidBottomInset: true,
              extendBodyBehindAppBar: true,
              extendBody: true,
              bottomNavigationBar: BottomNavBar(),
              appBar: AppBar(
                elevation: 0,
                centerTitle: true,
                backgroundColor: Colors.transparent,
                title: SvgPicture.asset(
                  AppConst.logoPathSvg,
                  width: 120,
                  color: Colors.white,
                ),
                actions: [
                  GestureDetector(
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => SeceneklerModal(),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: SvgPicture.asset(
                        AppConst.menuIcon,
                        color: Styles.textColor,
                        width: 30,
                      ),
                    ),
                  ),
                ],
                leading: user != null
                    ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: InkWell(
                          onTap: () => showDialog(
                              context: context,
                              useSafeArea: true,
                              builder: (context) => const BildirimlerModal()),
                          child: SizedBox(
                            height: double.infinity,
                            width: double.infinity,
                            child: Stack(
                              children: [
                                SvgPicture.asset(
                                  AppConst.bildirimIcon,
                                  color: Styles.textColor,
                                  width: 40,
                                ),
                                const Positioned(
                                    right: 5,
                                    top: 0,
                                    child: CircleAvatar(
                                      maxRadius: 7,
                                      backgroundColor: Colors.red,
                                      child: Center(
                                        child: Text(
                                          "0",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10),
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ),
              body: Container(
                height: Get.height,
                width: Get.width,
                decoration: BoxDecoration(
                  gradient: Styles.appLinear,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 88,
                      ),
                      HesapBilgiAlani(),
                      Obx(
                        () => Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            margin: const EdgeInsets.only(right: 20),
                            width: Get.width * 0.18,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField<CurrentAssets>(
                                  hint: const Text("TÜMÜ"),
                                  borderRadius: BorderRadius.circular(15.0),
                                  isExpanded: true,
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                  icon: SvgPicture.asset(
                                    AppConst.dropdownIcon,
                                    color: Colors.white,
                                    width: 15,
                                  ),
                                  dropdownColor: const Color(0xFFF6F6F6),
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                  onChanged: currentPricesModelView
                                      .onSelectedChartAssets,
                                  items: List.generate(
                                    currentPricesModelView
                                        .currentAssets.value.length,
                                    (index) => DropdownMenuItem(
                                      value: currentPricesModelView
                                          .currentAssets.value[index],
                                      child: SizedBox(
                                        child: Text(
                                          currentPricesModelView.currentAssets
                                              .value[index].assetsTitle!,
                                          style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.bold,
                                            color: Styles.textColor,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                        ),
                      ),
                      Obx(
                        () => SizedBox(
                          height: Get.height * 0.3,
                          child: SfCartesianChart(
                            primaryXAxis: CategoryAxis(),
                            tooltipBehavior: TooltipBehavior(enable: true),
                            plotAreaBackgroundColor: Colors.transparent,
                            series: <ChartSeries<SalesData, String>>[
                              LineSeries<SalesData, String>(
                                  dataSource:
                                      currentPricesModelView.chartList.value,
                                  isVisibleInLegend: false,
                                  xValueMapper: (SalesData sales, _) =>
                                      sales.year,
                                  yValueMapper: (SalesData sales, _) =>
                                      sales.sales,
                                  color: Colors.white,
                                  dataLabelSettings:
                                      const DataLabelSettings(isVisible: false))
                            ],
                          ),
                        ),
                      ),
                      Obx(
                        () => SizedBox(
                          child: bodyList[homeModelView.selectedBody.value],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          : Container(
              height: Get.height,
              width: Get.width,
              decoration: BoxDecoration(
                gradient: Styles.appLinear,
              ),
              child: Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                    color: Colors.white.withOpacity(0.5),
                    strokeWidth: 5,
                  ),
                ),
              ),
            ),
    );
  }
}

class SalesData {
  final String year;
  final double sales;
  SalesData(this.year, this.sales);
}
