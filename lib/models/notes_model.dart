class Note {
  int? id, userId;
  String? title, content, image;

  Note.view({required Map<String, dynamic> data}){
    id = data['id'];
    title = data['title'];
    userId = data['user_id'];
    content = data['content'];
    image = data['image'];
  }
}

/*
id
title
user_id
content
image
*/