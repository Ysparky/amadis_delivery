import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:auto_route/auto_route.dart';

class HomeViewModel extends AmadisViewModel {
  HomeViewModel() {
    _generateDates();
  }

  List<String> get daysOfWeek =>
      ['LUN', 'MAR', 'MIE', 'JUE', 'VIE', 'SAB', 'DOM'];

  List<int> days = [];

  int get today => DateTime.now().day;

  final _prefs = SharedPrefs();

  void _generateDates() {
    var monday = 0;
    if (DateTime.now().weekday > 1) {
      final counter = DateTime.now().weekday - 1;
      monday = DateTime.now().day - counter;
    } else {
      monday = DateTime.now().day;
    }
    var aux = monday;
    for (var i = 0; i < 7; i++) {
      days.add(aux);
      aux++;
    }
  }

  void logOut() {
    _prefs.removeAll();
    ExtendedNavigator.root.popAndPush(Routes.loginPage);
  }
}
