class AmadisAssets {
  static final AmadisAssets _amadisAssets = AmadisAssets._internal();

  factory AmadisAssets() => _amadisAssets;

  AmadisAssets._internal();

  static const logo = 'assets/img/amadis_logo_transp.png';
  static const emptyBox = 'assets/icon/empty-box.png';
  static const placeholder = 'assets/img/placeholder.png';
  static const success_delivery = 'assets/icon/entrega-exitosa.png';

  static const svg_check_mark = 'assets/icon/check.svg';
  static const svg_check_mark_2 = 'assets/icon/check_mark.svg';
}
