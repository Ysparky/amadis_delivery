import 'package:amadis_delivery/core/utils/responsive.dart';
import 'package:flutter/material.dart';

class TextCardFormField extends StatelessWidget {
  const TextCardFormField({
    Key key,
    @required this.text,
    @required this.iconData,
    this.onTap,
    this.controller,
  }) : super(key: key);
  final Function onTap;
  final IconData iconData;
  final String text;
  final TextEditingController controller;

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
            TextFormField(
              controller: controller,
              onTap: onTap,
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                suffixIcon: Icon(iconData, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
