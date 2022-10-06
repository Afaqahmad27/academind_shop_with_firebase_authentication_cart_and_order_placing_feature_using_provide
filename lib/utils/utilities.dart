import 'dart:math';
import 'package:flutter/material.dart';

Widget RotateY({required Widget child}) {
  return Transform(
    transform: Matrix4.rotationY(pi),
    alignment: Alignment.center,
    child: child,
  );
}

Widget RotateX({required Widget child}) {
  return Transform(
    transform: Matrix4.rotationX(pi),
    alignment: Alignment.center,
    child: child,
  );
}

class MyUpperClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 30);
    var controlPoint = Offset(size.width / 3 - 15, size.height + 10);
    var endPoint = Offset(size.width / 2 - 10, size.height / 2 + 65);
    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);
    var controlPoint2 = Offset(size.width - 60, size.height / 2);
    var endPoint2 = Offset(size.width, size.height - 15);
    path.quadraticBezierTo(
        controlPoint2.dx, controlPoint2.dy, endPoint2.dx, endPoint2.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

mySnackBar(BuildContext ctx,String msg){
  return ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Theme
          .of(ctx)
          .errorColor,));
}