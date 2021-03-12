import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


void main() => runApp(
  new MaterialApp(
    title: "Camera Gallery Sample App",
    home: LandingScreen(),
  )
);

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  File imageFile;
  final picker = ImagePicker();

  Future openCamera(BuildContext context) async {
    final pickImage = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if(pickImage != null){
        imageFile = File(pickImage.path);
      }
      else{
        print("No Image Selected");
      }

    });
    Navigator.of(context).pop();
  }

  Future openGallery(BuildContext context) async {
    final pickImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if(pickImage != null){
        imageFile = File(pickImage.path);
      }
      else{
        print("No Image Selected");
      }
    });
    Navigator.of(context).pop();
  }

  Widget setImage(){
    if(imageFile == null){
      return Text("No Image Selected");
    }else{
      return Image.file(imageFile,width: 500,height: 500);
    }
  }

  Future<Void> showChoiceDialog(BuildContext buildContext){
    return showDialog(context: context,builder: (BuildContext context){
      return AlertDialog(
        title: Text("Select any one option!!"),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: Text("Camera"),
                onTap: (){
                  openCamera(context);
                },
              ),
              Padding(padding: EdgeInsets.all(8.0),),
              GestureDetector(
                child: Text("Gallery"),
                onTap: (){
                  openGallery(context);
                },
              )
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Camera Gallery Sample App"),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              setImage(),
              RaisedButton(onPressed: (){
                  showChoiceDialog(context);
              }, child: Text("Select Image"),)
            ],
          ),
        )
      ),
    );
  }

}


