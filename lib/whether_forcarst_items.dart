import 'package:flutter/material.dart';
class hourlyForcastItems extends StatefulWidget {
  final String time;
  final IconData icon;
  final String temp;
  const hourlyForcastItems({super.key, required this.time, required this.icon, required this.temp});

  @override
  State<hourlyForcastItems> createState() => _hourlyForcastItemsState();
}

class _hourlyForcastItemsState extends State<hourlyForcastItems> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        width: 90,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),

        ),
        child:  Column(
            children:[
              Text(widget.time,style:TextStyle(
                  fontSize: 15,fontWeight: FontWeight.bold
              )),
              Icon(
                widget.icon,
                size: 39,
              ),
              Text(
                widget.temp,
                style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.bold),
              )
            ]
        ),
      ),
    );
  }
}