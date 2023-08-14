import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import '../../data/data_source/remote_datasource.dart';
import '../../data/repository/image_repository.dart';
import '../controllers/download_image/download_image_cubit.dart';
import '../controllers/download_image/download_image_state.dart';
import '../widgets/reusable_button.dart';

class FullImageScreen extends StatefulWidget {
  final String imageUrl;
  const FullImageScreen({super.key,required this.imageUrl});

  @override
  State<FullImageScreen> createState() => _FullImageScreenState();
}

class _FullImageScreenState extends State<FullImageScreen> {
  @override
  Widget build(BuildContext context) {

    return  BlocProvider<DownloadImageCubit>(
      create: (context) =>
          DownloadImageCubit(ConcreteImageRepository(RemoteDataSource())),

      child: Scaffold(
        body:Stack(children: [
          Hero(
            tag: widget.imageUrl,
            child: FadeInImage(
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
              placeholder: const AssetImage('assets/full_loading.gif'),
              image: NetworkImage(widget.imageUrl,),
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/placeholder_image.png',
                  fit: BoxFit.cover,
                );
              },
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BlocBuilder<DownloadImageCubit, DownloadImageState>(
                builder: (context, downloadState) {
                  return ReusableButton(
                    onPressed: (downloadState is Downloading)
                        ? null
                        : () {
                      context
                          .read<DownloadImageCubit>()
                          .downloadImage(widget.imageUrl);

                    },
                    child: (downloadState is Downloading)
                        ? const CircularProgressIndicator()
                        : const Text("Download"),
                  );
                },
              ),
              ReusableButton(
                 onPressed:
                     () async{
                  // File file=  await context
                  //      .read<DownloadIconCubit>()
                  //      .downloadIcon(widget.imageUrl);
                  //       XFile myFile=XFile(file.path);
                  await Share.share(widget.imageUrl, subject: 'Take a look!');
                 },
                child:
                    const Text("Share"),
              ),
            ],
          ),
          BlocListener<DownloadImageCubit, DownloadImageState>(
            listenWhen: (prev, current) =>
            prev is Downloading && current is DownloadImageDone,
            listener: (context, downloadState) {
              _handleDownloadStateChange(downloadState);
            },
            child: Container(),
          ),
        ],)
      ),

    );
  }
  void _handleDownloadStateChange(DownloadImageState state) {
    if (state is DownloadImageDone) {
      _showDownloadSnackBar(context,'Image downloaded successfully.');
    }else if(state is DownloadError){
      _showDownloadSnackBar(context,"Unable to download image.");

    }
  }

  void _showDownloadSnackBar(BuildContext context,String message) {
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
        content: Center(child: Text(message)),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
