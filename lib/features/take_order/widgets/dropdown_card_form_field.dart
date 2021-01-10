import 'package:flutter/material.dart';

import 'package:amadis_delivery/core/utils/responsive.dart';

class DropDownCardFormField extends StatelessWidget {
  const DropDownCardFormField({
    Key key,
    @required this.text,
    this.items,
    this.onChanged,
    this.value,
  }) : super(key: key);

  final String text;
  final List<DropdownMenuItem> items;
  final Function onChanged;
  final dynamic value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: hp(1)),
            DropdownButtonFormField(
              isExpanded: true,
              items: items,
              onChanged: onChanged,
              value: value,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
