import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:projetpfe/data/repositories/authentication.dart';
import 'package:projetpfe/features/screens/onboarding/onboarding.dart';
import 'package:projetpfe/firebase_options.dart';
import 'package:projetpfe/themes/theme.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> main() async{
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  await Future.delayed(const Duration(seconds: 2));

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlutterNativeSplash.remove();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then(
      (FirebaseApp value) => Get.put(AuthenticationRepository()),
  );

  runApp(const MyApp());
}
class MyApp extends StatelessWidget{
  const MyApp({super.key});
  @override
  Widget build(BuildContext context){
    return GetMaterialApp(//racine widget< <<
      debugShowCheckedModeBanner: false,// contrôle l'affichage de la bannière de débogage
      title : 'House Mate Hub',
      theme : lightMode,
      darkTheme: darkMode,
      home: const OnboardingScreen(),

    );
  }

}