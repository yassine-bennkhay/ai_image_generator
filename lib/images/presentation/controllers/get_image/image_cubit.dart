import '../../../domain/entities/image.dart';
import '../../../domain/usecases/get_image_by_prompt.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repository/image_repository.dart';
import 'image_state.dart';

class ImageCubit extends Cubit<ImageState>{
  final ImageRepository imageRepository;
  ImageCubit(this.imageRepository):super (ImageInitial());
  Future<void> getImage(String prompt)async{
    emit(ImageInitial());
  try{
    emit(ImageIsLoading());
    List<ImageEntity> gottenImage= await GetImageByPrompt(imageRepository).getTheImageByPrompt(prompt);
 emit(ImageLoaded(gottenImage));

  }catch (e) {
    if (e is RequestFailedException) {
      emit(ImageError(e.message));
    } else {
      emit(ImageError("Unknown error occurred."));
    }
  }}
}