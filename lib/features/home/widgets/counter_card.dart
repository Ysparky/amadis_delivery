import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:flutter/material.dart';

class CounterCard extends StatelessWidget {
  const CounterCard({
    Key key,
    @required this.icon,
    @required this.qty,
    @required this.description,
  }) : super(key: key);

  final IconData icon;
  final int qty;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(15),
      clipBehavior: Clip.antiAlias,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: wp(2),
          vertical: hp(3),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Color(0xffF5E3E2),
                  radius: hp(3),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      icon,
                      color: Color(0xffbd4341),
                    ),
                  ),
                ),
                SizedBox(width: wp(5)),
                Text(
                  '$qty',
                  style: Theme.of(context).textTheme.headline2.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Text(
              description,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
