import 'package:flutter/material.dart';

class Barrier extends StatelessWidget {
  final size;
  Barrier(this.size);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 80,
          height: MediaQuery.of(context).size.height*0.35,
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            border: Border.all(width: 8, color: Colors.black38),
            borderRadius: BorderRadius.circular(
                // topRight: Radius.circular(10), topLeft: Radius.circular(10))),
                10),
          ),
          child: Image.asset('lib/images/building.jpg', fit: BoxFit.fitHeight,),
        ),
      ],
    );
  }
}
