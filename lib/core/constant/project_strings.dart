enum LanguagesEnum {
  home,
  settings,
  addData,
  okUpper,
  cancelUpper,
  disable,
  emptyData,
  current,
  change,
  weekly,
  monthly,
  zero,
  addRecord,
}

class ProjectStrings {
  final String appName = 'Weight Tracker';
  static final strings = <List>[
    [
      'Home',
      'COMING SOON',
      'Add Data',
      'OK',
      'CANCEL',
      'Disable',
      'Empty data',
      'Current',
      'Change',
      'Weekly',
      'Monthly',
      '0',
      'Add a record',
    ],
    [
      'Anasayfa',
      'YAKINDA',
      'Veri Ekle',
      'TM',
      'İPTAL',
      'Kapalı',
      'Veri yok',
      'Güncel',
      'Değişim',
      'Haftalık',
      'Aylık',
      '0',
      'Kayıt ekle',
    ],
  ];

  String findString(int lang, LanguagesEnum key) => strings.elementAt(lang).elementAt(key.index).toString();
}
