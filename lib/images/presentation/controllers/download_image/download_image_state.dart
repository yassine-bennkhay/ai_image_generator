
class DownloadImageState{}

class DownloadImageInitial extends DownloadImageState{}
class DownloadImageDone extends DownloadImageState{
  // File downloadedImage;
  // DownloadImageDone(this.downloadedImage);
}
class Downloading extends DownloadImageState {}
class DownloadError extends DownloadImageState{
  final String errorMessage;
  DownloadError(this.errorMessage);
}