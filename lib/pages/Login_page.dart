
import 'package:app_academia/controllers/AuthController.dart';
import 'package:flutter/material.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _emailcontroller = TextEditingController(); 
  final TextEditingController _senhacontroller = TextEditingController(); 
  final _focusSenha = FocusNode();

  final _formkey = GlobalKey<FormState>();


 @override dispose(){
  _emailcontroller.dispose();
  _senhacontroller.dispose();
  _focusSenha.dispose();
  super.dispose();
 }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: Text("Login"),
    ),
    
      body:  Center(
          child: Form(
            key: _formkey,
            child: 
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment:  MainAxisAlignment.center,
              children: [ 
               TextFormField(
                controller: _emailcontroller,
                onFieldSubmitted: (valor){
              FocusScope.of(context).requestFocus(_focusSenha);
            },
                decoration: InputDecoration(hintText: "E-mail"),
                  validator: (value) {
                  if(value == null || value.isEmpty){
                    return "Preencha esse campo";
                  }
                  else{
                    return null;
                  }
                },
               ),
            
               TextFormField(
                focusNode: _focusSenha,
                controller: _senhacontroller,
                decoration: InputDecoration(hintText: "senha"),
                obscureText: true,
                validator: (value) {
                  if(value == null || value.isEmpty){
                    return "Preencha esse campo";
                  }
                  if(value.length < 6){
                  return "A senha não pode ter menos de 6 caracteres";
            
                  }
                  else{
                    return null;
                  }
                },
               ),SizedBox(height: 16,),
            
               ElevatedButton(
                onPressed: ()async {
                if (_formkey.currentState!.validate()){
                 try{
                  await Authcontroller().login( _emailcontroller.text, _senhacontroller.text);
                  if(!context.mounted) return;                                    
                 }
                 catch(erro){
                  if(!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("E-mail ou senha incorretos"))
                    );}}
                },
                 child: Text("Entrar")
                 ), SizedBox(height: 16,),
            
                  ElevatedButton(
                onPressed: ()async{
                if (_formkey.currentState!.validate()){
                 try{
                  await Authcontroller().cadastro( _emailcontroller.text, _senhacontroller.text);
                  if(!context.mounted) return; 
                    
                 }
                 catch(erro){
                  if(!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Não foi possivel criar conta, tente novamente"))
                    );}}
                },
                 child: Text("Cadastro")
                 ), SizedBox(height: 16,)
            
            
            
              
              ],
              
            ),
          )
          ),
        ),
      );
  }
}