import '../repository/image_repository.dart';
import 'dart:io';
class DownloadImage{
  final ImageRepository imageRepository;
  DownloadImage(this.imageRepository);
  Future<File> downloadImageByItsUrl(String url){
    return imageRepository.downloadImage(url);
  }

}