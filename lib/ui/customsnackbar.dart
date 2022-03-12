import 'package:flutter/material.dart';

class CustomSnackBar extends SnackBar {

  CustomSnackBar({
    Key? key,
    required String message,
    Duration duration = const Duration( seconds: 2 ),
    String btnLabel = 'OK',
    VoidCallback? onPresed
  }) : super(
    key: key,
    content: Text( message ),
    duration: duration,
    action: SnackBarAction(
      label: btnLabel,
      onPressed: (){
        if( onPresed != null ) {
          onPresed();
        }
      },
    )
  );

}