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
  chartName,
}

class ProjectStrings {
  static const String appName = 'Weight Tracker';
  static const String appID = '83212382-451b-4943-960f-11b9c2360670';
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
      'Chart'
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
      'Grafik',
    ],
  ];

  String findString(int lang, LanguagesEnum key) => strings.elementAt(lang).elementAt(key.index).toString();
}
