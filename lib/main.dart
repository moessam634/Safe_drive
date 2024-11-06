import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:safedrive/app/app_texts.dart';
import 'package:safedrive/bloc_observer.dart';
import 'package:safedrive/domain/models/emergency_model.dart';
import 'package:safedrive/presenation/screens/myapp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  Bloc.observer = MyBlocObserver();
  Hive.registerAdapter(EmergencyModelAdapter());
  await Hive.openBox<EmergencyModel>(
    AppText.emergencyBox,
  );

  runApp(
    const MyApp(),
  );
}
