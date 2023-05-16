import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'homescreen.dart';
import 'login_page.dart';

class AuthCheckPage extends StatelessWidget {
  const AuthCheckPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Aguardando a verificação de autenticação
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          // Verifica se o usuário está autenticado
          if (snapshot.hasData) {
            // Redireciona para a página inicial se o usuário estiver autenticado
            return HomeScreen();
          } else {
            // Redireciona para a página de login se o usuário não estiver autenticado
            return LoginPage(
              onLoginSuccess: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            );
          }
        }
      },
    );
  }
}
