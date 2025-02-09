import 'package:egypt_tourist_guide/controllers/profile_bloc/profile_bloc.dart';
import 'package:egypt_tourist_guide/core/app_images.dart';
import 'package:egypt_tourist_guide/core/services/shared_prefs_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({super.key});

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
                    final XFile? image =
                        await picker.pickImage(source: ImageSource.camera);
                    if (image != null) {
                      SharedPrefsService.saveStringData(
                          key: SharedPrefsService.userProfilePicture,
                          value: image.path.toString());
                      profileBloc.add(UpdateProfileImageEvent());
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(e.toString())));
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
                    final XFile? image =
                        await picker.pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      SharedPrefsService.saveStringData(
                          key: SharedPrefsService.userProfilePicture,
                          value: image.path);
                      profileBloc.add(UpdateProfileImageEvent());
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(e.toString())));
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
    return InkWell(
        onTap: () => _showImagePickerOptions(context),
        child:
            CircleAvatar(
                radius: 70, backgroundImage: AssetImage(SharedPrefsService.getProfilePhoto())
            )
    );
  }
}
