
import 'package:flutter/material.dart';
import 'package:uploadimage/view/splashscreen.dart';



void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   List<File> _storedImages = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadStoredImages();
//   }

//   Future<void> _loadStoredImages() async {
//     final prefs = await SharedPreferences.getInstance();
//     final imagePathList = prefs.getStringList('imagePaths');
//     if (imagePathList != null) {
//       setState(() {
//         _storedImages = imagePathList.map((path) => File(path)).toList();
//       });
//     }
//   }

//   Future<void> _uploadImage() async {
//     final imagePicker = ImagePicker();
//     final pickedImage = await showDialog(
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//         title: Text('Upload Image'),
//         content: Text('Choose image from:'),
//         actions: <Widget>[
//           ElevatedButton(
//             child: Text('Gallery'),
//             onPressed: () async {
//               Navigator.of(context).pop(await imagePicker.getImage(
//                 source: ImageSource.gallery,
//                 imageQuality: 85,
//               ));
//             },
//           ),
//          ElevatedButton(
//             child: Text('Camera'),
//             onPressed: () async {
//               Navigator.of(context).pop(await imagePicker.getImage(
//                 source: ImageSource.camera,
//                 imageQuality: 85,
//               ));
//             },
//           ),
//         ],
//       ),
//     );

//     if (pickedImage == null) return;

//     final imageFile = File(pickedImage.path);
//     setState(() {
//       _storedImages.add(imageFile);
//     });

//     final appDir = await syspaths.getApplicationDocumentsDirectory();
//     final fileName = path.basename(imageFile.path);
//     final savedImage = await imageFile.copy('${appDir.path}/$fileName');

//     final prefs = await SharedPreferences.getInstance();
//     final imagePathList = prefs.getStringList('imagePaths') ?? [];
//     imagePathList.add(savedImage.path);
//     prefs.setStringList('imagePaths', imagePathList);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image Upload and Gallery'),
//       ),
//       body: Column(
//         children: [
//          ElevatedButton(
//             child: Text('Upload Image'),
//             onPressed: _uploadImage,
//           ),
//         ElevatedButton(
//             child: Text('View Gallery'),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (ctx) => GalleryScreen(_storedImages),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class GalleryScreen extends StatelessWidget {
//   final List<File> images;

//   GalleryScreen(this.images);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image Gallery'),
//       ),
//       body: GridView.builder(
//         itemCount: images.length,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           childAspectRatio: 1,
//           crossAxisSpacing: 10,
//           mainAxisSpacing: 10,
//         ),
//         itemBuilder: (ctx, index) => Image.file(
//           images[index],
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   }
// }
