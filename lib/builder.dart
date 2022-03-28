import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';
import 'assets_image_path.dart';

Builder imagePathBuilder(BuilderOptions options) =>
    LibraryBuilder(AssetsImagePathGenerator());
