// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../theme/pallete.dart';

class Loader extends StatelessWidget {
  final Color? color;
  const Loader({
    Key? key,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: SpinKitPouringHourGlassRefined(
        color: color != null ? color! : Pallete.whiteColor,
        size: 50.0,
      ),
    );
  }
}
