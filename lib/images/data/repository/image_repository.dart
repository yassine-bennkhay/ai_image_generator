import '../data_source/remote_datasource.dart';
import '../../domain/entities/image.dart';
import '../../domain/repository/image_repository.dart';
import 'dart:io';
class ConcreteImageRepository implements ImageRepository{
  final BaseRemoteDataSource baseRemoteDataSource;
  ConcreteImageRepository(this.baseRemoteDataSource);
  @override
  Future<List<ImageEntity>> getImageByPrompt(String prompt) async{
  return await baseRemoteDataSource.getGeneratedImage(prompt);
  }

  @override
  Future<File> downloadImage(String url) async{
    return await baseRemoteDataSource.downloadImageFromUrl(url);
  }

}