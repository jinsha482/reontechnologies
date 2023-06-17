import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GalleryScreen extends StatefulWidget {
  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  List<File> imageFiles = [];
  List<bool> _selectedImages = [];
  bool _isEditMode = false;

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    Directory cacheDir = await getTemporaryDirectory();
    imageFiles = cacheDir.listSync().whereType<File>().toList();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<bool> selectedImages = List<bool>.filled(imageFiles.length, false);
    List<String> selectedImagePaths = prefs.getStringList('selectedImages') ?? [];
    for (String imagePath in selectedImagePaths) {
      int index = imageFiles.indexWhere((file) => file.path == imagePath);
      if (index != -1) {
        selectedImages[index] = true;
      }
    }

    setState(() {
      _selectedImages = selectedImages;
    });
  }

  Future<void> _saveSelectedImages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> selectedImagePaths = [];
    for (int i = 0; i < _selectedImages.length; i++) {
      if (_selectedImages[i]) {
        selectedImagePaths.add(imageFiles[i].path);
      }
    }
    await prefs.setStringList('selectedImages', selectedImagePaths);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Container(
        margin: EdgeInsets.only(top: 70),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 9),
                  width: 62,
                  height: 62,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/image 302 (1).png'),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 80),
                      child: Text(
                        'Welcome Back',
                        style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(height: 4),
                    Container(
                      margin: EdgeInsets.only(left: 80),
                      child: Text(
                        'Edwin Joseph',
                        style: TextStyle(
                          color: Color.fromRGBO(74, 74, 74, 1),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),SizedBox(height:50),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                ),
                itemCount: imageFiles.length,
                itemBuilder: (context, index) {
                  File imageFile = imageFiles[index];
                  bool isSelected = _selectedImages[index];

                  return GestureDetector(
                    onTap: () {
                      if (_isEditMode) {
                        setState(() {
                          _selectedImages[index] = !_selectedImages[index];
                          _saveSelectedImages();
                        });
                      } else {
                       
                      }
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: 170,
                          height: 190,
                          margin: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              width: 2,
                              color: isSelected ? Colors.blue : Colors.black26,
                            ),
                          ),
                          child: Image.file(
                            imageFile,
                            fit: BoxFit.cover,
                          ),
                        ),
                        if (_isEditMode)
                          Positioned(
                            top: 4,
                            right: 4,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Checkbox(
                                value: isSelected,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedImages[index] = value!;
                                    _saveSelectedImages();
                                  });
                                },
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
            if (!_isEditMode)
              Container(
                width: 136,
                height: 44,
                margin: EdgeInsets.only(left: 126, right: 16, bottom: 40),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    onPrimary: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _isEditMode = true;
                    });
                  },
                  icon: Icon(Icons.edit),
                  label: Text('Edit'),
                ),
              ),
            if (_isEditMode)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 126, right: 16, bottom: 40),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          onPrimary: Colors.white,
                        ),
                        onPressed: _selectAllImages,
                        child: Text('Select All'),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16, right: 126, bottom: 40),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          onPrimary: Colors.white,
                        ),
                        onPressed: () {
                          _showDeleteConfirmation();
                        },
                        child: Text('Delete'),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _selectAllImages() {
    setState(() {
      bool allSelected = !_isAllSelected();
      _selectedImages = List<bool>.filled(imageFiles.length, allSelected);
      _saveSelectedImages();
    });
  }

  bool _isAllSelected() {
    return _selectedImages.every((isSelected) => isSelected);
  }

  List<File> _getSelectedFiles() {
    List<File> selectedFiles = [];
    for (int i = 0; i < _selectedImages.length; i++) {
      if (_selectedImages[i]) {
        selectedFiles.add(imageFiles[i]);
      }
    }
    return selectedFiles;
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Confirmation'),
          content: Text('Are you sure you want to delete the selected image(s)?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _deleteSelectedImages();
                Navigator.of(context).pop(); 
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _deleteSelectedImages() {
    List<File> selectedFiles = _getSelectedFiles();

    // Delete the selected files
    for (File file in selectedFiles) {
      if (file.existsSync()) {
        file.deleteSync();
      } else {
        print('File not found: ${file.path}');
      }
    }

    // Show notification
    Fluttertoast.showToast(
      msg: 'Deleted ${selectedFiles.length} image(s)',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );

    setState(() {
      imageFiles.removeWhere((file) => selectedFiles.contains(file));
      _selectedImages = List<bool>.filled(imageFiles.length, false);
      _saveSelectedImages();
      _isEditMode = false;
    });
  }
}
