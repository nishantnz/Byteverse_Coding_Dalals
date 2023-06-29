import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthai/colors.dart';
import 'package:healthai/common/widgets/error.dart';
import 'package:healthai/common/widgets/loader.dart';
import 'package:healthai/features/auth/controller/auth_controller.dart';
import 'package:healthai/features/auth/screen/common/on_boardingpage.dart';
import 'package:healthai/features/homepage/doctor/screens/doctor_home_page.dart';
import 'package:healthai/features/homepage/patient/screens/patient_home_page.dart';
import 'package:healthai/firebase_options.dart';
import 'package:healthai/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Health AI',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: const AppBarTheme(color: appBarColor),
        bottomAppBarTheme: const BottomAppBarTheme(color: backgroundColor),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: backgroundColor,
        ),
        
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: ref.watch(userDataAuthProvider).when(
            data: (data) {
              if (data != null) {
                if (data.startsWith('patient')) {
                  return const PatientHomePage();
                }
                return const DoctorHomePage();
              }
              return const OnBoarding();
            },
            error: (error, stackTrace) => ErrorScreen(
              error: error.toString(),
            ),
            loading: () => const LoaderPage(),
          ),
    );
  }
}
