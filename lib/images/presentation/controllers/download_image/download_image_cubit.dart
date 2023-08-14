import 'download_image_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repository/image_repository.dart';
import '../../../domain/usecases/download_image.dart';
import 'dart:io';
class DownloadImageCubit extends Cubit<DownloadImageState> {
  final ImageRepository imageRepository;

  DownloadImageCubit(this.imageRepository) : super(DownloadImageInitial());

  Future<File> downloadImage(String url) async {
    emit(DownloadImageInitial());
    try {
    emit(Downloading());
      File downloadedImage =
      await DownloadImage(imageRepository).downloadImageByItsUrl(url);
      emit(DownloadImageDone());
      return downloadedImage;
    } catch (e) {

      emit(DownloadError("Unable to download the image"));

    }
    throw("cant download image");
  }


}


