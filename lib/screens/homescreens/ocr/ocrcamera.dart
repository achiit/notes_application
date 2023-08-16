import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:flutter/services.dart';

class OcrCamera extends StatefulWidget {
  const OcrCamera({super.key});

  @override
  State<OcrCamera> createState() => _OcrCameraState();
}

class _OcrCameraState extends State<OcrCamera> {
  final picker = ImagePicker();
  File? _selectedImage;
  //CroppedFile? croppedFile;
  String _extractedText = '';
  final textRecognizer = TextRecognizer();

  @override
  void dispose() {
    textRecognizer.close();
    super.dispose();
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'New',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.white,
                    fixedSize: Size(450, 50),
                  ),
                  onPressed: _openCamera,
                  child: Row(
                    children: [
                      Icon(
                        Icons.camera_alt,
                        size: 35,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text('Take Photo'),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.white,
                    fixedSize: Size(450, 50),
                  ),
                  onPressed: () {
                    _openGallery(context);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.photo,
                        size: 35,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text('Choose from gallery'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _openCamera() async {
    final image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
        _extractedText =
            ''; // Clear extracted text when a new image is selected
      });
    }
    Navigator.pop(context); // Close the bottom sheet
  }

  Future<void> _openGallery(BuildContext context) async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
        _extractedText =
            ''; // Clear extracted text when a new image is selected
      });
    }
    Navigator.pop(context); // Close the bottom sheet
  }

  void _clearSelectedImage() {
    setState(() {
      _selectedImage = null;
      _extractedText = ''; // Clear extracted text when the image is cleared
    });
  }

  Future<void> _extractTextFromImage() async {
    if (_selectedImage != null) {
      final inputImage = InputImage.fromFile(_selectedImage!);
      final recognisedText = await textRecognizer.processImage(inputImage);
      final extractedText = recognisedText.text;

      setState(() {
        _extractedText = extractedText;
      });

      textRecognizer.close();
    }
  }

  Future<void> _cropImage() async {
    if (_selectedImage != null) {
      try {
        final croppedFile = await ImageCropper().cropImage(
          sourcePath: _selectedImage!.path,
          compressFormat: ImageCompressFormat.jpg,
          compressQuality: 100,
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false,
            ),
            IOSUiSettings(
              title: 'Cropper',
            ),
            WebUiSettings(
              context: context,
              presentStyle: CropperPresentStyle.dialog,
              boundary: const CroppieBoundary(width: 520, height: 520),
              viewPort: const CroppieViewPort(
                width: 480,
                height: 480,
                type: 'circle',
              ),
              enableExif: true,
              enableZoom: true,
              showZoomer: true,
            ),
          ],
        );
        if (croppedFile != null) {
          setState(() {
            _selectedImage = File(croppedFile.path);
            _extractedText =
                ''; // Clear extracted text when a new image is selected
          });
        }
      } catch (e) {
        print('Error cropping image: $e');
      }
    }
  }

  Future<void> _copyTextToClipboard() async {
    if (_extractedText.isNotEmpty) {
      await Clipboard.setData(ClipboardData(text: _extractedText));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Text copied to clipboard')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Image to Text",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.normal),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  _showBottomSheet(context);
                },
                child: Container(
                  width: 400,
                  height: 270,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black)),
                  child: Stack(
                    children: [
                      if (_selectedImage != null)
                        Positioned(
                          top: 8,
                          right: 8,
                          child: GestureDetector(
                            onTap: _cropImage,
                            child: Icon(
                              Icons.crop,
                              color: Colors.red,
                              size: 30,
                            ),
                          ),
                        ),
                      Center(
                        child: _selectedImage != null
                            ? Image.file(
                                _selectedImage!,
                                fit: BoxFit.contain,
                              )
                            : Text(
                                'Click here to select an image.',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Container(
                  width: 400,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black)),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: _extractedText.isNotEmpty
                              ? Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        if (_extractedText.isNotEmpty)
                                          GestureDetector(
                                            onTap: _copyTextToClipboard,
                                            child: Icon(
                                              Icons.copy,
                                              color: Colors.blue,
                                              size: 24,
                                            ),
                                          ),
                                        SizedBox(width: 10),
                                      ],
                                    ),
                                    TextFormField(
                                      initialValue: _extractedText,
                                      onChanged: (text) {
                                        setState(() {
                                          _extractedText = text;
                                        });
                                      },
                                      maxLines: null,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ],
                                )
                              : Text(
                                  'Click the "Scan Image" button to perform scan',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _selectedImage != null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: _extractTextFromImage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffFFB347), // Background color
                    onPrimary: Colors.white, // Text color
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 4,
                  ),
                  child: Text(
                    "Scan Image",
                    style: TextStyle(fontSize: 16),
                  ),
                )
              ],
            )
          : SizedBox(),
    );
  }
}
