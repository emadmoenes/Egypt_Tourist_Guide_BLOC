import 'dart:io';
import 'package:egypt_tourist_guide/controllers/profile_bloc/profile_bloc.dart';
import 'package:egypt_tourist_guide/core/app_colors.dart';
import 'package:egypt_tourist_guide/core/app_images.dart';
import 'package:egypt_tourist_guide/core/services/shared_prefs_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ProfilePic extends StatelessWidget {
  ProfilePic({super.key});

  final ImagePicker picker = ImagePicker();

  //----- Save photo locally -----//
  Future<String?> savePhotoLocally(XFile image) async {
    try {
      // Get the application documents directory
      final Directory appDir = await getApplicationDocumentsDirectory();

      // Generate a unique file name (e.g., using a timestamp)
      final String fileName =
          'profile_photo_${DateTime.now().millisecondsSinceEpoch}.jpg';

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

  //----- Show image picker options -----//
  Future<void> _showImagePickerOptions(BuildContext context) async {
    ProfileBloc profileBloc = context.read<ProfileBloc>();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              // Pick from camera option
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Take a Photo'),
                onTap: () async {
                  try {
                    Navigator.pop(context);
                    final XFile? image =
                        await picker.pickImage(source: ImageSource.camera);
                    if (image != null) {
                      // Save the photo locally and get the file path
                      final String? savedFilePath =
                          await savePhotoLocally(image);
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
                        SnackBar(content: Text('Cannot change profile photo')));
                  }
                },
              ),
              // Pick from gallery option
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () async {
                  try {
                    Navigator.pop(context);
                    final XFile? image =
                        await picker.pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      // Save the photo locally and get the file path
                      final String? savedFilePath =
                          await savePhotoLocally(image);
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
                        SnackBar(content: Text('Cannot change profile photo')));
                  }
                },
              ),
              // Remove profile photo option
              ListTile(
                leading: const Icon(Icons.delete_forever),
                title: const Text('Remove photo'),
                onTap: () async {
                  Navigator.pop(context);
                  // Delete photo saved in shared pref
                  await SharedPrefsService.clearStringData(
                    key: SharedPrefsService.userProfilePicture,
                  );
                  profileBloc.add(UpdateProfileImageEvent());
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
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        //-- profile photo --//
        CircleAvatar(
          radius: 70,
          // To check if the saved image existed or to show the default one
          backgroundImage: imagePath == AppImages.user
              ? AssetImage(imagePath)
              : FileImage(
                  File(SharedPrefsService.getProfilePhoto()),
                ),
        ),
        //-- Change profile icon --//
        Positioned(
          right: 5.0,
          child: CircleAvatar(
            radius: 20.0,
            backgroundColor: AppColors.greyColor.withValues(alpha: 0.8),
            child: IconButton(
              onPressed: () => _showImagePickerOptions(context),
              icon: Icon(
                Icons.edit,
                color: AppColors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
