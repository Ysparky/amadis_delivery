import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:flutter/material.dart';

class Error extends StatelessWidget {
  final String errorMessage;

  final Function onRetryPressed;

  const Error({Key key, this.errorMessage, this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .copyWith(color: AmadisColors.errorColor),
          ),
          SizedBox(height: 8),
          RaisedButton(
            color: AmadisColors.errorColor,
            child: Text(
              'Intentar de nuevo',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.white),
            ),
            onPressed: onRetryPressed,
          )
        ],
      ),
    );
  }
}
