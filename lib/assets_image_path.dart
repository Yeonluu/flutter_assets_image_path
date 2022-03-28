/// @Author: 初然
/// @Date: 2022-03-26
/// @Description: 图片资源自动生成dart文件

import 'dart:io';
import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';
import 'package:path/path.dart';

class AssetsImagePathGenerator extends GeneratorForAnnotation<AssetsImagePath> {
  String _codeContent = '';

  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    String explanation =
        '// **************************************************************************\n'
        '// 如果存在新文件需要更新，建议先执行清除命令：\n'
        '// flutter packages pub run build_runner clean \n'
        '// \n'
        '// 然后执行下列命令重新生成相应文件：\n'
        '// flutter packages pub run build_runner build \n'
        '// **************************************************************************';

    /// 图片资源路径
    var imagesPath = annotation.read('path').literalValue as String;
    if (!imagesPath.endsWith('/')) {
      imagesPath = '$imagesPath/';
    }

    /// Library
    var partOfLibrary =
        annotation.read('partOfLibrary').literalValue as String?;
    if (partOfLibrary != null) {
      partOfLibrary = 'part of $partOfLibrary;\n';
    } else {
      partOfLibrary = '';
    }

    /// 类名
    var className = annotation.read('className').literalValue as String?;
    if (className == null) {
      className = basenameWithoutExtension(element.source?.shortName ?? '');
      className = changeToCamelCase(className, firstUpper: true);
      if (partOfLibrary.isNotEmpty) {
        className = '_$className';
      }
    }

    /// 遍历处理图片资源路径
    handleImages(imagesPath);

    /// 生成的代码
    return '$explanation\n\n'
        '$partOfLibrary'
        'class $className{\n'
        '    $_codeContent\n'
        '}';
  }

  void handleImages(String path) {
    var directory = Directory(path);

    List<FileSystemEntity> fileList = [];

    for (var file in directory.listSync()) {
      var type = file.statSync().type;
      if (type == FileSystemEntityType.directory &&
          !file.path.contains("3.0x")) {
        handleImages('${file.path}/');
      } else if (type == FileSystemEntityType.file) {
        var ex = extension(file.path).toLowerCase();
        if (ex == 'png' || ex == 'jpg' || ex == 'jpeg' || ex == 'svg') {
          fileList.add(file);
        }
      }
    }

    fileList.sort((left, right) => basenameWithoutExtension(left.path)
        .compareTo(basenameWithoutExtension(right.path)));

    for (var file in fileList) {
      basenameWithoutExtension(file.path);

      var name = basenameWithoutExtension(file.path);
      name = changeToCamelCase(name);

      _codeContent =
          '$_codeContent\n\t\t\t\tlate final $name = \'${file.path}\';\n';
    }
  }

  /// 下划线转驼峰
  String changeToCamelCase(String word, {bool firstUpper = false}) {
    word = word.toLowerCase();
    if (word.contains("_")) {
      List<String> words = word.split("_");
      String result = '';
      if (!firstUpper) {
        result = words.removeAt(0);
      }
      for (var value in words) {
        result += (value[0].toUpperCase() + value.substring(1).toLowerCase());
      }
      return result;
    } else {
      return word;
    }
  }
}

class AssetsImagePath {
  final String path;
  final String? className;
  final String? partOfLibrary;

  const AssetsImagePath(this.path, {this.className, this.partOfLibrary});
}
