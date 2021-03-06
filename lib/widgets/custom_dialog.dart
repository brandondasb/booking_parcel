import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final primaryColor = Colors.red.shade600;
  final grayColor = const Color(0xFF939393);

  final String title, description, primaryButtonText, primaryButtonRoute;
  final String? secondaryButtonText, secondaryButtonRoute;

  CustomDialog(
      {required this.title,
      required this.description,
      required this.primaryButtonText,
      required this.primaryButtonRoute,
      required this.secondaryButtonText,
      required this.secondaryButtonRoute});

  static const double padding = 20.0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(padding),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(padding),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(padding),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 10.0,
                  offset: const Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 24.0),
                AutoSizeText(
                  title,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: primaryColor, fontSize: 25.0),
                ),
                const SizedBox(height: 24.0),
                AutoSizeText(
                  description,
                  maxLines: 4,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: grayColor,
                    fontSize: 18.0,
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context)
                        .pushReplacementNamed(primaryButtonRoute);
                  },
                  color: primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  child: AutoSizeText(
                    primaryButtonText,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w200,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                showSecondaryButton(context)
              ],
            ),
          )
        ],
      ),
    );
  }

  showSecondaryButton(BuildContext context) {
    if (secondaryButtonRoute != null && secondaryButtonText != null) {
      return FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed(secondaryButtonRoute!);
          },
          child: AutoSizeText(
            secondaryButtonText,
            maxLines: 1,
            style: TextStyle(
              fontSize: 18,
              color: primaryColor,
              fontWeight: FontWeight.w400,
            ),
          ));
    } else {
      return const SizedBox(height: 10.0);
    }
  }
}
