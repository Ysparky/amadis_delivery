import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/features/route_detail/route_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocalStep extends StatelessWidget {
  const LocalStep({
    Key key,
    this.enabled = true,
  }) : super(key: key);

  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final _viewModel = Provider.of<RouteDetailViewModel>(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: hp(1)),
      child: Material(
        color: Colors.white,
        elevation: 2,
        borderRadius: BorderRadius.circular(15),
        clipBehavior: Clip.antiAlias,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: AmadisColors.primaryColor, width: wp(2)),
            ),
          ),
          padding: EdgeInsets.symmetric(
            vertical: hp(1.5),
            horizontal: wp(4),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.corporate_fare),
                  SizedBox(width: wp(2)),
                  Expanded(
                    child: Text(
                      'Punto de Partida (Local):',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                ],
              ),
              SizedBox(height: hp(0.5)),
              Text(
                'Av Jose Carlos Mariategui 2235, Villa María del Triunfo',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              if (enabled)
                Align(
                  alignment: Alignment.bottomRight,
                  child: MaterialButton(
                    onPressed: _viewModel.startRoute,
                    padding: EdgeInsets.symmetric(vertical: hp(1)),
                    color: AmadisColors.primaryColor,
                    child: Icon(
                      Icons.near_me,
                      color: AmadisColors.backgroundColor,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
