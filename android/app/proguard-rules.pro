-keep class **.zego.** { *; }

# Flutter embedding (R8 minify)
-dontwarn io.flutter.plugin.**
-if class * implements io.flutter.embedding.engine.plugins.FlutterPlugin
-keep,allowshrinking,allowobfuscation class <1>
