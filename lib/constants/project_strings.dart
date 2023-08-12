enum LanguagesEnum {
  appName,
  home,
  settings,
  addData,
  deleteData,
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
  cancelSelection,
}

class ProjectStrings {
  static const String appName = 'Weight Tracker';
  static const String appID = '83212382-451b-4943-960f-11b9c2360670';
  static List<List<String>> strings = [
    [
      'Weight Tracker',
      'Home',
      'Settings',
      'Add Data',
      'Delete',
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
      'Cancel Selection'
    ],
    [
      'Kilo Takibi',
      'Anasayfa',
      'Ayarlar',
      'Veri Ekle',
      'Sil',
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
      'İptal Et'
    ],
  ];

  String findString(int lang, LanguagesEnum key) => strings.elementAt(lang).elementAt(key.index).toString();
}
