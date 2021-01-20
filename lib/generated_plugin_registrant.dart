//
// Generated file. Do not edit.
//

// ignore: unused_import
import 'dart:ui';

import 'package:file_picker/src/file_picker_web.dart';
import 'package:flutter_web_image_picker/flutter_web_image_picker.dart';
import 'package:shared_preferences_web/shared_preferences_web.dart';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

// ignore: public_member_api_docs
void registerPlugins(PluginRegistry registry) {
  FilePickerWeb.registerWith(registry.registrarFor(FilePickerWeb));
  FlutterWebImagePicker.registerWith(registry.registrarFor(FlutterWebImagePicker));
  SharedPreferencesPlugin.registerWith(registry.registrarFor(SharedPreferencesPlugin));
  registry.registerMessageHandler();
}
