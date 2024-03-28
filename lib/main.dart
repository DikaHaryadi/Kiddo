import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:textspeech/interface/content/animal.dart';
import 'package:textspeech/interface/content/family.dart';
import 'package:textspeech/interface/content/fruits.dart';
import 'package:textspeech/interface/content/letters.dart';
import 'package:textspeech/interface/content/numbers.dart';
import 'package:textspeech/interface/content/vegetables.dart';
import 'package:textspeech/interface/game_ui.dart';
import 'package:textspeech/interface/homepage.dart';
import 'package:textspeech/interface/numbers_game.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // unawaited(MobileAds.instance.initialize());
  MobileAds.instance.initialize();
  await initializeDateFormatting('id', null);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => const HomePage()),
          // Games
          GetPage(name: '/memo-game', page: () => const StartUpPage()),
          GetPage(name: '/numbers-game', page: () => const NumbersGame()),
          // Content
          GetPage(name: '/number-content', page: () => const NumberContent()),
          GetPage(name: '/letters-content', page: () => const LettersContent()),
          GetPage(name: '/animals-content', page: () => const AnimalContent()),
          GetPage(name: '/family-content', page: () => const FamilyContent()),
          GetPage(name: '/fruits-content', page: () => const FruitsContent()),
          GetPage(
              name: '/vegetables-content',
              page: () => const VegetablesContent()),
        ]
        // home: FamilyContent(),
        );
  }
}

