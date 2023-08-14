import '../model/image_model.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import '../../domain/entities/image.dart';
import 'dart:io';
abstract class BaseRemoteDataSource{
  Future<List<ImageEntity>> getGeneratedImage(String prompt);
  Future<File> downloadImageFromUrl(String url);
}

class RemoteDataSource implements BaseRemoteDataSource{
  @override
  Future<List<ImageEntity>> getGeneratedImage(String prompt) async{
    final generatedImages = await OpenAI.instance.image.create(
      prompt: prompt,
      n: 5,//number of images to generate.
    );
    List<ImageEntity> imagesData=generatedImages.data.map((eachImage) =>ImageModel(eachImage.url!) ).toList();
    return imagesData;
  }

  @override
  Future<File> downloadImageFromUrl(String url) async {

    var response = await Dio().get(
      url,
      options: Options(responseType: ResponseType.bytes),
    );
    final appDir = await getTemporaryDirectory();
    final file = File('${appDir.path}/image.jpg');
    await file.writeAsBytes(response.data);

    return file;
  }


}