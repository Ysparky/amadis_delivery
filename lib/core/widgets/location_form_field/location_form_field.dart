import 'package:amadis_delivery/core/config/config.dart';
import 'package:amadis_delivery/core/widgets/location_form_field/location_form_field_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: AmadisColors.errorColor),
    );
    final _normalBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: AmadisColors.primaryColor),
    );
    return TextFormField(
      autofocus: false,
      controller: _viewModel.textController,
      enableInteractiveSelection: true,
      validator: _viewModel.validator,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(12),
        hintText: 'Dirección',
        isDense: true,
        suffixIcon: GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              color: AmadisColors.primaryColor,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Icon(Icons.location_on, color: Colors.white),
          ),
          onTap: () => _viewModel.openLocationModal(context),
        ),
        border: _normalBorder,
        enabledBorder: _normalBorder,
        focusedBorder: _normalBorder,
        errorBorder: _errorBorder,
        focusedErrorBorder: _errorBorder,
      ),
    );
  }
}
