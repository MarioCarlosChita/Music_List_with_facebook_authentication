import 'package:estudo_http/main.dart';
import 'package:estudo_http/screen_pages/Main_Page_App.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:convert' as JSON;


class Index extends State<MainIndex>{

  bool _isLoggedIn =  false;
  Map userProfile;



  final facebookLogin =  FacebookLogin();
  // implementando a parte da configuracao  com o facebook
  _loginWithFB() async{
    final result = await facebookLogin.logInWithReadPermissions(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
        final profile = JSON.jsonDecode(graphResponse.body);
        print(profile);
        setState(() {
          userProfile = profile;
          _isLoggedIn = true;
        });
        break;

      case FacebookLoginStatus.cancelledByUser:
        setState(() => _isLoggedIn = false );
        break;
      case FacebookLoginStatus.error:
        setState(() => _isLoggedIn = false );
        break;
    }

  }

  _logout(){
    facebookLogin.logOut();
    setState(() {
      _isLoggedIn = false;
    });
  }


  // fim da implementacao da parte authenticacao com facebook

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<FirebaseUser> _handleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
    print("signed in " + user.displayName);
    return user;
  }
  @override
  Widget build(BuildContext context) {
      return Scaffold(

            body:Container(
                alignment: Alignment.center,
                width: double.maxFinite,
                height: double.maxFinite,
                 decoration: BoxDecoration(
                    image:DecorationImage(
                        image: AssetImage('assets/logo2.jpeg') ,
                        fit: BoxFit.cover
                    )
                 ),

                 child: SingleChildScrollView(
                     child: Column(
                         children: <Widget>[
                               Text("Music Songs" , style: TextStyle(
                                   color: Colors.white,
                                   fontWeight: FontWeight.bold,
                                   fontSize: 42,
                               ),) ,
                               SizedBox(height: 60,),
                               ButtonTheme(
                                   minWidth: 200,
                                   height: 60,
                                   child: FlatButton(
                                      color: Colors.redAccent,
                                       shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10)
                                       ),
                                       onPressed:(){
                                         _handleSignIn().then((FirebaseUser user){
                                             print(user.email);
                                         });
                                       },
                                       child: Text('Google' ,style: TextStyle(
                                         color: Colors.white ,
                                         fontSize: 11,
                                       ),)
                                   ),
                               ) ,
                               SizedBox(height:5,) ,
                              ButtonTheme(
                                   minWidth: 200,
                                   height: 60,
                                   shape: RoundedRectangleBorder(
                                       borderRadius: BorderRadius.circular(10)
                                   ),
                                   child:FlatButton(
                                       color: Colors.blue,
                                       onPressed:  (){
                                         _loginWithFB();
                                       },
                                       child: Text('facebook' , style: TextStyle(
                                         color:Colors.white
                                       ),)
                                   )
                              )

                         ],
                     ),
                 ),
            ),
      ) ;
  }


}