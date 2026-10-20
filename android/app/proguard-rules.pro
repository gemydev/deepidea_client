# Most third-party libraries in this project (Firebase, GMS, OkHttp, protobuf,
# edfa Pay, SignalR, Play Core) ship their own consumer ProGuard rules, so we
# only need `-dontwarn` for their optional/reflected code and explicit `-keep`
# rules for libraries that reach across JNI (Zego, WebRTC).

# ---------------- Flutter ----------------
-dontwarn io.flutter.embedding.**
-dontwarn io.flutter.plugin.**
-if class * implements io.flutter.embedding.engine.plugins.FlutterPlugin
-keep,allowshrinking,allowobfuscation class <1>

# ---------------- Zego (Express + ZIM + UIKit + ZPNs) ----------------
# Zego bridges to native via JNI reflection; class/method names must survive R8.
-keep class im.zego.** { *; }
-keep class org.webrtc.** { *; }
-dontwarn im.zego.**
-dontwarn org.webrtc.**

# ---------------- Firebase / GMS (optional deps + reflected internals) ----------------
-dontwarn com.google.firebase.**
-dontwarn com.google.android.gms.**
-dontwarn com.google.protobuf.**

# ---------------- edfa Pay SDK ----------------
-dontwarn com.edfa.**

# ---------------- Networking ----------------
-dontwarn okhttp3.**
-dontwarn okio.**
-dontwarn org.conscrypt.**
-dontwarn javax.annotation.**

# ---------------- Play Core (referenced by Flutter's deferred components glue) ----------------
-dontwarn com.google.android.play.core.**

# ---------------- SignalR ----------------
-dontwarn com.microsoft.signalr.**

# ---------------- General ----------------
-keepattributes *Annotation*
-keepclassmembers enum * { *; }
-keepclassmembers class * implements android.os.Parcelable {
    public static final ** CREATOR;
}