// const String testDevice = 'YOUR_DEVICE_ID';

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   static final AdRequest request = const AdRequest(
//     keywords: <String>['foo', 'bar'],
//     contentUrl: 'http://foo.com/bar.html',
//     nonPersonalizedAds: true,
//   );

//   static const interstitialButtonText = 'InterstitialAd';
//   static const rewardedButtonText = 'RewardedAd';
//   static const rewardedInterstitialButtonText = 'RewardedInterstitialAd';
//   static const fluidButtonText = 'Fluid';
//   static const inlineAdaptiveButtonText = 'Inline adaptive';
//   static const anchoredAdaptiveButtonText = 'Anchored adaptive';
//   static const nativeTemplateButtonText = 'Native template';
//   static const adInspectorButtonText = 'Ad Inspector';

//   InterstitialAd? _interstitialAd;
//   int _numInterstitialLoadAttempts = 0;

//   RewardedAd? _rewardedAd;
//   int _numRewardedLoadAttempts = 0;

//   RewardedInterstitialAd? _rewardedInterstitialAd;
//   int _numRewardedInterstitialLoadAttempts = 0;

//   @override
//   void initState() {
//     super.initState();
//     MobileAds.instance.updateRequestConfiguration(
//         RequestConfiguration(testDeviceIds: [testDevice]));
//     _createInterstitialAd();
//     _createRewardedAd();
//     _createRewardedInterstitialAd();
//   }

//   void _createInterstitialAd() {
//     InterstitialAd.load(
//         adUnitId: Platform.isAndroid
//             ? 'ca-app-pub-7319269804560504/8512599311'
//             : 'ca-app-pub-3940256099942544/4411468910',
//         request: request,
//         adLoadCallback: InterstitialAdLoadCallback(
//           onAdLoaded: (InterstitialAd ad) {
//             print('$ad loaded');
//             _interstitialAd = ad;
//             _numInterstitialLoadAttempts = 0;
//             _interstitialAd!.setImmersiveMode(true);
//           },
//           onAdFailedToLoad: (LoadAdError error) {
//             print('InterstitialAd failed to load: $error.');
//             _numInterstitialLoadAttempts += 1;
//             _interstitialAd = null;
//             if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
//               _createInterstitialAd();
//             }
//           },
//         ));
//   }

//   void _showInterstitialAd() {
//     if (_interstitialAd == null) {
//       print('Warning: attempt to show interstitial before loaded.');
//       return;
//     }
//     _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
//       onAdShowedFullScreenContent: (InterstitialAd ad) =>
//           print('ad onAdShowedFullScreenContent.'),
//       onAdDismissedFullScreenContent: (InterstitialAd ad) {
//         print('$ad onAdDismissedFullScreenContent.');
//         ad.dispose();
//         _createInterstitialAd();
//       },
//       onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
//         print('$ad onAdFailedToShowFullScreenContent: $error');
//         ad.dispose();
//         _createInterstitialAd();
//       },
//     );
//     _interstitialAd!.show();
//     _interstitialAd = null;
//   }

//   void _createRewardedAd() {
//     RewardedAd.load(
//         adUnitId: Platform.isAndroid
//             ? 'ca-app-pub-3940256099942544/5224354917'
//             : 'ca-app-pub-3940256099942544/1712485313',
//         request: request,
//         rewardedAdLoadCallback: RewardedAdLoadCallback(
//           onAdLoaded: (RewardedAd ad) {
//             print('$ad loaded.');
//             _rewardedAd = ad;
//             _numRewardedLoadAttempts = 0;
//           },
//           onAdFailedToLoad: (LoadAdError error) {
//             print('RewardedAd failed to load: $error');
//             _rewardedAd = null;
//             _numRewardedLoadAttempts += 1;
//             if (_numRewardedLoadAttempts < maxFailedLoadAttempts) {
//               _createRewardedAd();
//             }
//           },
//         ));
//   }

//   void _showRewardedAd() {
//     if (_rewardedAd == null) {
//       print('Warning: attempt to show rewarded before loaded.');
//       return;
//     }
//     _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
//       onAdShowedFullScreenContent: (RewardedAd ad) =>
//           print('ad onAdShowedFullScreenContent.'),
//       onAdDismissedFullScreenContent: (RewardedAd ad) {
//         print('$ad onAdDismissedFullScreenContent.');
//         ad.dispose();
//         _createRewardedAd();
//       },
//       onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
//         print('$ad onAdFailedToShowFullScreenContent: $error');
//         ad.dispose();
//         _createRewardedAd();
//       },
//     );

//     _rewardedAd!.setImmersiveMode(true);
//     _rewardedAd!.show(
//         onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
//       print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
//     });
//     _rewardedAd = null;
//   }

//   void _createRewardedInterstitialAd() {
//     RewardedInterstitialAd.load(
//         adUnitId: Platform.isAndroid
//             ? 'ca-app-pub-3940256099942544/5354046379'
//             : 'ca-app-pub-3940256099942544/6978759866',
//         request: request,
//         rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
//           onAdLoaded: (RewardedInterstitialAd ad) {
//             print('$ad loaded.');
//             _rewardedInterstitialAd = ad;
//             _numRewardedInterstitialLoadAttempts = 0;
//           },
//           onAdFailedToLoad: (LoadAdError error) {
//             print('RewardedInterstitialAd failed to load: $error');
//             _rewardedInterstitialAd = null;
//             _numRewardedInterstitialLoadAttempts += 1;
//             if (_numRewardedInterstitialLoadAttempts < maxFailedLoadAttempts) {
//               _createRewardedInterstitialAd();
//             }
//           },
//         ));
//   }

//   void _showRewardedInterstitialAd() {
//     if (_rewardedInterstitialAd == null) {
//       print('Warning: attempt to show rewarded interstitial before loaded.');
//       return;
//     }
//     _rewardedInterstitialAd!.fullScreenContentCallback =
//         FullScreenContentCallback(
//       onAdShowedFullScreenContent: (RewardedInterstitialAd ad) =>
//           print('$ad onAdShowedFullScreenContent.'),
//       onAdDismissedFullScreenContent: (RewardedInterstitialAd ad) {
//         print('$ad onAdDismissedFullScreenContent.');
//         ad.dispose();
//         _createRewardedInterstitialAd();
//       },
//       onAdFailedToShowFullScreenContent:
//           (RewardedInterstitialAd ad, AdError error) {
//         print('$ad onAdFailedToShowFullScreenContent: $error');
//         ad.dispose();
//         _createRewardedInterstitialAd();
//       },
//     );

//     _rewardedInterstitialAd!.setImmersiveMode(true);
//     _rewardedInterstitialAd!.show(
//         onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
//       print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
//     });
//     _rewardedInterstitialAd = null;
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _interstitialAd?.dispose();
//     _rewardedAd?.dispose();
//     _rewardedInterstitialAd?.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Builder(builder: (BuildContext context) {
//         return Scaffold(
//           appBar: AppBar(
//             title: const Text('AdMob Plugin example app'),
//             actions: <Widget>[
//               PopupMenuButton<String>(
//                 onSelected: (String result) {
//                   switch (result) {
//                     case interstitialButtonText:
//                       _showInterstitialAd();
//                       break;
//                     case rewardedButtonText:
//                       _showRewardedAd();
//                       break;
//                     case rewardedInterstitialButtonText:
//                       _showRewardedInterstitialAd();
//                       break;
//                     case fluidButtonText:
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => FluidExample()),
//                       );
//                       break;
//                     case inlineAdaptiveButtonText:
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => InlineAdaptiveExample()),
//                       );
//                       break;
//                     case anchoredAdaptiveButtonText:
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => AnchoredAdaptiveExample()),
//                       );
//                       break;
//                     case nativeTemplateButtonText:
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => NativeTemplateExample()),
//                       );
//                       break;
//                     case adInspectorButtonText:
//                       MobileAds.instance.openAdInspector((error) => log(
//                           'Ad Inspector ' +
//                               (error == null
//                                   ? 'opened.'
//                                   : 'error: ' + (error.message ?? ''))));
//                       break;
//                     default:
//                       throw AssertionError('unexpected button: $result');
//                   }
//                 },
//                 itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
//                   const PopupMenuItem<String>(
//                     value: interstitialButtonText,
//                     child: Text(interstitialButtonText),
//                   ),
//                   const PopupMenuItem<String>(
//                     value: rewardedButtonText,
//                     child: Text(rewardedButtonText),
//                   ),
//                   const PopupMenuItem<String>(
//                     value: rewardedInterstitialButtonText,
//                     child: Text(rewardedInterstitialButtonText),
//                   ),
//                   const PopupMenuItem<String>(
//                     value: fluidButtonText,
//                     child: Text(fluidButtonText),
//                   ),
//                   const PopupMenuItem<String>(
//                     value: inlineAdaptiveButtonText,
//                     child: Text(inlineAdaptiveButtonText),
//                   ),
//                   const PopupMenuItem<String>(
//                     value: anchoredAdaptiveButtonText,
//                     child: Text(anchoredAdaptiveButtonText),
//                   ),
//                   const PopupMenuItem<String>(
//                     value: nativeTemplateButtonText,
//                     child: Text(nativeTemplateButtonText),
//                   ),
//                   const PopupMenuItem<String>(
//                     value: adInspectorButtonText,
//                     child: Text(adInspectorButtonText),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           body: SafeArea(child: ReusableInlineExample()),
//         );
//       }),
//     );
//   }
// }

