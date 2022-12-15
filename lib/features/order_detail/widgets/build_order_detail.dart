import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/features/order_detail/order_detail_view_model.dart';
import 'package:amadis_delivery/features/order_detail/widgets/widgets.dart';

class BuildOrderDetail extends StatelessWidget {
  const BuildOrderDetail({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _viewModel = Provider.of<OrderDetailViewModel>(context);
    return Stack(
      children: [
        Positioned(
          left: 0,
          top: 0,
          height: hp(30),
          width: wp(100),
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(
                _viewModel.fullOrder?.location?.coordinates?.latitude,
                _viewModel.fullOrder?.location?.coordinates?.longitude,
              ),
              zoom: 15,
            ),
            onMapCreated: _viewModel.onMapCreated,
            markers: _viewModel.setCustomerMarker(),
            rotateGesturesEnabled: false,
            scrollGesturesEnabled: false,
            zoomControlsEnabled: false,
            zoomGesturesEnabled: false,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          height: hp(75),
          width: wp(100),
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(40.0)),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                color: AmadisColors.backgroundColor,
                padding:
                    EdgeInsets.symmetric(horizontal: wp(5), vertical: hp(2)),
                child: Column(
                  children: [
                    OrderDataCard(order: _viewModel.fullOrder),
                    SizedBox(height: hp(2)),
                    CustomerDataCard(),
                    SizedBox(height: hp(2)),
                    OrderDetailCard(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
