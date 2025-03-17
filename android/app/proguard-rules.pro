-keepclassmembers class * {
    void onWindowFocusChanged(boolean);
}

# Suppress MIUI-specific logs
-keep class miui.** { *; }
-dontwarn miui.** 