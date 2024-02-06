import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xapp/core/styles.dart';
import 'package:flutter_svg/svg.dart';
import 'package:xapp/core/const.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({super.key});

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
// Sık Sorulan Sorular
  List<String> frequentlyAskedQuestions = [
    "Toplamda+ nedir?",
    "Toplamda+'yı neden kullanmalıyım?",
    "Web veya masaüstü uygulamanız var mı?",
    "Al-Sat olanağı var mı?",
    "Yurtdışında hizmet verecek misiniz?",
  ];

// Cevaplar
  List<String> answers = [
    "Toplamda+ bir varlık hesaplayıcıdır. Dakikalar, belki de saatler sürecek iş yükünden seni kurtarıp saniyeler içerisinde tüm varlıklarını hesaplar ve bunu sana özel grafiğe yansıtır.",
    "Toplamda+ uygulaması yatırım ve birikimlerine yönelik planlarının netleşmesini sağlar. Varlıklarının hareketini ayrıntılı biçimde ve devamlı gördükçe onlar üzerindeki kontrol duygun pekişir. Bu kontrol duygusu, gelecekte alacağın kararlar üzerinde oldukça etkilidir.  Bir varlığın iyiye gidiyorsa nasıl ve neden iyiye gittiğini, kötüye gidiyorsa neden ve nasıl kötüye gittiğini Toplamda+ sayesinde daha çabuk anlarsın. Servetini eriten bir sorun varsa bunu daha hızlı tespit etmeni ve aksiyon almanı teşvik ederiz.Örneğin birim zamanda sahip olduğun gayrimenkulün en çok artan değer olmuşsa bir sonraki yatırım stratejini yine gayrimenkul üzerinden oluşturmak isteyebilirsin. Veya Nasdaq borsasına ait hisse senetlerinde ciddi düşüşler yaşanmışsa buradaki yatırımlarını gözden geçirmek isteyebilirsin. İşte bu kapsamda Toplamda+ çok iyi bir stratejik rehberdir.",
    "Toplamda+ uygulamasını henüz web üzerinden ya da masaüstünden kullanım imkânı bulunmamaktadır. Fakat bu konu gündemimizde olup gelişmeler sitemizden ve sosyal medya kanallarımızdan paylaşılacaktır.",
    "Hayır. Bizde herhangi bir varlık alım satım hizmeti yoktur. Toplamda+ sana yalnızca varlıklarının değer verilerini gösterir.",
    "Uzun vadeli planlarımız arasında yer alsa da şu anda sadece Türkiye genelinde hizmet vermekteyiz.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
          gradient: Styles.appLinear,
        ),
        child: Column(
          children: [
            AppBar(
              leading: IconButton(
                icon: SvgPicture.asset(AppConst.backsolIcon, color: Colors.white, width: 35),
                onPressed: () => Navigator.of(context).pop(),
              ),
              elevation: 0,
              centerTitle: true,
              backgroundColor: Colors.transparent,
              title: Text(
                "Sıkça Sorulan Sorular",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: Get.width,
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                // decoration: BoxDecoration(
                //   color: Colors.white.withOpacity(0.2),
                //   borderRadius: BorderRadius.circular(10),
                // ),
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: frequentlyAskedQuestions.length,
                  itemBuilder: (context, index) {
                    return ListTileTheme(
                      dense: true,
                      child: ExpansionTile(
                        shape: Border.all(color: Colors.transparent),
                        tilePadding: EdgeInsets.zero,
                        iconColor: Colors.black,
                        collapsedIconColor: Colors.black,
                        title: Text(
                          frequentlyAskedQuestions[index],
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Styles.textColor,
                          ),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              answers[index],
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: Styles.textColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
