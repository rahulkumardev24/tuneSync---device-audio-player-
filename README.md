# TuneSync 🎵

TuneSync is a modern Flutter music player app that provides a seamless audio experience with beautiful UI animations and effects.

## TuneSync 🎵 UI
<img  src = "https://github.com/rahulkumardev24/tuneSync---device-audio-player-/blob/master/TuneSync.png" />
## Screenshort 
<div>
  <img  src = "https://github.com/rahulkumardev24/tuneSync---device-audio-player-/blob/master/Screenshot_20250402_155433.png" height = 600 />
<img  src = "https://github.com/rahulkumardev24/tuneSync---device-audio-player-/blob/master/Screenshot_20250402_155503.png" height = 600 />
<img  src = "https://github.com/rahulkumardev24/tuneSync---device-audio-player-/blob/master/Screenshot_20250402_155534.png" height = 600 />
</div>

## 🚀 Features
- 🎶 Play audio files from the device.
- 🔍 Fetch songs using **on_audio_query**.
- 🎛️ Interactive **progress bar**.
- ✨ Smooth text scrolling with **marquee**.
- 🎧 Beautiful **glowing effect** using AvatarGlow.
- 🎨 Animated UI elements with **Lottie**.

## 🛠️ Technologies & Dependencies

| Package                  | Version  | Purpose                 |
|-------------------------|----------|-------------------------|
| permission_handler      | ^11.4.0  | Handle audio permissions |
| just_audio             | ^0.9.46  | Audio playback          |
| on_audio_query         | ^2.9.0   | Fetch local music files |
| marquee               | ^2.3.0   | Text scrolling effect   |
| audio_video_progress_bar | ^2.0.3 | Custom progress bar     |
| avatar_glow           | ^3.0.1   | Glowing animation       |
| lottie                | ^3.3.1   | Lottie animations       |

## 📲 Installation
1. Clone the repository:
   ```sh
   git clone https://github.com/yourusername/tunesync.git
   ```
2. Navigate to the project directory:
   ```sh
   cd tunesync
   ```
3. Install dependencies:
   ```sh
   flutter pub get
   ```
4. Run the app:
   ```sh
   flutter run
   ```

## 🔒 Permissions
Make sure to request **storage & audio permissions** in `AndroidManifest.xml`:
```xml
  <uses-permission android:name="android.permission.READ_MEDIA_AUDIO"/>
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" android:maxSdkVersion="32"/>
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" android:maxSdkVersion="32"/>
    <uses-permission android:name="android.permission.MANAGE_EXTERNAL_STORAGE"/>
    <uses-permission android:name="android.permission.WAKE_LOCK"/>
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE"/>
```
For **Android 13+**, use the latest permission handling from `permission_handler`.

## 📜 License
This project is licensed under the MIT License.

---
Made with ❤️ by Rahul Kumar Sahu 🚀

