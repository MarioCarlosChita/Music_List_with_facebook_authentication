import 'dart:io';
import 'package:http/http.dart' as http;

class Controller{
   static  Map<String  ,String> header = {
           'x-rapidapi-host':'genius.p.rapidapi.com',
           'x-rapidapi-key':'b115444ae3msh074215b7270f819p1f54aajsnd45d8756c330'
          };
       static  String  url = 'https://genius.p.rapidapi.com/artists/16775/songs';
}