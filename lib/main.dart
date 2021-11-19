import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sawo_app/screen/home.dart';
import 'package:sawo_app/screen/login.dart';
import 'package:sawo_app/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget  {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        title: 'Sawo App',
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
        theme: ThemeData(
            scaffoldBackgroundColor: AppTheme.primaryColor,
            primaryColor: AppTheme.primaryColor,
            backgroundColor: AppTheme.primaryColor,
            secondaryHeaderColor: AppTheme.secondaryColor,
            highlightColor: AppTheme.highlightColor,
            indicatorColor: AppTheme.tertiaryColor,
            textTheme: TextTheme(
              headline1: GoogleFonts.rubik(
                color: AppTheme.tertiaryColor,
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
              headline2: GoogleFonts.rubik(
                color: AppTheme.secondaryColor,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
              bodyText1: GoogleFonts.rubik(
                color: AppTheme.tertiaryColor,
                fontSize: 16,
              ),
              bodyText2: GoogleFonts.rubik(
                color: AppTheme.tertiaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
              button: GoogleFonts.rubik(
                color: AppTheme.primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),

            ), colorScheme: ColorScheme.fromSwatch()),
      ),
    );
  }
}
