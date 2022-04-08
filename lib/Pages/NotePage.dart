import 'package:PrivateNotes/Models/notes.dart';
import 'package:PrivateNotes/Module/widgets.dart';
import 'package:PrivateNotes/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

final userdata = GetStorage();
String createtimeread = userdata.read("time");

class Detailpage extends StatefulWidget {
  final Note task;

  Detailpage({this.task});

  @override
  _TaskpageState createState() => _TaskpageState();
}

class _TaskpageState extends State<Detailpage> {
  DatabaseHelper _dbHelper = DatabaseHelper();
  DateTime date_time = DateTime.now();
  int _taskId = 0;
  String _taskTitle = "";
  String _taskDescription = "";

  // DateTime _taskcreatedtime=DateTime.now();
  // DateTime _taskupdatedtime=DateTime.now();
  String _taskcreatedtime = "";
  String _taskupdatedtime = "";

  FocusNode _titleFocus;
  FocusNode _descriptionFocus;
  FocusNode _createdtimeFocus;
  FocusNode _updatedtimeFocus;

  @override
  void initState() {
    if (widget.task != null) {
      // Set visibility to true

      _taskTitle = widget.task.title;
      _taskDescription = widget.task.description;
      _taskId = widget.task.id;
      _taskcreatedtime = widget.task.createdtime;
      _taskupdatedtime = widget.task.updatedtime;
    }

    _titleFocus = FocusNode();
    _descriptionFocus = FocusNode();
    _createdtimeFocus = FocusNode();
    _updatedtimeFocus = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _titleFocus.dispose();
    _descriptionFocus.dispose();
    _createdtimeFocus.dispose();
    _updatedtimeFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 24.0,
                      bottom: 6.0,
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.arrow_back_ios)),
                          ),
                        ),
                        TextTitle(),
                      ],
                    ),
                  ),
                  TextDesc()
                ],
              ),
              Positioned(
                bottom: 24.0,
                right: 24.0,
                child: GestureDetector(
                  onTap: () async {
                    if (_taskId != 0) {
                      await _dbHelper.deleteNote(_taskId);
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Icon(Icons.delete)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget TextTitle() {
    return Expanded(
      child: TextField(
        focusNode: _titleFocus,
        onSubmitted: (value) async {
          userdata.write("time", creationtime);

          // Check if the field is not empty
          if (value != "") {
            // Check if the task is null
            if (widget.task == null) {
              Note _newTask = Note(title: value);
              _taskId = await _dbHelper.insertNote(_newTask);
              setState(() {
                _taskTitle = value;
              });
            } else {
              await _dbHelper.updateNoteTitle(_taskId, value);
              print("Task Updated");
            }
            _descriptionFocus.requestFocus();
          }
        },
        controller: TextEditingController()..text = _taskTitle,
        decoration: InputDecoration(
          hintText: "Enter Task Title",
          border: InputBorder.none,
        ),
        style: TextStyle(
          fontSize: 26.0,
          fontWeight: FontWeight.bold,
          color: Color(0xFF211551),
        ),
      ),
    );
  }

  Widget TextDesc() {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 12.0,
      ),
      child: TextField(
        focusNode: _descriptionFocus,
        onSubmitted: (value) async {
          if (value != "") {
            if (_taskId != 0) {
              await _dbHelper.updateNoteDescription(_taskId, value);
              await _dbHelper.updateNoteTimeCreate(_taskId, _taskcreatedtime);
              await _dbHelper.updateNoteTimeUpdate(_taskId, _taskupdatedtime);

              _taskDescription = value;
            }
          }
        },
        controller: TextEditingController()..text = _taskDescription,
        decoration: InputDecoration(
          hintText: "Enter Description for the task...",
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 24.0,
          ),
        ),
      ),
    );
  }
}
