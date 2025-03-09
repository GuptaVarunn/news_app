import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return const FirebaseOptions(
      apiKey: "AIzaSyDepHuZngeoEghxkHu01Cpf879dHfZeNyo",
      authDomain: "news-app-e4a4e.firebaseapp.com",
      projectId: "news-app-e4a4e",
      storageBucket: "news-app-e4a4e.appspot.com",
      messagingSenderId: "398290487719",
      appId: "1:398290487719:android:7e4af4cd3624e4e8f3ce82",
      measurementId: "G-1KKP07WE1S", // Optional for analytics
    );
  }
}
