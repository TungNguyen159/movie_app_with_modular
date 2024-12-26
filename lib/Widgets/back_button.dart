import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BackButton extends StatelessWidget implements PreferredSizeWidget{
  const BackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            // Modular.to.navigate("/main/home/");
            Modular.to.pop();
          },
        ),
      ),
    );
  }
  
  @override
  Size get preferredSize =>  const Size.fromHeight(kToolbarHeight);
}