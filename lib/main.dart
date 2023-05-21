import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient_app/layout/cubit/patient_cubit.dart';
import 'package:patient_app/layout/patinet_layout.dart';
import 'package:patient_app/shared/network/local/cache_helper.dart';
import 'package:patient_app/shared/network/remote/dio_helper.dart';

import 'bloc_observer.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  await DioHelper.init();
  await CacheHelper.init();
  // Colors.to convert tomorrow From Left :  #0c3b46 ,  #145362, #2c7688, #4b8896, #8eb8c2, #adc8c8
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => PatientCubit(),
          ),

        ],
        child: BlocConsumer<PatientCubit, PatientState>(
            listener: (context, state) {},
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: PatientLayout(),
              );
            }));

  }
}



