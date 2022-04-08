import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final now = DateTime.now();
String creationtime = DateFormat('y-M-d').format(now);

class TaskCardWidget extends StatefulWidget {
  final String title;
  final String desc;
  final String createtime;
  final String updatetime;

  TaskCardWidget({this.title, this.desc, this.createtime, this.updatetime});

  @override
  State<TaskCardWidget> createState() => _TaskCardWidgetState();
}

class _TaskCardWidgetState extends State<TaskCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 32.0,
        horizontal: 24.0,
      ),
      margin: EdgeInsets.only(
        bottom: 20.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  widget.title ?? "(Unnamed Task)",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Color(0xFF211551),
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    child: Text(
                      "Created on:" + creationtime,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Color(0xFF211551),
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      "Updated on:" + creationtime,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Color(0xFF211551),
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 10.0,
            ),
            child: Container(
              width: 200,
              child: Text(
                widget.desc ?? "No Description Added",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  height: 1.5,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class NoGlowBehaviour extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
