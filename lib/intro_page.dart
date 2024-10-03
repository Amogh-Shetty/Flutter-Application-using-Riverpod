// import 'package:flutter/material.dart';
// import 'package:flutterprojects/home_page.dart';
//
// class IntroPage extends StatelessWidget {
//   const IntroPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//     body:Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(80.0),
//           child:Image.asset('lib/Images/Image1.jpg'),
//         ),
//         const Padding(
//             padding: const EdgeInsets.all( 24.0),
//             child:Text(
//               "We are here to deliver the fresh Groceries",
//               textAlign:TextAlign.center,
//               style: TextStyle(
//                 fontSize: 40,
//                 fontWeight: FontWeight.bold,
//               ),
//             )
//         ),
//         Text("Online Any Time",
//           style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Colors.grey
//
//           ),
//         ) ,
//
//         GestureDetector(
//           onTap: ()=>Navigator.pushReplacement(context,MaterialPageRoute(
//             builder: (context){
//               return HomePage();
//
//             },
//
//           )),
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.blue,
//               borderRadius: BorderRadius.circular(12),
//
//             ),
//             padding:  const EdgeInsets.all(24),
//             child:const Text(
//               "Order Now",
//             ),
//           ),
//         )
//
//       ],
//
//     )
//     );
//
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }
//
//
//
// import 'dart:io';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:image_picker/image_picker.dart';
//
// import 'model/cart_model.dart';
//
//
// class PhotoUploadPage extends StatefulWidget {
//   @override
//   _PhotoUploadPageState createState() => _PhotoUploadPageState();
// }
//
// class _PhotoUploadPageState extends State<PhotoUploadPage> {
//   final ImagePicker _picker = ImagePicker();
//
//   Future<void> pickImage() async {
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       await saveImageLocally(image);
//     }
//   }
//
//   Future<void> saveImageLocally(XFile image) async {
//     var box = Hive.box<Photo>('photos');
//     final newPath = 'C:/Users/Amogha/Documents/flutterprojects/assets/Images/';
//     await box.add(Photo(newPath));
//     print('Image saved at $newPath');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Photo Upload Example')),
//       body: ValueListenableBuilder<Box<Photo>>(
//         valueListenable: Hive.box<Photo>('photos').listenable(),
//         builder: (context, box, _) {
//           if (box.isEmpty) {
//             return Center(child: Text('No images uploaded yet.'));
//           }
//           return GridView.builder(
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 3,
//               crossAxisSpacing: 8.0,
//               mainAxisSpacing: 8.0,
//             ),
//             itemCount: box.length,
//             itemBuilder: (context, index) {
//               final photo = box.getAt(index);
//               return Image.file(File(photo!.imagePath));
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: pickImage,
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:convert'; // For base64 encoding/decoding
// // import 'dart:html' as html;
//
// import 'model/cart_model.dart'; // For web file handling (only used in web)
//
// // part 'cart_model.g.dart'; // Ensure this matches your model class
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Hive.initFlutter();
//   Hive.registerAdapter(PhotoAdapter());
//   await Hive.openBox<Photo>('photos');
//
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Photo Upload Example',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: PhotoUploadPage(),
//     );
//   }
// }
//
// class PhotoUploadPage extends StatefulWidget {
//   @override
//   _PhotoUploadPageState createState() => _PhotoUploadPageState();
// }
//
// class _PhotoUploadPageState extends State<PhotoUploadPage> {
//   final ImagePicker _picker = ImagePicker();
//
//   Future<void> pickImage() async {
//     if (kIsWeb) {
//       await pickImageWeb();
//     } else {
//       await pickImageMobile();
//     }
//   }
//
//   Future<void> pickImageWeb() async {
//     final html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
//     uploadInput.accept = 'image/*'; // Accept only images
//     uploadInput.click(); // Trigger file selection dialog
//
//     uploadInput.onChange.listen((e) async {
//       final files = uploadInput.files;
//       if (files!.isEmpty) return;
//
//       final reader = html.FileReader();
//       reader.readAsDataUrl(files[0]); // Read file as Data URL (base64)
//
//       reader.onLoadEnd.listen((e) async {
//         final base64String = reader.result as String; // Get base64 string
//         await saveImageLocally(base64String); // Save base64 string to Hive
//       });
//     });
//   }
//
//   Future<void> pickImageMobile() async {
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       await saveImageLocally(image.path); // Save path for mobile
//     }
//   }
//
//   Future<void> saveImageLocally(String imagePath) async {
//     var box = Hive.box<Photo>('photos');
//     await box.add(Photo(imagePath)); // Save as base64 for web or path for mobile
//     print('Image saved at $imagePath');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Photo Upload Example')),
//       body: ValueListenableBuilder<Box<Photo>>(
//         valueListenable: Hive.box<Photo>('photos').listenable(),
//         builder: (context, box, _) {
//           if (box.isEmpty) {
//             return Center(child: Text('No images uploaded yet.'));
//           }
//           return GridView.builder(
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 3,
//               crossAxisSpacing: 8.0,
//               mainAxisSpacing: 8.0,
//             ),
//             itemCount: box.length,
//             itemBuilder: (context, index) {
//               final photo = box.getAt(index);
//               return Image.memory(base64Decode(photo!.path)); // Display base64 image directly
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: pickImage,
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }

