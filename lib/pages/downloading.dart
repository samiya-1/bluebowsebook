


// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
//
//
//
// class Download extends StatefulWidget {
//   @override
//   _DownloadState createState() => _DownloadState();
// }
//
// class _DownloadState extends State<Download> {
//   final Dio dio = Dio();
//   bool loading = false;
//   double progress = 0;
//
//   Future<bool> saveFiles(String url, String fileName) async {
//     Directory directory;
//     try {
//       if (Platform.isAndroid) {
//         if (await _requestPermission(Permission.storage)) {
//           directory = await getExternalStorageDirectory();
//           String newPath = "";
//           print(directory);
//           List<String> paths = directory.path.split("/");
//           for (int x = 1; x < paths.length; x++) {
//             String folder = paths[x];
//             if (folder != "Android") {
//               newPath += "/" + folder;
//             } else {
//               break;
//             }
//           }
//           newPath = newPath + "/RPSApp";
//           directory = Directory(newPath);
//         } else {
//           return false;
//         }
//       } else {
//         if (await _requestPermission(Permission.photos)) {
//           directory = await getTemporaryDirectory();
//         } else {
//           return false;
//         }
//       }
//       File saveFile = File(directory.path + "/$fileName");
//       if (!await directory.exists()) {
//         await directory.create(recursive: true);
//       }
//       if (await directory.exists()) {
//         await dio.download(url, saveFile.path,
//             onReceiveProgress: (value1, value2) {
//               setState(() {
//                 progress = value1 / value2;
//               });
//             });
//         if (Platform.isIOS) {
//           await ImageGallerySaver.saveFile(saveFile.path,
//               isReturnPathOfIOS: true);
//         }
//         return true;
//       }
//       return false;
//     } catch (e) {
//       print(e);
//       return false;
//     }
//   }
//
//   Future<bool> _requestPermission(Permission permission) async {
//     if (await permission.isGranted) {
//       return true;
//     } else {
//       var result = await permission.request();
//       if (result == PermissionStatus.granted) {
//         return true;
//       }
//     }
//     return false;
//   }
//
//   downloadFile() async {
//     setState(() {
//       loading = true;
//       progress = 0;
//     });
//     bool downloaded = await saveFiles(
//         "file",
//         "book_name");
//     if (downloaded) {
//       print("File Downloaded");
//     } else {
//       print("Problem Downloading File");
//     }
//     setState(() {
//       loading = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: loading
//             ? Column(
//               children: [
//                 Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: LinearProgressIndicator(
//                 minHeight: 10,
//                 value: progress,
//           ),
//         ),
//                : FlatButton.icon(
//                     icon: Icon(
//                       Icons.download_rounded,
//                       color: Colors.white,
//                     ),
//                     color: Colors.blue,
//                     onPressed: downloadFile,
//                     padding: const EdgeInsets.all(10),
//                     label: Text(
//                       "Download File",
//                       style: TextStyle(color: Colors.white, fontSize: 25),
//                     )),
//               ],
//             ),
//
//       ),
//     );
//   }
// }