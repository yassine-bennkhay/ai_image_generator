import '../../../domain/entities/image.dart';

class ImageState{}
class ImageInitial extends ImageState{}

class ImageLoaded extends ImageState{
  final List<ImageEntity> loadedImages;
  ImageLoaded(this.loadedImages);
}
class ImageIsLoading extends ImageState{}
class ImageError extends ImageState{
  final String errorMessage;
  ImageError(this.errorMessage);
}