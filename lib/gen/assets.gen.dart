// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AsstesGen {
  const $AsstesGen();

  /// Directory path: asstes/images
  $AsstesImagesGen get images => const $AsstesImagesGen();

  /// Directory path: asstes/profileImages
  $AsstesProfileImagesGen get profileImages => const $AsstesProfileImagesGen();
}

class $AsstesImagesGen {
  const $AsstesImagesGen();

  /// Directory path: asstes/images/png
  $AsstesImagesPngGen get png => const $AsstesImagesPngGen();

  /// Directory path: asstes/images/svg
  $AsstesImagesSvgGen get svg => const $AsstesImagesSvgGen();
}

class $AsstesProfileImagesGen {
  const $AsstesProfileImagesGen();

  /// File path: asstes/profileImages/image 1.png
  AssetGenImage get image1 =>
      const AssetGenImage('asstes/profileImages/image 1.png');

  /// File path: asstes/profileImages/image 2.png
  AssetGenImage get image2 =>
      const AssetGenImage('asstes/profileImages/image 2.png');

  /// File path: asstes/profileImages/image 3.png
  AssetGenImage get image3 =>
      const AssetGenImage('asstes/profileImages/image 3.png');

  /// File path: asstes/profileImages/image 4.png
  AssetGenImage get image4 =>
      const AssetGenImage('asstes/profileImages/image 4.png');

  /// File path: asstes/profileImages/image 5.png
  AssetGenImage get image5 =>
      const AssetGenImage('asstes/profileImages/image 5.png');

  /// File path: asstes/profileImages/image 6.png
  AssetGenImage get image6 =>
      const AssetGenImage('asstes/profileImages/image 6.png');

  /// File path: asstes/profileImages/image 7.png
  AssetGenImage get image7 =>
      const AssetGenImage('asstes/profileImages/image 7.png');

  /// File path: asstes/profileImages/image 8.png
  AssetGenImage get image8 =>
      const AssetGenImage('asstes/profileImages/image 8.png');

  /// File path: asstes/profileImages/image 9.png
  AssetGenImage get image9 =>
      const AssetGenImage('asstes/profileImages/image 9.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    image1,
    image2,
    image3,
    image4,
    image5,
    image6,
    image7,
    image8,
    image9,
  ];
}

class $AsstesImagesPngGen {
  const $AsstesImagesPngGen();

  /// File path: asstes/images/png/blue-screen.png
  AssetGenImage get blueScreen =>
      const AssetGenImage('asstes/images/png/blue-screen.png');

  /// File path: asstes/images/png/dark_screen.png
  AssetGenImage get darkScreen =>
      const AssetGenImage('asstes/images/png/dark_screen.png');

  /// File path: asstes/images/png/gray_screen.png
  AssetGenImage get grayScreen =>
      const AssetGenImage('asstes/images/png/gray_screen.png');

  /// File path: asstes/images/png/purple_screen.png
  AssetGenImage get purpleScreen =>
      const AssetGenImage('asstes/images/png/purple_screen.png');

  /// File path: asstes/images/png/red_screen.png
  AssetGenImage get redScreen =>
      const AssetGenImage('asstes/images/png/red_screen.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    blueScreen,
    darkScreen,
    grayScreen,
    purpleScreen,
    redScreen,
  ];
}

class $AsstesImagesSvgGen {
  const $AsstesImagesSvgGen();

  /// File path: asstes/images/svg/ic_explore.svg
  SvgGenImage get icExplore =>
      const SvgGenImage('asstes/images/svg/ic_explore.svg');

  /// File path: asstes/images/svg/ic_home.svg
  SvgGenImage get icHome => const SvgGenImage('asstes/images/svg/ic_home.svg');

  /// File path: asstes/images/svg/ic_profiel.svg
  SvgGenImage get icProfiel =>
      const SvgGenImage('asstes/images/svg/ic_profiel.svg');

  /// File path: asstes/images/svg/ic_search.svg
  SvgGenImage get icSearch =>
      const SvgGenImage('asstes/images/svg/ic_search.svg');

  /// File path: asstes/images/svg/movie_logo.svg
  SvgGenImage get movieLogo =>
      const SvgGenImage('asstes/images/svg/movie_logo.svg');

  /// File path: asstes/images/svg/route_logo.svg
  SvgGenImage get routeLogo =>
      const SvgGenImage('asstes/images/svg/route_logo.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
    icExplore,
    icHome,
    icProfiel,
    icSearch,
    movieLogo,
    routeLogo,
  ];
}

class Assets {
  const Assets._();

  static const $AsstesGen asstes = $AsstesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}

class SvgGenImage {
  const SvgGenImage(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = false;

  const SvgGenImage.vec(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    _svg.ColorMapper? colorMapper,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
        colorMapper: colorMapper,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter:
          colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
