import '../repository/image_repository.dart';
import '../entities/image.dart';

class GetImageByPrompt{
  final ImageRepository imageRepository;
  GetImageByPrompt(this.imageRepository);
  Future<List<ImageEntity>> getTheImageByPrompt(String prompt){
    return imageRepository.getImageByPrompt(prompt);
  }
}