import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/core/widgets/location_form_field/location_form_field_view_model.dart';

class LocationFormField extends StatelessWidget {
  const LocationFormField({Key key, this.controller}) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LocationFormFieldViewModel(textController: controller),
        )
      ],
      child: LocationFormFieldBase(),
    );
  }
}

class LocationFormFieldBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _viewModel = Provider.of<LocationFormFieldViewModel>(context);
    final _errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.0),
      borderSide: BorderSide(color: AmadisColors.errorColor),
    );
    return TextFormField(
      autofocus: false,
      controller: _viewModel.textController,
      enableInteractiveSelection: true,
      validator: _viewModel.validator,
      readOnly: true,
      onTap: () => _viewModel.openLocationModal(context),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(12),
        hintText: 'Dirección',
        isDense: true,
        suffixIcon: Container(
          decoration: BoxDecoration(
            color: AmadisColors.primaryColor,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(4),
              topRight: Radius.circular(4),
            ),
          ),
          child: Icon(Icons.location_on, color: Colors.white),
        ),
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(),
        errorBorder: _errorBorder,
        focusedErrorBorder: _errorBorder,
      ),
    );
  }
}
