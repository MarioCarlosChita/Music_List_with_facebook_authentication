class Music_Header {

  String header_image_thumbnail_url;
  String title;
  String title_with_featured;
  String full_title;

  Music_Header({this.title, this.header_image_thumbnail_url, this.title_with_featured, this.full_title});

  factory Music_Header.jsonFormatter(Map<String , dynamic> map){
      return Music_Header(
         title: map['title'],
         full_title: map['full_title'] ,
         header_image_thumbnail_url: map['header_image_thumbnail_url'] ,
         title_with_featured: map['title_with_featured']
      );
  }



}