// import 'dart:async';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:image_picker/image_picker.dart';
// import 'model/cart_model.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Hive.initFlutter();
//   Hive.registerAdapter(PhotoAdapter());
//   await Hive.openBox<Photo>('photos');
//
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Photo Upload Example',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: PhotoUploadPage(),
//     );
//   }
// }
//
// class PhotoUploadPage extends StatefulWidget {
//   @override
//   _PhotoUploadPageState createState() => _PhotoUploadPageState();
// }
//
// class _PhotoUploadPageState extends State<PhotoUploadPage> {
//   final ImagePicker _picker = ImagePicker();
//
//   ConnectivityResult connectivityResult = ConnectivityResult.none;
//   late StreamSubscription<List<ConnectivityResult>> subscription;
//   final Connectivity connectivity = Connectivity();
//   @override
//   void initState() {
//     super.initState();
//     _checkConnectivity(); // Initial connectivity check
//
//     // Listen for connectivity changes
//     subscription = connectivity.onConnectivityChanged.listen((List<ConnectivityResult> result) {
//       if (result.isNotEmpty) {
//         _checkConnectivity(); // Use the first result
//       }
//     });
//   }
//
//   Future<void> _checkConnectivity() async {
//     var result = await connectivity.checkConnectivity();
//     setState(() {}); // Update UI with initial connectivity status
//   }
//
//   Future<void> pickImage() async {
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//
//     if (image != null) {
//       // Check connectivity before saving the image path
//       if (connectivityResult == ConnectivityResult.none) {
//         await saveImageLocally(image.path); // Save path if connected
//       } else {
//         print('No internet connection.');
//       }
//     }
//   }
//
//   Future<void> saveImageLocally(String imagePath) async {
//     var box = Hive.box<Photo>('photos');
//     await box.add(Photo(imagePath)); // Save path for mobile
//     print('Image saved at $imagePath');
//   }
//
//   @override
//   void dispose() {
//     subscription.cancel(); // Cancel subscription when disposing the widget
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Photo Upload Example')),
//       body: Column(
//         children: [
//           Expanded(
//             child: ValueListenableBuilder<Box<Photo>>(
//               valueListenable: Hive.box<Photo>('photos').listenable(),
//               builder: (context, box, _) {
//                 if (box.isEmpty) {
//                   return Center(child: Text('No images uploaded yet.'));
//                 }
//                 return GridView.builder(
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 3,
//                     crossAxisSpacing: 8.0,
//                     mainAxisSpacing: 8.0,
//                   ),
//                   itemCount: box.length,
//                   itemBuilder: (context, index) {
//                     final photo = box.getAt(index);
//                     return Image.fi le(File(photo!.path)); // Display image from path
//                   },
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Text(
//               'Current Connection Status: ${connectivityResult.toString()}',
//               style: TextStyle(fontSize: 18),
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: pickImage,
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutterprojects/riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http; // Import the HTTP package
import 'model/cart_model.dart'; // Make sure this imports your Photo model
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PhotoAdapter());
  await Hive.openBox<Photo>('photos');

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return MaterialApp(
      title: 'Photo Upload Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: PhotoUploadPage(),
    );
  }
}

class PhotoUploadPage extends ConsumerStatefulWidget {
  @override
  _PhotoUploadPageState createState() => _PhotoUploadPageState();
}

class _PhotoUploadPageState extends ConsumerState<PhotoUploadPage> {
  final ImagePicker _picker = ImagePicker();

  // ConnectivityResult connectivityResult = ConnectivityResult.none;
  late StreamSubscription<List<ConnectivityResult>> subscription;
  final Connectivity connectivity = Connectivity();

