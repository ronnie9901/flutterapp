import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';


class WallpaperController extends GetxController {
  final ImagePicker imgpicker = ImagePicker();
  var fileImage = Rxn<File>(); // Reactive nullable file
  final String wallpaperKey = 'wallpaper_image';

  @override
  void onInit() {
    super.onInit();
    _loadWallpaper(); // Load the wallpaper from persistent storage on initialization
  }

  // Load the wallpaper from SharedPreferences
  Future<void> _loadWallpaper() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? wallpaperPath = prefs.getString(wallpaperKey);
    if (wallpaperPath != null) {
      fileImage.value = File(wallpaperPath);
    }
  }

  // Save the wallpaper path to SharedPreferences
  Future<void> _saveWallpaper(String path) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(wallpaperKey, path);
  }

  // Function to select a new wallpaper and save it
  Future<void> selectWallpaper() async {
    XFile? xFileImage = await imgpicker.pickImage(source: ImageSource.gallery);
    if (xFileImage != null) {
      fileImage.value = File(xFileImage.path); // Update the image
      await _saveWallpaper(xFileImage.path);
      update();// Save the file path persistently
    }
  }


}
