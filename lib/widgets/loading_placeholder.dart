import 'package:flutter/material.dart';

class LoadingPlaceholder extends StatelessWidget {
  final String title, subtitle;
  final bool showProgressIndicator;
  final Widget progressIndicator;
  final Widget child;

  LoadingPlaceholder({
    this.title = '',
    this.subtitle = '',
    this.showProgressIndicator = false,
    this.progressIndicator,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Poppins-Bold',
              fontSize: 20.0,
            ),
          ),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 5.0),
          (showProgressIndicator)
              ? progressIndicator ?? CircularProgressIndicator()
              : Container(
                  width: 0.0,
                  height: 0.0,
                ),
          (child == null) ? Container() : child,
        ],
      ),
    );
  }
}
