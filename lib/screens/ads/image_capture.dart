import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:realestate/model/user.dart';
import 'package:realestate/screens/ads/post_Ad_Screen.dart';
import 'package:realestate/screens/home/bottom_navigation_bar.dart';
import 'package:realestate/services/database.dart';

/// Widget to capture and crop the image
class ImageCapture extends StatefulWidget {
  createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  /// Active image file
  File _imageFile;

  /// Cropper plugin
  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
        sourcePath: _imageFile.path,
        //toolbarColor: Colors.purple,
        //toolbarWidgetColor: Colors.white,
        //toolbarTitle: 'Crop It'
    );

    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  /// Select an image via gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);

    setState(() {
      _imageFile = selected;
    });
  }

  /// Remove image
  void _clear() {
    setState(() => _imageFile = null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.red[600],
        centerTitle: true,
        title: Column(children: [
          Text(
            "Post an Ad",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
          Text(
            "Upload an Image",
            style: TextStyle(
              color: Colors.white54,
              fontSize: 17,
            ),
          ),
        ]),
      ),
      // Select an image from the camera or gallery
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            RaisedButton.icon(
              icon: Icon(Icons.photo_camera),
              color: Colors.red,
              textColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              label: Text("Capture"),
              onPressed: () => _pickImage(ImageSource.camera),
            ),
            SizedBox(width: 20,),
            RaisedButton.icon(
              icon: Icon(Icons.photo_library),
              color: Colors.red,
              textColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              label: Text("Gallery"),
                onPressed: () => _pickImage(ImageSource.gallery),
            ),
            /*IconButton(
              icon: Icon(Icons.photo_camera),
              onPressed: () => _pickImage(ImageSource.camera),
            ),
            IconButton(
              icon: Icon(Icons.photo_library),
              onPressed: () => _pickImage(ImageSource.gallery),
            ),*/
          ],
        ),
      ),

      // Preview the image and crop it
      body: ListView(
        children: <Widget>[
          if (_imageFile != null) ...[
            Image.file(_imageFile),
            Row(
              children: <Widget>[
                FlatButton(
                  child: Icon(Icons.crop),
                  onPressed: _cropImage,
                ),
                FlatButton(
                  child: Icon(Icons.refresh),
                  onPressed: _clear,
                ),
              ],
            ),

            Uploader(file: _imageFile)
          ]
        ],
      ),
    );
  }
}

/// Widget used to handle the management of
class Uploader extends StatefulWidget {
  final File file;

  Uploader({Key key, this.file}) : super(key: key);

  createState() => _UploaderState();
}


class _UploaderState extends State<Uploader> {
  final FirebaseStorage _storage = FirebaseStorage(
      storageBucket: 'gs://rental-life-in-real-estate.appspot.com');

  StorageUploadTask _uploadTask;
  String filePath = '';
  /// Starts an upload task
  void _startUpload() {
    /// Unique file name for the file
    //filePath = 'Ads/userId/${DateTime.now()}.png';

    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    filePath = 'Ads/${user.uid}/Image1.png';
    if (_uploadTask != null) {
      //filePath= 'Ads/${DateTime.now()}.png';
      /// Manage the task state and event subscription with a StreamBuilder
      return StreamBuilder<StorageTaskEvent>(
          stream: _uploadTask.events,
          builder: (_, snapshot) {
            var event = snapshot?.data?.snapshot;

            double progressPercent = event != null
                ? event.bytesTransferred / event.totalByteCount
                : 0;

            return Column(
              children: [
                if (_uploadTask.isComplete) Text('🎉 Ad Posted Successfully 🎉'),
                  RaisedButton(
                    color: Colors.red,
                    textColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text("Back"),
                    onPressed: ()  {
                      Navigator.pop(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ImageCapture()),
                      );
                      Navigator.pop(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PostAd()),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BottomNavigationWidget()),
                      );
                    },
                  ),


                if (_uploadTask.isPaused)
                  FlatButton(
                    child: Icon(Icons.play_arrow),
                    onPressed: _uploadTask.resume,
                  ),

                if (_uploadTask.isInProgress)
                  FlatButton(
                    child: Icon(Icons.pause),
                    onPressed: _uploadTask.pause,
                  ),

                // Progress bar
                LinearProgressIndicator(value: progressPercent),
                Text('${(progressPercent * 100).toStringAsFixed(2)} % '),
              ],
            );
          });
    } else {
      // Allows user to decide when to start the upload
      return
        RaisedButton.icon(

          icon: Icon(Icons.cloud_upload),
          color: Colors.red,
          textColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
          ),
          label: Text('Upload Ad'),

          onPressed: _startUpload,
        );

        /*FlatButton.icon(
        label: Text('Upload to Firebase'),
        icon: Icon(Icons.cloud_upload),
        onPressed: _startUpload,
      );*/
    }
  }
}

