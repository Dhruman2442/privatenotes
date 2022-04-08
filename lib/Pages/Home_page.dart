import 'package:PrivateNotes/Models/notes.dart';
import 'package:PrivateNotes/Module/widgets.dart';
import 'package:PrivateNotes/Pages/NotePage.dart';
import 'package:PrivateNotes/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatefulWidget {
  final Note note;

  Homepage({this.note});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController editingController = TextEditingController();
  DatabaseHelper _dbHelper = DatabaseHelper();
  final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
  var items = <String>[];
  String _taskTitle = "";
  String _taskDescription = "";
  get id => null;
  @override
  void initState() {
    if (widget.note != null) {
      // Set visibility to true
      _taskTitle = widget.note.title;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Private Notes",
            style: GoogleFonts.balooBhai(fontSize: 35, color: Colors.black)),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          color: Color(0xFFF6F6F6),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onTap: () {
                        Expanded(
                          child: FutureBuilder(
                            initialData: [],
                            future: _dbHelper.getSearchNotes(_taskTitle),
                            builder: (context, snapshot) {
                              return Expanded(
                                child: _taskTitle.isNotEmpty
                                    ? ListView.builder(
                                        itemCount: _taskTitle.length,
                                        itemBuilder: (context, index) => Card(
                                          key: ValueKey(_taskTitle[index][id]),
                                          color: Colors.amberAccent,
                                          elevation: 4,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: ListTile(
                                            leading: Text(
                                              _taskTitle[index][id].toString(),
                                              style:
                                                  const TextStyle(fontSize: 24),
                                            ),
                                            title:
                                                Text(_taskTitle[index][index]),
                                            subtitle: Text(_taskDescription),
                                          ),
                                        ),
                                      )
                                    : const Text(
                                        'No results found',
                                        style: TextStyle(fontSize: 24),
                                      ),
                              );
                            },
                          ),
                        );
                      },
                      controller: editingController,
                      decoration: InputDecoration(
                          labelText: "Search",
                          hintText: "Search",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)))),
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder(
                      initialData: [],
                      future: _dbHelper.getNotes(),
                      builder: (context, snapshot) {
                        return ScrollConfiguration(
                          behavior: NoGlowBehaviour(),
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Detailpage(
                                        task: snapshot.data[index],
                                      ),
                                    ),
                                  ).then(
                                    (value) {
                                      setState(() {});
                                    },
                                  );
                                },
                                child: TaskCardWidget(
                                  title: snapshot.data[index].title,
                                  desc: snapshot.data[index].description,
                                  // createtime: snapshot.data[index].createdtime,
                                  // updatetime: snapshot.data[index].updatetime,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 24.0,
                right: 0.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Detailpage(
                                task: null,
                              )),
                    ).then((value) {
                      setState(() {});
                    });
                  },
                  child: Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0xFF7349FE), Color(0xFF643FDB)],
                            begin: Alignment(0.0, -1.0),
                            end: Alignment(0.0, 1.0)),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Icon(
                        Icons.add_circle,
                        size: 30,
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