  String uploadedImageUrl= '';
  @override
  void initState() {
    super.initState();
    _checkConnectivity(); // Initial connectivity check

    // Listen for connectivity changes
    subscription = connectivity.onConnectivityChanged.listen((List<ConnectivityResult> result)  {
      ref.read(connectivityProvider.notifier).state = result as ConnectivityResult; // Update provider state
    });
  }

  Future<void> _checkConnectivity() async {
    List<ConnectivityResult> result = await Connectivity().checkConnectivity();
    ref.read(connectivityProvider.notifier).state = result as ConnectivityResult;
  }

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      // await saveImageLocally(image.path);
      // Check connectivity before saving the image path
      if (ref.read(connectivityProvider).state == ConnectivityResult.none) {
        await saveImageLocally(image.path); // Save path if connected
        print('No internet connection.');
      } else {
        uploadImage(image.path);
      }
    }
  }

  Future<void> saveImageLocally(String imagePath) async {
    var box = Hive.box<Photo>('photos');
    await box.add(Photo(imagePath)); // Save path for mobile
    print('Image saved at $imagePath');
  }

  Future<void> uploadImage(String imagePath) async {
    var headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NjE3Njg1ZGI5ZDRjZjQyMTg3MzA5MjMiLCJpYXQiOjE3Mjc2OTM3MTQsImV4cCI6MTcyODA1MzcxNH0.MfjnmfyXGRwp9dV_mme_R20lmOyXUot6HMfe9_kEzRE'
    };
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://safegate.informerio.com/safegate/api/activity/upload'), // Replace with your API endpoint
    );

    // Read file into bytes
    File file = File(imagePath);
    List<int> imageBytes = await file.readAsBytes();

    // Add the file to the request
    request.files.add(http.MultipartFile.fromBytes(
      'image',
      imageBytes,
      filename: file.uri.pathSegments.last,
      contentType: MediaType('image', 'png'), // Adjust content type as needed
    ));
    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send();
      print(response);
      if (response.statusCode == 200) {
        final responseData = await http.Response.fromStream(response);
        print('Full response: ${responseData.body}');
        final Map<String, dynamic> jsonResponse = json.decode(responseData.body);

        String uploadedImageUrl;
        // Extract the URL from the response
         uploadedImageUrl = jsonResponse['data']['url'];
        print('Length of uploaded image URL: ${uploadedImageUrl.length}');
        print('Uploaded image URL: $uploadedImageUrl');
        ref.read(uploadedImageUrlProvider.notifier).state = uploadedImageUrl;
        // Optionally remove from local storage after successful upload
        await removeFromLocalStorage(imagePath);
      }else if (response.statusCode == 401) {
        final responseData = await http.Response.fromStream(response);
        print('Unauthorized: ${responseData.body}');
      } else {
        print('Failed to upload image: ${response.statusCode}');
        await removeFromLocalStorage(
            imagePath); // Remove from local storage on failure
      }
    } catch (e) {
      print('Error uploading image: $e');
      await removeFromLocalStorage(
          imagePath); // Remove from local storage on error
    }
  }

  Future<void> removeFromLocalStorage(String imagePath) async {
    var box = Hive.box<Photo>('photos');
    var photos = box.values.toList();

    for (var photo in photos) {
      if (photo.path == imagePath) {
        await box.deleteAt(
            photos.indexOf(photo)); // Remove from local storage after upload
        break;
      }
    }
  }

  Future<void> uploadAllSavedImages() async {
    var box = Hive.box<Photo>('photos');
    var photos = box.values.toList();

    for (var photo in photos) {
      await uploadImage(photo.path); // Attempt to upload each saved image
    }
  }

  @override
  void dispose() {
    subscription.cancel(); // Cancel subscription when disposing the widget
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentConnection = ref.watch(connectivityProvider).state;
    return Scaffold(
      appBar: AppBar(title: Text('Photo Upload Example')),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder<Box<Photo>>(
              valueListenable: Hive.box<Photo>('photos').listenable(),
              builder: (context, box, _) {
                if (box.isEmpty) {
                  return Center(child: Text('No images uploaded yet.'));
                }
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    final photo = box.getAt(index);
                    return Image.file(
                        File(photo!.path)); // Display image from path
                  },
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Current Connection Status: ${uploadedImageUrl}',
              style: TextStyle(fontSize: 18),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              if (ref.read(connectivityProvider).state == currentConnection.none) {
                await uploadAllSavedImages();
                print(' upload images.'); // Upload all saved images if connected
              } else {
                print('No internet connection. Cannot upload images.');
              }
            },
            child: Text('Upload All Saved Images'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pickImage,
        child: Icon(Icons.add),
      ),
    );
  }
}

extension on ConnectivityResult {
  get state => null;
}