// class FluidExample extends StatefulWidget {
//   @override
//   _FluidExampleExampleState createState() => _FluidExampleExampleState();
// }

// class _FluidExampleExampleState extends State<FluidExample> {
//   FluidAdManagerBannerAd? _fluidAd;
//   double _width = 200.0;

//   @override
//   Widget build(BuildContext context) => Scaffold(
//       appBar: AppBar(
//         title: const Text('Fluid example'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: ListView.separated(
//             itemCount: 3,
//             separatorBuilder: (BuildContext context, int index) {
//               return Container(
//                 height: 40,
//               );
//             },
//             itemBuilder: (BuildContext context, int index) {
//               if (index == 1) {
//                 return Align(
//                   alignment: Alignment.center,
//                   child: FluidAdWidget(
//                     width: _width,
//                     ad: _fluidAd!,
//                   ),
//                 );
//               } else if (index == 2) {
//                 return ElevatedButton(
//                     onPressed: () {
//                       double newWidth;
//                       if (_width == 200.0) {
//                         newWidth = 100.0;
//                       } else if (_width == 100.0) {
//                         newWidth = 150.0;
//                       } else {
//                         newWidth = 200.0;
//                       }
//                       setState(() {
//                         _width = newWidth;
//                       });
//                     },
//                     child: const Text('Change size'));
//               }
//               return const Text(
//                 Constants.placeholderText,
//                 style: TextStyle(fontSize: 24),
//               );
//             },
//           ),
//         ),
//       ));

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     // Create the ad objects and load ads.
//     _fluidAd = FluidAdManagerBannerAd(
//       adUnitId: '/6499/example/APIDemo/Fluid',
//       request: const AdManagerAdRequest(nonPersonalizedAds: true),
//       listener: AdManagerBannerAdListener(
//         onAdLoaded: (Ad ad) {
//           print('$_fluidAd loaded.');
//         },
//         onAdFailedToLoad: (Ad ad, LoadAdError error) {
//           print('$_fluidAd failedToLoad: $error');
//           ad.dispose();
//         },
//         onAdOpened: (Ad ad) => print('$_fluidAd onAdOpened.'),
//         onAdClosed: (Ad ad) => print('$_fluidAd onAdClosed.'),
//       ),
//     )..load();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _fluidAd?.dispose();
//   }
// }

