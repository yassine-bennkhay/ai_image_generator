import '../controllers/get_image/image_cubit.dart';
import '../controllers/get_image/image_state.dart';
import '../widgets/generate_images.dart';
import '../widgets/reusable_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/data_source/remote_datasource.dart';
import '../../data/repository/image_repository.dart';
import '../widgets/input_decoration.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _promptController = TextEditingController();
  final ImageCubit imageCubit =
  ImageCubit(ConcreteImageRepository(RemoteDataSource()));

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ImageCubit>(
      create: (context) => imageCubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("AI Image Generator"),
          centerTitle: true,
          backgroundColor: Colors.greenAccent,
        ),
        body: BlocBuilder<ImageCubit, ImageState>(
          builder: (context, state) {
          return Column(children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, top: 5.0, right: 15.0, bottom: 8.0),
              child: TextField(
                minLines: 1,
                maxLines: 5,
                style: const TextStyle(fontSize: 14),
                decoration: getInputDecoration(
                  'A white bird flying in a volcano',
                  Icons.search,
                ),
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  _promptController.text = value;
                },
              ),
            ),
            ReusableButton(
                onPressed: (state is ImageIsLoading)
                    ? null
                    : () {
                        FocusScope.of(context).unfocus();
                        final imageGenerationCubit = BlocProvider.of<ImageCubit>(context);
                        imageGenerationCubit.getImage(_promptController.text);
                      },
                child: (state is ImageIsLoading)
                    ? const CircularProgressIndicator()
                    : const Text("Generate")),
            Expanded(child: const GenerateImages()),
          ]);
        }),
      ),
    );
  }
}
