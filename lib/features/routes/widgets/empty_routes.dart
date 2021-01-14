import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/features/routes/routes_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class EmptyRoutes extends StatelessWidget {
  const EmptyRoutes({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _viewModel = Provider.of<RoutesViewModel>(context);
    return CustomScrollView(
      physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AmadisAssets.on_the_way,
                fit: BoxFit.cover,
                height: hp(20),
              ),
              SizedBox(height: hp(5)),
              Text(
                'SIN RUTAS',
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: hp(3)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: wp(10)),
                child: Text(
                  'No hemos encontrado rutas para el día de hoy.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              SizedBox(height: hp(3)),
              MaterialButton(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text('Refrescar'),
                ),
                color: AmadisColors.secondaryColor,
                onPressed: _viewModel.orderService.getRoutes,
                shape: StadiumBorder(),
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
