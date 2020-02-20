import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:estudo_http/Music_Header.dart';
import 'package:estudo_http/screen_pages/music_user_perfil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:estudo_http/Setting_Controller/Controller.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class Main_Page_App extends StatefulWidget{
    @override
  State<StatefulWidget> createState() {
     return  MainPage();
  }

}

class MainPage extends State<Main_Page_App>{


    List<Music_Header> Lista_Completa =  []  ;
    Future<void> getMusic()async{

      var response  = await http.get(Controller.url, headers:Controller.header).then((response){
           var httpresponse  = json.decode(response.body);
           if(response.statusCode >=200 && response.statusCode <=400){
             var  req =  json.decode(response.body);
             List<dynamic> lista =  req['response']['songs'];
             // inserido os songs na list
             for(int i = 0;  i<lista.length;  ++i)
                setState((){
                  Lista_Completa.add(Music_Header.jsonFormatter(lista[i]));
                });
             // fim da list
           }else{
             showDialog(context: context  , builder: (context){
                  return AlertDialog(
                    title: Text('Server Information'),
                    actions: <Widget>[
                        Text('Seens there is a error in server!')
                    ],
                  );
             });
           }

        });


   }
   @override

   initState(){
      getMusic();
   }


  Widget build(BuildContext context) {
      return Scaffold(
          appBar: new AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(icon: Icon(Icons.arrow_back , size: 23, color: Colors.grey,), onPressed: (){}),
               centerTitle: true,
               title: Text('Music Songs' , style: TextStyle(
                   color: Colors.blueAccent,
                   fontSize: 23 ,
                   fontWeight: FontWeight.bold ,
               ),),
               actions: <Widget>[
                    IconButton(icon: Icon(Icons.shop ,size: 23, color: Colors.grey,), onPressed: (){})
               ],
              elevation: 0,
          ),

        body: Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                      Container(
                          padding: EdgeInsets.only(
                              top: 30 ,
                              left: 20 ,
                              right:20 ,
                          ),
                         child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: <Widget>[
                                 Container(
                                     padding:EdgeInsets.all(
                                       5
                                     ),
                                     child: Text('All Songs' , style: TextStyle(
                                       color: Colors.black ,
                                       fontSize: 14,
                                     ),) ,
                                     decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(10)
                                     ),
                                 ) ,
                                 Text('See More' , style: TextStyle(
                                     color:Colors.blueAccent ,
                                 ),)
                             ],
                         ),
                      ) ,
                      SizedBox(height:5,),
                      Container(
                          height:200,
                          padding: EdgeInsets.only(
                             top: 10,
                             left: 5,
                          ),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                               itemCount:Lista_Completa?.length,
                               itemBuilder: (context ,index){
                                 return InkWell(
                                   onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder:(context) => Music_user_perfil()));                                   },
                                   child:Container(
                                   width: 150,
                                   height: 200,
                                   padding: EdgeInsets.only(
                                     top: 110 ,
                                   ),
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.center,
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: <Widget>[
                                       Container(
                                         width: double.maxFinite,
                                         height: 80,
                                         padding: EdgeInsets.only(
                                           left: 10 ,
                                         ),
                                         child:Row(
                                           mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                           children: <Widget>[
                                             Text(
                                               palavra(Lista_Completa[index].full_title),textAlign:TextAlign.justify, style: TextStyle(
                                                 fontSize:14
                                             ),) ,
                                             IconButton(icon:Icon(Icons.favorite_border), onPressed: (){})
                                           ],
                                         ),
                                         decoration: BoxDecoration(
                                             color: Colors.white.withOpacity(0.7)
                                         ),
                                       )
                                     ],
                                   ),
                                   margin: EdgeInsets.only(
                                       left:5 ,
                                       right: 10
                                   ),
                                   decoration: new BoxDecoration(
                                       borderRadius: BorderRadius.circular(10),
                                       image: new DecorationImage(image: new NetworkImage(Lista_Completa[index].header_image_thumbnail_url),
                                           fit: BoxFit.cover)
                                   ),
                                 ),
                                 );
                             }),
                      )

                  ],
              ),
        ),
      );
  }
  String palavra(String   expre){
     // pegando palavras
       List<String> lista = expre.split(" ");
       return lista[0];
     // fim dos conteudos;
   }
}