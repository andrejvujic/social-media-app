import 'package:flutter/material.dart';
import 'package:social_media_app/widgets/solid_button.dart';

class YesNoAlert {
  static Future<void> show(
    BuildContext context, {
    String title = '',
    String text = '',
    Function onYesPressed,
    Function onNoPressed,
  }) async =>
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: AlertDialog(
              title: Text(
                title,
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Poppins-Bold',
                  color: Colors.black,
                ),
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                SolidButton(
                  child: Text(
                    'NE',
                    style: TextStyle(
                      fontFamily: 'Poppins-Bold',
                      fontSize: 16.0,
                      color: Colors.red[600],
                    ),
                  ),
                  highlightColor: Colors.red,
                  splashColor: Colors.red,
                  onPressed: () {
                    onNoPressed?.call();
                    Navigator.pop(context);
                  },
                ),
                SolidButton(
                  child: Text(
                    'DA',
                    style: TextStyle(
                      fontFamily: 'Poppins-Bold',
                      fontSize: 16.0,
                      color: Colors.lightGreen[600],
                    ),
                  ),
                  highlightColor: Colors.green,
                  splashColor: Colors.green,
                  onPressed: () {
                    onYesPressed?.call();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        },
      );
}
