import 'package:flutter/material.dart';
import 'package:social_media_app/widgets/solid_button.dart';

class InfoAlert {
  static Future<void> show(BuildContext context,
      {String title, String text}) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: AlertDialog(
            title: Text(
              title,
              style: TextStyle(fontSize: 20.0, fontFamily: 'Poppins-Bold'),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              SolidButton(
                child: Text(
                  'OK',
                  style: TextStyle(
                    fontFamily: 'Poppins-Bold',
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }
}
