import 'package:amadis_delivery/core/config/config.dart';
import 'package:amadis_delivery/models/models.dart';
import 'package:flutter/cupertino.dart';

class QuoteOrderViewModel extends AmadisViewModel {
  QuoteOrderViewModel({
    this.order,
    this.subtotalPrice,
    this.boxCharges,
    this.bottleCharges,
    this.consumedList,
  });

  final Order order;
  final List<OrderDetail> consumedList;
  final double subtotalPrice;
  final double boxCharges;
  final double bottleCharges;
  final ScrollController scrollController = ScrollController();
}
