import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:flutter/material.dart';

class DayIndicator extends StatelessWidget {
  const DayIndicator({
    Key key,
    @required this.day,
    @required this.dayOfWeek,
    @required this.isToday,
  }) : super(key: key);

  final int day;
  final String dayOfWeek;
  final bool isToday;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            dayOfWeek,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .copyWith(color: Colors.black87),
          ),
          SizedBox(height: hp(1)),
          CircleAvatar(
            backgroundColor:
                isToday ? AmadisColors.errorColor : Colors.transparent,
            child: Text(
              '$day',
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                  color: isToday ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
