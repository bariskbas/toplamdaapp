class CurrencyUtils {
  static String formatStrings(string) {
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

  static String removeDecimalPart(String input) {
    int dotIndex = input.indexOf('.');

    if (dotIndex == -1 || dotIndex == input.length - 1) {
      return input;
    }

    String result = input.substring(0, dotIndex);

    return formatStrings(result);
  }

  static String removeDot(String metin) {
    String sonuc = metin.replaceAll('.', '').replaceAll(',', '.');

    return sonuc;
  }

  static double removeDotWithDouble(String metin) {
    String sonuc = metin.replaceAll('.', '').replaceAll(',', '.');

    return double.parse(sonuc);
  }
}
