import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uploadimage/view/gallery.dart';

class CaptureImageScreen extends StatefulWidget {
  final ImagePicker imagePicker;
  final Function(List<File>) onImagesUploaded;
  final List<File> existingImages;

  const CaptureImageScreen({Key? key, required this.imagePicker,required this.onImagesUploaded, required this.existingImages}) : super(key: key);

  @override
  _CaptureImageScreenState createState() => _CaptureImageScreenState();
}

class _CaptureImageScreenState extends State<CaptureImageScreen> {
   late final Function(List<File>) onImagesUploaded;

  List<File> _imageFiles = [];
    @override
   void initState() {
     super.initState();
     _imageFiles.addAll(widget.existingImages);
   }

  Future<void> _pickImageFromCamera() async {
    final pickedImage = await widget.imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );

    if (pickedImage != null) {
      setState(() {
        _imageFiles.add(File(pickedImage.path));
      });
    }
  }

  Future<void> _pickImageFromGallery() async {
    final pickedImages = await widget.imagePicker.pickMultiImage(
      imageQuality: 85,
    );

    setState(() {
      _imageFiles.addAll(pickedImages.map((pickedImage) => File(pickedImage.path)).toList());
    });
  }

  void _uploadAndNavigateToGallery() {
  widget.onImagesUploaded(_imageFiles);
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => GalleryScreen(),
  ));
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(width: 10),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                      size: 18,
                    ),
                  ),
                  SizedBox(width: 98),
                  Text(
                    'Upload Image',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 44),
              Container(
                child: Row(
                  children: [
                    Container(
                      color: Color.fromRGBO(245, 245, 245, 1),
                      width: 138,
                      height: 126.25,
                      margin: EdgeInsets.only(left: 44.5),
                      child: Center(
                        child: IconButton(
                          onPressed: _pickImageFromCamera,
                          icon: Icon(Icons.camera_alt),
                        ),
                      ),
                    ),
                    SizedBox(width: 30),
                    Container(
                      child: IconButton(
                        onPressed: _pickImageFromGallery,
                        icon: Icon(Icons.add, size: 30),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: _imageFiles.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: Colors.black,
                        ),
                      ),
                      child: Image.file(
                        _imageFiles[index],
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),
              Container(
                margin: EdgeInsets.only(left: 33, right: 33,bottom: 20),
                width: 323,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(17, 17, 17, 1),
                  ),
                  onPressed: _uploadAndNavigateToGallery,
                  child: const Text('Upload'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

