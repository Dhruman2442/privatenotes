class Note {
  final int id;
  final String title;
  final String description;
  final String createdtime;
  final String updatedtime;

  Note(
      {this.id,
        this.title,
        this.description,
        this.createdtime,
        this.updatedtime});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdtime': createdtime,
      'updatedtime': updatedtime,
    };
  }
}