// class InlineAdaptiveExample extends StatefulWidget {
//   @override
//   _InlineAdaptiveExampleState createState() => _InlineAdaptiveExampleState();
// }

// class _InlineAdaptiveExampleState extends State<InlineAdaptiveExample> {
//   static const _insets = 16.0;
//   AdManagerBannerAd? _inlineAdaptiveAd;
//   bool _isLoaded = false;
//   AdSize? _adSize;
//   late Orientation _currentOrientation;

//   double get _adWidth => MediaQuery.of(context).size.width - (2 * _insets);

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _currentOrientation = MediaQuery.of(context).orientation;
//     _loadAd();
//   }

//   void _loadAd() async {
//     await _inlineAdaptiveAd?.dispose();
//     setState(() {
//       _inlineAdaptiveAd = null;
//       _isLoaded = false;
//     });

//     // Get an inline adaptive size for the current orientation.
//     AdSize size = AdSize.getCurrentOrientationInlineAdaptiveBannerAdSize(
//         _adWidth.truncate());

//     _inlineAdaptiveAd = AdManagerBannerAd(
//       adUnitId: '/6499/example/banner',
//       sizes: [size],
//       request: const AdManagerAdRequest(),
//       listener: AdManagerBannerAdListener(
//         onAdLoaded: (Ad ad) async {
//           print('Inline adaptive banner loaded: ${ad.responseInfo}');

//           // After the ad is loaded, get the platform ad size and use it to
//           // update the height of the container. This is necessary because the
//           // height can change after the ad is loaded.
//           AdManagerBannerAd bannerAd = (ad as AdManagerBannerAd);
//           final AdSize? size = await bannerAd.getPlatformAdSize();
//           if (size == null) {
//             print('Error: getPlatformAdSize() returned null for $bannerAd');
//             return;
//           }

//           setState(() {
//             _inlineAdaptiveAd = bannerAd;
//             _isLoaded = true;
//             _adSize = size;
//           });
//         },
//         onAdFailedToLoad: (Ad ad, LoadAdError error) {
//           print('Inline adaptive banner failedToLoad: $error');
//           ad.dispose();
//         },
//       ),
//     );
//     await _inlineAdaptiveAd!.load();
//   }

