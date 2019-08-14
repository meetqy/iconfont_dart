import 'dart:io';
import 'package:html/parser.dart' show parse;

class IconfontDart {
  String dir;
  String buildDir;
  String toHumpStr;
  double defaultFontSize;
  

  /// 根据iconfont自动生成对应的dart文件
  /// 
  /// @dir: iconfont中 demo_index.html目录
  /// 
  /// @buildDir: 生成dart文件路径
  /// 
  /// @toHumpStr: 将classname替换为驼峰命名  eg: icon-name 转换 iconName 
  /// eg: icon-name => iconName  toHumpStr传入 '-'
  /// 
  /// @fontSize: 默认的fontSize
  IconfontDart(String dir, String buildDir, {String toHumpStr, double defaultFontSize}) {
    this.dir = dir;
    this.buildDir = buildDir;
    this.toHumpStr = toHumpStr;
    this.defaultFontSize = defaultFontSize;

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

    File(buildDir).writeAsString("import 'package:flutter/material.dart';\n\n$str");

  }

  // 格式化icon代码
  _formatIcon(classname, unicode) {
    return  """Icon $classname({double size = defaultFontSize, Color color}) => Icon(
  IconData($unicode, fontFamily: 'iconfont'),
  size: size,
  color: color,
);\n\n""";  
  }


  /// 获取 unicode || classname
  /// 
  /// @type  classname || unicode
  _getSpan(doc, {String type}) {
    List<String> arr = List<String>();
    doc.forEach((val) {
      var div = val.getElementsByClassName('code-name')[0];
      var str = div.innerHtml.toString();
      if(type == 'classname') { // classname
        var span = str.replaceAll(new RegExp('\\.|\\n|\\s'), '');
        toHumpStr == null || toHumpStr.isEmpty ? arr.add(span.replaceAll(RegExp('\\-'), '')) : arr.add(_toHump(span, toHumpStr));
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

  /// 转换成驼峰
  /// 
  /// @str  需要转换的字符串
  /// @chart 下划线转换成驼峰  '_'
  _toHump(String str, String char) {
    var s = str.replaceAllMapped(
      new RegExp('$char(\\w)'),(Match m) {
        return m[1].toUpperCase();
      }
    );
    return s;
  }
}

