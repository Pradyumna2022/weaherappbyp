import 'package:flutter/material.dart';


class AdditionalInfoItems extends StatefulWidget {
  final IconData icon;
  final String name;
  final String value;
  const AdditionalInfoItems({super.key, required this.icon, required this.name, required this.value});

  @override
  State<AdditionalInfoItems> createState() => _AdditionalInfoItemsState();
}

class _AdditionalInfoItemsState extends State<AdditionalInfoItems> {
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Icon(widget.icon,size: 32,),
        SizedBox(
          height: 5,
        ),
        //w
        Text(widget.name,style: TextStyle(
            fontSize: 14
        ),),
        SizedBox(
          height: 5,
        ),
        //w
        Text(widget.value,style: TextStyle(
            fontSize: 14
        ),)
      ],
    );
  }
}
