import 'package:flutter/widgets.dart';

class ShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height - 70);

    Offset firstEndPoint = Offset(size.width * .5, size.height - 30.0);
    Offset firstControlPoint = Offset(size.width * 0.25, size.height - 50.0);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    Offset secondEndPoint = Offset(size.width, size.height - 50.0);
    Offset secondControlPoint = Offset(size.width * .75, size.height - 10);
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}
