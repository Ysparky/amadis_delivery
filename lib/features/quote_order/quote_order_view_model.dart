import 'package:amadis_delivery/core/config/config.dart';
import 'package:amadis_delivery/models/models.dart';

class QuoteOrderViewModel extends AmadisViewModel {
  QuoteOrderViewModel(this.order, {this.consumedList});
  final Order order;
  final List<OrderDetail> consumedList;
}
