import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'package:amadis_delivery/core/utils/utils.dart';

class LoadingOverlay<T extends AmadisViewModel> extends StatelessWidget {
  const LoadingOverlay({
    Key key,
    @required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final _baseAmadisViewModel = Provider.of<T>(context);
    final isLoading = _baseAmadisViewModel?.isLoading ?? false;
    return Stack(
      children: [
        child,
        LoadingIndicator(isLoading: isLoading),
      ],
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    Key key,
    this.isLoading,
  }) : super(key: key);

  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
            height: hp(100),
            width: hp(100),
            color: Colors.black.withOpacity(0.4),
            child: SpinKitWave(
              color: AmadisColors.primaryColor,
              size: wp(15),
            ),
          )
        : Container();
  }
}
