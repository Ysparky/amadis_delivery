import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/core/widgets/location_form_field/location_form_field.dart';
import 'package:flutter/material.dart';

class LocationCardFormField extends StatelessWidget {
  const LocationCardFormField({
    Key key,
    @required this.controller,
  }) : super(key: key);
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
              'Dirección del Envío',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: hp(1)),
            LocationFormField(controller: controller),
          ],
        ),
      ),
    );
  }
}
