import '../entities/image.dart';
import 'dart:io';
abstract class ImageRepository{
  Future<List<ImageEntity>> getImageByPrompt(String prompt);
  Future<File> downloadImage(String url);
}