//   /// Gets a widget containing the ad, if one is loaded.
//   ///
//   /// Returns an empty container if no ad is loaded, or the orientation
//   /// has changed. Also loads a new ad if the orientation changes.
//   Widget _getAdWidget() {
//     return OrientationBuilder(
//       builder: (context, orientation) {
//         if (_currentOrientation == orientation &&
//             _inlineAdaptiveAd != null &&
//             _isLoaded &&
//             _adSize != null) {
//           return Align(
//               child: Container(
//             width: _adWidth,
//             height: _adSize!.height.toDouble(),
//             child: AdWidget(
//               ad: _inlineAdaptiveAd!,
//             ),
//           ));
//         }
//         // Reload the ad if the orientation changes.
//         if (_currentOrientation != orientation) {
//           _currentOrientation = orientation;
//           _loadAd();
//         }
//         return Container();
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) => Scaffold(
//       appBar: AppBar(
//         title: const Text('Inline adaptive banner example'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: _insets),
//           child: ListView.separated(
//             itemCount: 3,
//             separatorBuilder: (BuildContext context, int index) {
//               return Container(
//                 height: 40,
//               );
//             },
//             itemBuilder: (BuildContext context, int index) {
//               if (index == 1) {
//                 return _getAdWidget();
//               }
//               return const Text(
//                 Constants.placeholderText,
//                 style: TextStyle(fontSize: 24),
//               );
//             },
//           ),
//         ),
//       ));

//   @override
//   void dispose() {
//     super.dispose();
//     _inlineAdaptiveAd?.dispose();
//   }
// }

// class AnchoredAdaptiveExample extends StatefulWidget {
//   @override
//   _AnchoredAdaptiveExampleState createState() =>
//       _AnchoredAdaptiveExampleState();
// }

// class _AnchoredAdaptiveExampleState extends State<AnchoredAdaptiveExample> {
//   BannerAd? _anchoredAdaptiveAd;
//   bool _isLoaded = false;
//   late Orientation _currentOrientation;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _currentOrientation = MediaQuery.of(context).orientation;
//     _loadAd();
//   }

//   /// Load another ad, disposing of the current ad if there is one.
//   Future<void> _loadAd() async {
//     await _anchoredAdaptiveAd?.dispose();
//     setState(() {
//       _anchoredAdaptiveAd = null;
//       _isLoaded = false;
//     });

//     final AnchoredAdaptiveBannerAdSize? size =
//         await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
//             MediaQuery.of(context).size.width.truncate());

//     if (size == null) {
//       print('Unable to get height of anchored banner.');
//       return;
//     }

//     _anchoredAdaptiveAd = BannerAd(
//       adUnitId: Platform.isAndroid
//           ? 'ca-app-pub-3940256099942544/9214589741'
//           : 'ca-app-pub-3940256099942544/2435281174',
//       size: size,
//       request: const AdRequest(),
//       listener: BannerAdListener(
//         onAdLoaded: (Ad ad) {
//           print('$ad loaded: ${ad.responseInfo}');
//           setState(() {
//             // When the ad is loaded, get the ad size and use it to set
//             // the height of the ad container.
//             _anchoredAdaptiveAd = ad as BannerAd;
//             _isLoaded = true;
//           });
//         },
//         onAdFailedToLoad: (Ad ad, LoadAdError error) {
//           print('Anchored adaptive banner failedToLoad: $error');
//           ad.dispose();
//         },
//       ),
//     );
//     return _anchoredAdaptiveAd!.load();
//   }

//   /// Gets a widget containing the ad, if one is loaded.
//   ///
//   /// Returns an empty container if no ad is loaded, or the orientation
//   /// has changed. Also loads a new ad if the orientation changes.
//   Widget _getAdWidget() {
//     return OrientationBuilder(
//       builder: (context, orientation) {
//         if (_currentOrientation == orientation &&
//             _anchoredAdaptiveAd != null &&
//             _isLoaded) {
//           return Container(
//             color: Colors.green,
//             width: _anchoredAdaptiveAd!.size.width.toDouble(),
//             height: _anchoredAdaptiveAd!.size.height.toDouble(),
//             child: AdWidget(ad: _anchoredAdaptiveAd!),
//           );
//         }
//         // Reload the ad if the orientation changes.
//         if (_currentOrientation != orientation) {
//           _currentOrientation = orientation;
//           _loadAd();
//         }
//         return Container();
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) => Scaffold(
//         appBar: AppBar(
//           title: const Text('Anchored adaptive banner example'),
//         ),
//         body: Center(
//           child: Stack(
//             alignment: AlignmentDirectional.bottomCenter,
//             children: <Widget>[
//               ListView.separated(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   itemBuilder: (context, index) {
//                     return const Text(
//                       Constants.placeholderText,
//                       style: TextStyle(fontSize: 24),
//                     );
//                   },
//                   separatorBuilder: (context, index) {
//                     return Container(height: 40);
//                   },
//                   itemCount: 5),
//               _getAdWidget(),
//             ],
//           ),
//         ),
//       );

//   @override
//   void dispose() {
//     super.dispose();
//     _anchoredAdaptiveAd?.dispose();
//   }
// }

// class ReusableInlineExample extends StatefulWidget {
//   @override
//   _ReusableInlineExampleState createState() => _ReusableInlineExampleState();
// }

// class _ReusableInlineExampleState extends State<ReusableInlineExample> {
//   BannerAd? _bannerAd;
//   bool _bannerAdIsLoaded = false;

//   AdManagerBannerAd? _adManagerBannerAd;
//   bool _adManagerBannerAdIsLoaded = false;

//   NativeAd? _nativeAd;
//   bool _nativeAdIsLoaded = false;

//   @override
//   Widget build(BuildContext context) => Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: ListView.separated(
//             itemCount: 20,
//             separatorBuilder: (BuildContext context, int index) {
//               return Container(
//                 height: 40,
//               );
//             },
//             itemBuilder: (BuildContext context, int index) {
//               final BannerAd? bannerAd = _bannerAd;
//               if (index == 5 && _bannerAdIsLoaded && bannerAd != null) {
//                 return Container(
//                     height: bannerAd.size.height.toDouble(),
//                     width: bannerAd.size.width.toDouble(),
//                     child: AdWidget(ad: bannerAd));
//               }

//               final AdManagerBannerAd? adManagerBannerAd = _adManagerBannerAd;
//               if (index == 10 &&
//                   _adManagerBannerAdIsLoaded &&
//                   adManagerBannerAd != null) {
//                 return Container(
//                     height: adManagerBannerAd.sizes[0].height.toDouble(),
//                     width: adManagerBannerAd.sizes[0].width.toDouble(),
//                     child: AdWidget(ad: _adManagerBannerAd!));
//               }

//               final NativeAd? nativeAd = _nativeAd;
//               if (index == 15 && _nativeAdIsLoaded && nativeAd != null) {
//                 return Container(
//                     width: 250, height: 350, child: AdWidget(ad: nativeAd));
//               }

//               return const Text(
//                 Constants.placeholderText,
//                 style: TextStyle(fontSize: 24),
//               );
//             },
//           ),
//         ),
//       );

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     // Create the ad objects and load ads.
//     _bannerAd = BannerAd(
//         size: AdSize.banner,
//         adUnitId: Platform.isAndroid
//             ? 'ca-app-pub-3940256099942544/6300978111'
//             : 'ca-app-pub-3940256099942544/2934735716',
//         listener: BannerAdListener(
//           onAdLoaded: (Ad ad) {
//             print('$BannerAd loaded.');
//             setState(() {
//               _bannerAdIsLoaded = true;
//             });
//           },
//           onAdFailedToLoad: (Ad ad, LoadAdError error) {
//             print('$BannerAd failedToLoad: $error');
//             ad.dispose();
//           },
//           onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
//           onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
//         ),
//         request: const AdRequest())
//       ..load();

//     _nativeAd = NativeAd(
//       adUnitId: Platform.isAndroid
//           ? 'ca-app-pub-3940256099942544/2247696110'
//           : 'ca-app-pub-3940256099942544/3986624511',
//       request: const AdRequest(),
//       factoryId: 'adFactoryExample',
//       listener: NativeAdListener(
//         onAdLoaded: (Ad ad) {
//           print('$NativeAd loaded.');
//           setState(() {
//             _nativeAdIsLoaded = true;
//           });
//         },
//         onAdFailedToLoad: (Ad ad, LoadAdError error) {
//           print('$NativeAd failedToLoad: $error');
//           ad.dispose();
//         },
//         onAdOpened: (Ad ad) => print('$NativeAd onAdOpened.'),
//         onAdClosed: (Ad ad) => print('$NativeAd onAdClosed.'),
//       ),
//     )..load();

//     _adManagerBannerAd = AdManagerBannerAd(
//       adUnitId: '/6499/example/banner',
//       request: const AdManagerAdRequest(nonPersonalizedAds: true),
//       sizes: <AdSize>[AdSize.largeBanner],
//       listener: AdManagerBannerAdListener(
//         onAdLoaded: (Ad ad) {
//           print('$AdManagerBannerAd loaded.');
//           setState(() {
//             _adManagerBannerAdIsLoaded = true;
//           });
//         },
//         onAdFailedToLoad: (Ad ad, LoadAdError error) {
//           print('$AdManagerBannerAd failedToLoad: $error');
//           ad.dispose();
//         },
//         onAdOpened: (Ad ad) => print('$AdManagerBannerAd onAdOpened.'),
//         onAdClosed: (Ad ad) => print('$AdManagerBannerAd onAdClosed.'),
//       ),
//     )..load();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _bannerAd?.dispose();
//     _adManagerBannerAd?.dispose();
//     _nativeAd?.dispose();
//   }
// }

// class NativeTemplateExample extends StatefulWidget {
//   @override
//   _NativeTemplateExampleExampleState createState() =>
//       _NativeTemplateExampleExampleState();
// }

// class _NativeTemplateExampleExampleState extends State<NativeTemplateExample> {
//   NativeAd? _nativeAd;
//   bool _nativeAdIsLoaded = false;

//   @override
//   Widget build(BuildContext context) => Scaffold(
//       appBar: AppBar(
//         title: const Text('Native templates example'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: ListView.separated(
//             itemCount: 10,
//             separatorBuilder: (BuildContext context, int index) {
//               return Container(
//                 height: 40,
//               );
//             },
//             itemBuilder: (BuildContext context, int index) {
//               if (index == 5 && _nativeAd != null && _nativeAdIsLoaded) {
//                 return Align(
//                     alignment: Alignment.center,
//                     child: ConstrainedBox(
//                       constraints: const BoxConstraints(
//                         minWidth: 300,
//                         minHeight: 350,
//                         maxHeight: 400,
//                         maxWidth: 450,
//                       ),
//                       child: AdWidget(ad: _nativeAd!),
//                     ));
//               }
//               return const Text(
//                 Constants.placeholderText,
//                 style: TextStyle(fontSize: 24),
//               );
//             },
//           ),
//         ),
//       ));

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     // Create the ad objects and load ads.
//     _nativeAd = NativeAd(
//       adUnitId: '/6499/example/native',
//       request: const AdRequest(),
//       listener: NativeAdListener(
//         onAdLoaded: (Ad ad) {
//           print('$NativeAd loaded.');
//           setState(() {
//             _nativeAdIsLoaded = true;
//           });
//         },
//         onAdFailedToLoad: (Ad ad, LoadAdError error) {
//           print('$NativeAd failedToLoad: $error');
//           ad.dispose();
//         },
//         onAdOpened: (Ad ad) => print('$NativeAd onAdOpened.'),
//         onAdClosed: (Ad ad) => print('$NativeAd onAdClosed.'),
//       ),
//       nativeTemplateStyle: NativeTemplateStyle(
//         templateType: TemplateType.medium,
//         mainBackgroundColor: Colors.white12,
//         callToActionTextStyle: NativeTemplateTextStyle(
//           size: 16.0,
//         ),
//         primaryTextStyle: NativeTemplateTextStyle(
//           textColor: Colors.black38,
//           backgroundColor: Colors.white70,
//         ),
//       ),
//     )..load();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _nativeAd?.dispose();
//   }
// }

// class Constants {
//   /// Placeholder text.
//   static const String placeholderText =
//       'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod'
//       ' tempor incididunt ut labore et dolore magna aliqua. Faucibus purus in'
//       ' massa tempor. Quis enim lobortis scelerisque fermentum dui faucibus'
//       ' in. Nibh praesent tristique magna sit amet purus gravida quis.'
//       ' Magna sit amet purus gravida quis blandit turpis cursus in. Sed'
//       ' adipiscing diam donec adipiscing tristique. Urna porttitor rhoncus'
//       ' dolor purus non enim praesent. Pellentesque habitant morbi tristique'
//       ' senectus et netus. Risus ultricies tristique nulla aliquet enim tortor'
//       ' at.';
// }
