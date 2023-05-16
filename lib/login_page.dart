import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tentativa_1/app_theme.dart';
import 'package:tentativa_1/feed.dart';
import 'package:tentativa_1/homescreen.dart';
import 'package:tentativa_1/register_page.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onLoginSuccess;

  const LoginPage({Key? key, required this.onLoginSuccess}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '',
          style: TextStyle(color: AppTheme.vinho),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Entre ou cadastre-se',
                      style: AppTheme.display1,
                    ),
                    SizedBox(height: 35),
                    TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira um e-mail';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'E-mail',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira uma senha';
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });
                          try {
                            UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                            setState(() {
                              _isLoading = false;
                            });
                            widget.onLoginSuccess();
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FeedPage()));
                          } on FirebaseAuthException catch (e) {
                            setState(() {
                              _isLoading = false;
                            });
                            if (e.code == 'user-not-found') {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: Text('Usuário não encontrado'),
                                  content: Text('O e-mail ou a senha estão incorretos'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            } else if (e.code == 'wrong-password') {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: Text('Senha incorreta'),
                                  content: Text('O e-mail ou a senha estão incorretos'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text(''),
),
],
),
);
}
}
}
},
child: Text('Entrar'),
),
SizedBox(height: 16),
TextButton(
onPressed: () {
Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
},
child: Text(
'Não tem uma conta? Cadastre-se aqui',
style: TextStyle(
color: AppTheme.vinho,
),
),
),
],
),
),
),
);
}
}