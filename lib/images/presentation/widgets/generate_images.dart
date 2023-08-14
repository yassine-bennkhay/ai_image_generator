import '../../data/data_source/admob_datasource.dart';
import '../../data/repository/admob_repository.dart';
import '../controllers/get_image/image_state.dart';
import '../controllers/show_ads/banner_ad_state.dart';
import '../screens/full_image_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../controllers/get_image/image_cubit.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../controllers/show_ads/banner_ad_cubit.dart';
import '../controllers/show_ads/interstitial_ad_cubit.dart';
import '../../domain/entities/image.dart';
class GenerateImages extends StatelessWidget {
  const GenerateImages({super.key});

  @override
  Widget build(BuildContext context) {
    final imageCubit = BlocProvider.of<ImageCubit>(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: imageCubit),
        BlocProvider<BannerAdCubit>(
            create: (context) => BannerAdCubit(
                ConcreteAdMobRepository(AdMobDataSourceImplementation()))),
        BlocProvider<InterstitialAdCubit>(
            create: (context) => InterstitialAdCubit(
                ConcreteAdMobRepository(AdMobDataSourceImplementation()))),
      ],
      child: const BuildImageWidget(),
    );
  }
}

class BuildImageWidget extends StatefulWidget {
  const BuildImageWidget({super.key});

  @override
  State<BuildImageWidget> createState() => _BuildImageWidgetState();
}

class _BuildImageWidgetState extends State<BuildImageWidget>
implements BannerAdListener {
  @override
  void initState() {
    super.initState();
    final bannerAdsCubit = BlocProvider.of<BannerAdCubit>(context);
    bannerAdsCubit.getBannerAd(this);
    final interstitialAdCubit=BlocProvider.of<InterstitialAdCubit>(context);
    interstitialAdCubit.loadInterstitialAd(() => null);
  }

  @override
  Widget build(BuildContext context) {
    final interstitialAdCubit = BlocProvider.of<InterstitialAdCubit>(context);

    return BlocBuilder<ImageCubit, ImageState>(
      builder: (context, state) {
        if (state is ImageLoaded) {
          final List<ImageEntity> images = state.loadedImages;

          return Container(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                BlocBuilder<BannerAdCubit, AdsState>(
                  builder: (context, state) {
                    if (state is BannerAdsLoaded) {
                      BannerAd bannerAd = state.bannerAd;
                      return SizedBox(
                        height: bannerAd.size.height.toDouble(),
                        width: bannerAd.size.width.toDouble(),
                        child: AdWidget(ad: bannerAd),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
                SizedBox(
                  height: 5.0,
                ),
                GridView.builder(
                  
                  itemCount: images.length,
                  itemBuilder: (BuildContext context, int index) => InkWell(
                    onTap: () {
                      interstitialAdCubit.loadInterstitialAd(() {
                         Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FullImageScreen(imageUrl: images[index].imageUrl)),
                        );
                      });
                     
                    },
                    child: Hero(
                      tag: images[index].imageUrl,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: FadeInImage(
                          fit: BoxFit.cover,
                          placeholder: const AssetImage('assets/loading.gif'),
                          image: NetworkImage(images[index].imageUrl),
                          imageErrorBuilder: (context, error, stackTrace) {
                            return ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset(
                                  'assets/placeholder_image.png',
                                  fit: BoxFit.cover,
                                ));
                          },
                        ),
                      ),
                    ),
                  ),
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                  ),
                ),
              ],
            ),
          );
        } else if (state is ImageError) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
                child: Text(
              state.errorMessage,
              textAlign: TextAlign.center,
            )),
          );
        } else {
          return Center(
              child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/placeholder.png",
                  width: 300,
                  height: 300,
                ),
                const Text(
                    "Start Generating Images By Typing an Image Description"),
              ],
            ),
          ));
        }
      },
    );
  }
  
  @override
  // TODO: implement onAdClicked
  AdEventCallback? get onAdClicked => throw UnimplementedError();
  
  @override
  // TODO: implement onAdClosed
  AdEventCallback? get onAdClosed => throw UnimplementedError();
  
  @override
  // TODO: implement onAdFailedToLoad
  AdLoadErrorCallback? get onAdFailedToLoad => throw UnimplementedError();
  
  @override
  // TODO: implement onAdImpression
  AdEventCallback? get onAdImpression => throw UnimplementedError();
  
  @override
  // TODO: implement onAdLoaded
  AdEventCallback? get onAdLoaded => throw UnimplementedError();
  
  @override
  // TODO: implement onAdOpened
  AdEventCallback? get onAdOpened => throw UnimplementedError();
  
  @override
  // TODO: implement onAdWillDismissScreen
  AdEventCallback? get onAdWillDismissScreen => throw UnimplementedError();
  
  @override
  // TODO: implement onPaidEvent
  OnPaidEventCallback? get onPaidEvent => throw UnimplementedError();

}
