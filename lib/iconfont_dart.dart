import 'dart:io';
import 'package:html/parser.dart' show parse;

class IconfontDart {
  /// iconfont中 demo_index.html 所在路径
  String dir;
  /// 生成dart文件路径
  String buildDir;
  /// 创建的类名 默认值：IconFonts
  String className;
  

  /// 根据iconfont自动生成对应的dart文件
  IconfontDart(String dir, String buildDir, {
    String className = 'IconFonts'
  }) {
    this.dir = dir;
    this.buildDir = buildDir;
    this.className = className;

    this._init();
  }

  _init() {
    List fontClassName;
    List unicode;
    // 读取demo_index.html 获取unicode
    File(dir).readAsString()
    .then((onValue){
      var doc = parse(onValue);
      var div = doc.getElementsByClassName('content');
      // 遍历获取 unicode || classname
      div.forEach((val) {
        // font-class
        if(val.className.indexOf('font-class') > -1) {
          var li = _getLi(val);
          fontClassName = _getSpan(li, type: 'classname');
        }

        // unicode dom
        if(val.className.indexOf('unicode') > -1) {
          var li = _getLi(val);
          unicode = _getSpan(li, type: 'unicode');
        }
      });
      _writeIcon(fontClassName, unicode);
    });
  }

  // 写入文件
  _writeIcon(List classname, List unicode) {
    String str = "";

    classname.asMap().forEach((index, val){
      str = '$str${_formatIcon(val, unicode[index])}';
    });

    File(buildDir).writeAsString("""import 'package:flutter/material.dart';\n
class $className {
  $className._();
$str
}    
""");
  }

  /// 格式化icon代码
  _formatIcon(classname, unicode) {
    return  """  static const IconData $classname = IconData($unicode, fontFamily: 'iconfont');\n""";  
  }


  /// 获取 unicode || classname
  /// @type  classname || unicode
  _getSpan(doc, {String type}) {
    List<String> arr = List<String>();
    doc.forEach((val) {
      var div = val.getElementsByClassName('code-name')[0];
      var str = div.innerHtml.toString();
      if(type == 'classname') { // classname
        var span = str.replaceAll(new RegExp('\\.|\\n|\\s'), '');
        arr.add(span.replaceAll(RegExp('\\-'), '_'));
      } else { // unicode
        arr.add('0${str.split('#')[1].replaceAll(';', '')}');
      }
    });

    return arr;
  }

  /// 获取li
  _getLi(doc) {
    var ul = doc.getElementsByClassName('icon_lists')[0];
    var li = ul.getElementsByTagName('li');

    return li;
  }
}

