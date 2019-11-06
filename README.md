<!--
 * @Author: meetqy
 * @since: 2019-07-26 10:18:13
 * @lastTime: 2019-11-06 12:10:56
 * @LastEditors: meetqy
 -->

# iconfont_dart

导入 iconfont，只需要编译一次，就可以帮你快速生成 icon。

To import iconcont, you only need to compile it once to help you generate icons quickly.

## 目录

- [预览](#预览)
- [使用](#使用)
- [参数说明](#参数说明)
- [相关插件](#相关插件)
- [维护者](#维护者)
- [欢迎 PR](#欢迎PR)
- [使用许可](#使用许可)

## 预览

![](preview.png)

## 使用

```dart
main() {
  IconfontDart(
    '../lib/assets/fonts/demo_index.html',
    './a.dart'
  );
}
```

> 注意：通过 dart xxx.dart 执行生成 dart 文件

## 参数说明

| 参数      | 说明                             |
| --------- | -------------------------------- |
| dir       | iconfont 中 demo_index.html 目录 |
| buildDir  | 生成 dart 文件路径               |
| className | 生成的类名                       |

## 相关插件

| 插件                                                  | 说明      |
| ----------------------------------------------------- | --------- |
| [html](https://github.com/Sub6Resources/flutter_html) | 解析 html |

## 维护者

[@meetqy](https://github.com/meetqy).

## 欢迎 PR

非常欢迎你的加入! [提一个 Issue](https://github.com/meetqy/iconfont_dart/issues/new) 或者提交一个 Pull Request.

## 使用许可

[MIT](LICENSE) © MEETQY
