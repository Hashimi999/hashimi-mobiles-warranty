import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/home_screen.dart';

const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
const supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty) {
    await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
  }
  runApp(const HashimiMobilesApp());
}

class HashimiMobilesApp extends StatelessWidget {
  const HashimiMobilesApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'HASHIMI MOBILES',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF123A78),
            primary: const Color(0xFF123A78),
            secondary: const Color(0xFFD6A83F),
          ),
          scaffoldBackgroundColor: const Color(0xFFF5F7FB),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF102D65),
            foregroundColor: Colors.white,
            centerTitle: false,
          ),
        ),
        home: const HomeScreen(),
      );
}
