import 'package:amadis_delivery/core/utils/loading_overlay.dart';
import 'package:amadis_delivery/core/widgets/widgets.dart';
import 'package:amadis_delivery/features/map_route/map_route_view_model.dart';
import 'package:amadis_delivery/models/models.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapRoutePage extends StatelessWidget {
  const MapRoutePage({
    Key key,
    this.myRoute,
  }) : super(key: key);

  final MyRoute myRoute;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MapRouteViewModel(myRoute),
        ),
      ],
      child: LoadingOverlay<MapRouteViewModel>(
        child: MapRoutePageBase(),
      ),
    );
  }
}

class MapRoutePageBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _viewModel = Provider.of<MapRouteViewModel>(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomFloatingButton(
              icon: Icon(Icons.arrow_back_ios_rounded),
              onPressed: _viewModel.goBack,
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: GoogleMap(
              initialCameraPosition: _viewModel.cameraPosition,
              markers: _viewModel.allMarkers.toSet(),
              polylines: _viewModel.currentRoute,
              onMapCreated: _viewModel.onMapCreated,
            ),
          ),
        ],
      ),
    );
  }
}
