import 'dart:io';
import 'package:egypt_tourist_guide/controllers/profile_bloc/profile_bloc.dart';
import 'package:egypt_tourist_guide/core/app_images.dart';
import 'package:egypt_tourist_guide/core/services/shared_prefs_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({super.key});

  Future<String?> savePhotoLocally(XFile image) async {
    try {
      // Get the application documents directory
      final Directory appDir = await getApplicationDocumentsDirectory();

      // Generate a unique file name (e.g., using a timestamp)
      final String fileName = 'profile_photo_${DateTime.now().millisecondsSinceEpoch}.jpg';

      // Create the file path
      final String filePath = '${appDir.path}/$fileName';

      // Save the photo to the application folder
      final File savedFile = File(filePath);
      await savedFile.writeAsBytes(await image.readAsBytes());

      // Return the saved file path
      return savedFile.path;
    } catch (e) {
      return null;
    }
  }

  Future<void> _showImagePickerOptions(BuildContext context) async {
    ProfileBloc profileBloc = context.read<ProfileBloc>();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Take a Photo'),
                onTap: () async {
                  try {
                    Navigator.pop(context);
                    final ImagePicker picker = ImagePicker();
                    final XFile? image = await picker.pickImage(source: ImageSource.camera);
                    if (image != null) {
                      // Save the photo locally and get the file path
                      final String? savedFilePath = await savePhotoLocally(image);
                      if (savedFilePath != null) {
                        // Save the file path to SharedPreferences
                        SharedPrefsService.saveStringData(
                          key: SharedPrefsService.userProfilePicture,
                          value: savedFilePath,
                        );
                        // Trigger the profile image update event
                        profileBloc.add(UpdateProfileImageEvent());
                      }
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.toString())),
                    );
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () async {
                  try {
                    Navigator.pop(context);
                    final ImagePicker picker = ImagePicker();
                    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      // Save the photo locally and get the file path
                      final String? savedFilePath = await savePhotoLocally(image);
                      if (savedFilePath != null) {
                        // Save the file path to SharedPreferences
                        SharedPrefsService.saveStringData(
                          key: SharedPrefsService.userProfilePicture,
                          value: savedFilePath,
                        );
                        // Trigger the profile image update event
                        profileBloc.add(UpdateProfileImageEvent());
                      }
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.toString())),
                    );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final String imagePath = SharedPrefsService.getProfilePhoto();
    return InkWell(
        onTap: () => _showImagePickerOptions(context),
        child:
            CircleAvatar(
                radius: 70,
                // To check if the saved image existed or to show the default one
                backgroundImage: imagePath == AppImages.user ? AssetImage(imagePath):FileImage(File(SharedPrefsService.getProfilePhoto()))
            )
    );
  }
}
