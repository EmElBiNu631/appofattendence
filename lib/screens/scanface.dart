// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../viewmodel/face_viewmodel.dart';
//
// class FaceVerificationView extends StatefulWidget {
//   const FaceVerificationView({super.key});
//
//   @override
//   State<FaceVerificationView> createState() => _FaceVerificationViewState();
// }
//
// class _FaceVerificationViewState extends State<FaceVerificationView> {
//   late FaceVerificationViewModel viewModel;
//
//   @override
//   void initState() {
//     super.initState();
//     viewModel = FaceVerificationViewModel();
//     viewModel.initializeCamera(); // You may need to add this if not already called inside constructor
//   }
//
//   @override
//   void dispose() {
//     viewModel.disposeCamera(); // You may define this method in your ViewModel
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<FaceVerificationViewModel>.value(
//       value: viewModel,
//       child: const FaceVerificationContent(),
//     );
//   }
// }
//
// class FaceVerificationContent extends StatelessWidget {
//   const FaceVerificationContent({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final viewModel = Provider.of<FaceVerificationViewModel>(context);
//
//     return Scaffold(
//       body: viewModel.cameraController.value.isInitialized
//           ? Stack(
//         children: [
//           CameraPreview(viewModel.cameraController),
//           Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [Colors.transparent, Color(0xAA71C6F7)],
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.center,
//             child: Container(
//               width: 250,
//               height: 350,
//               decoration: BoxDecoration(
//                 shape: BoxShape.rectangle,
//                 border: Border.all(color: Colors.white, width: 2),
//                 borderRadius: BorderRadius.circular(16),
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Padding(
//               padding: const EdgeInsets.only(bottom: 40.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const Text(
//                     'Center your face',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   const Text(
//                     'Point your face right at the box,\nthen take a photo',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 13,
//                       color: Colors.white70,
//                     ),
//                   ),
//                   const SizedBox(height: 30),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       IconButton(
//                         icon: const Icon(Icons.cameraswitch,
//                             size: 28, color: Colors.white),
//                         onPressed: viewModel.switchCamera,
//                       ),
//                       const SizedBox(width: 40),
//                       GestureDetector(
//                         onTap: () => viewModel.takePhoto(context),
//                         child: Container(
//                           padding: const EdgeInsets.all(20),
//                           decoration: const BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.blue,
//                           ),
//                           child: const Icon(Icons.check,
//                               color: Colors.white, size: 30),
//                         ),
//                       ),
//                       const SizedBox(width: 40),
//                       IconButton(
//                         icon: Icon(
//                           viewModel.isFlashOn
//                               ? Icons.flash_on
//                               : Icons.flash_off,
//                           size: 28,
//                           color: Colors.white,
//                         ),
//                         onPressed: viewModel.toggleFlash,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       )
//           : const Center(child: CircularProgressIndicator()),
//     );
//   }
// }
