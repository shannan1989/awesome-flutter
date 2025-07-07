# awesomeflutter

Flutter 使用的是 Dart 语言。

## 常见操作命令

- flutter doctor

- flutter analyze

- flutter run

- 获取依赖：执行 flutter pub get 命令，会根据pubspec.yaml的声明，获取依赖并更新pubspec.lock。

- 检查更新：执行 flutter pub outdated 命令，查看有哪些依赖包存在可用的更新。该命令会列出所有依赖包的当前版本、pubspec.yaml 中指定的版本约束以及可用的更新版本，方便你了解更新情况。

- 升级依赖：使用 flutter pub upgrade 命令，可以更新依赖到符合p ubspec.yaml 中版本约束的最新版本，同时更新pubspec.lock。

- 清理缓存：运行 flutter pub cache repair 命令，能够修复依赖缓存问题。
