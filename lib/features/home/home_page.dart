import 'package:amadis_delivery/features/home/home_view_model.dart';
import 'package:flutter/material.dart';

import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/core/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
      ],
      child: LoadingOverlay<HomeViewModel>(child: HomePageBase()),
    );
  }
}

class HomePageBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _viewModel = Provider.of<HomeViewModel>(context);
    return Scaffold(
      backgroundColor: AmadisColors.primaryColor,
      appBar: CustomAppBar(
        headerTitle: 'Home',
        headerActions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: _viewModel.logOut,
          )
        ],
      ),
      body: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(50.0)),
        child: Container(
          height: hp(100),
          width: wp(100),
          color: AmadisColors.backgroundColor,
          padding: EdgeInsets.symmetric(
            horizontal: wp(4),
            vertical: hp(3),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  ..._viewModel.daysOfWeek.asMap().entries.map((e) {
                    final idx = e.key;
                    final dayOfWeek = e.value;
                    return DayIndicator(
                      day: _viewModel.days[idx],
                      dayOfWeek: dayOfWeek,
                      isToday: _viewModel.today == _viewModel.days[idx],
                    );
                  })
                ],
              ),
              Spacer(),
              Material(
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
                                Icons.delivery_dining,
                                color: Color(0xffbd4341),
                              ),
                            ),
                          ),
                          SizedBox(width: wp(5)),
                          Text(
                            '2',
                            style: Theme.of(context)
                                .textTheme
                                .headline2
                                .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Text(
                        'Rutas restantes por repartir',
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: hp(3)),
              Material(
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
                                Icons.ac_unit,
                                color: Color(0xffbd4341),
                              ),
                            ),
                          ),
                          SizedBox(width: wp(5)),
                          Text(
                            '8',
                            style: Theme.of(context)
                                .textTheme
                                .headline2
                                .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: hp(1)),
                      Text(
                        'Pedidos entregados',
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(fontStyle: FontStyle.italic),
                      ),
                    ],
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
