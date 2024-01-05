import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/auth.dart';

enum AuthMode { Signup, Login }

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final _passwordController = TextEditingController();
  AuthMode _authMode = AuthMode.Login;
  final Map<String, String> _authData = {
    "email": "",
    "password": "",
  };

  bool _isLogin() => _authMode == AuthMode.Login;
  bool _isSignup() => _authMode == AuthMode.Signup;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        height: _isLogin() ? 320 : 400,
        width: MediaQuery.of(context).size.width * 0.7,
        padding: const EdgeInsets.all(16),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: "Email"),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (email) => _authData["email"] = email ?? "",
                  validator: (_email) {
                    final email = _email ?? "";
                    if (email.trim().isEmpty) {
                      return "Informe um email válido !";
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Senha"),
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  controller: _passwordController,
                  onSaved: (password) => _authData["password"] = password ?? "",
                  validator: (_password) {
                    final password = _password ?? "";
                    if (password.isEmpty || password.length < 5) {
                      return "Informe uma senha válida !";
                    } else {
                      return null;
                    }
                  },
                ),
                if (_isSignup())
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Confirmar Senha"),
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    validator: _isLogin()
                        ? null
                        : (_password) {
                            final password = _password ?? "";
                            if (password != _passwordController.text) {
                              return "Senhas informadas não conferem !";
                            } else {
                              return null;
                            }
                          },
                  ),
                const SizedBox(height: 20),
                isLoading
                    ? Center(
                        child: CircularProgressIndicator(color: Colors.deepPurple.shade900),
                      )
                    : ElevatedButton(
                        onPressed: _submit,
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            backgroundColor: Colors.deepPurple.shade900,
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8)),
                        child: Text(_authMode == AuthMode.Login ? "ENTRAR" : "REGISTRAR"),
                      ),
                const Spacer(),
                TextButton(
                  onPressed: _switchAuthMode,
                  child: Text(_isLogin() ? "DESEJA REGISTAR?" : "JÁ POSSUI CONTA?"),
                )
              ],
            )),
      ),
    );
  }

  _submit() async {
    final _isValid = _formKey.currentState?.validate() ?? false;

    if (!_isValid) {
      return;
    }
    setState(() => isLoading = true);

    _formKey.currentState?.save();
    Auth auth = Provider.of(context, listen: false);

    if (_isLogin()) {
      //login
    } else {
      //registrar
      await auth.signup(
        _authData["email"]!,
        _authData["password"]!,
      );
    }
  }

  _switchAuthMode() {
    setState(() {
      if (_isLogin()) {
        _authMode = AuthMode.Signup;
      } else {
        _authMode = AuthMode.Login;
      }
    });
  }
}
