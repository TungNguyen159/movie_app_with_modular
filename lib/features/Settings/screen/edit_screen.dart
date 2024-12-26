import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../Widgets/app_button.dart';



class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController? _nameController;
  TextEditingController? _emailController;
  var _emailValidate = true;
  var _nameValidate = true;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController?.dispose();
    _emailController?.dispose();
    super.dispose();
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text(
            'Select where You want your picture taken from',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Camera'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Gallery'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
           //  Modular.to.navigate("/main/setting");
            Modular.to.pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                  alignment: Alignment.bottomCenter,
                  clipBehavior: Clip.none,
                  children: [
                    Center(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(90.0),
                          child: Image.asset(
                            "no_image.png",
                            fit: BoxFit.fill,
                            height: 170,
                            width: 170,
                          )),
                    ),
                    Positioned(
                        right: 170,
                        bottom: -10,
                        child: IconButton(
                          icon: const Icon(
                            Icons.camera_alt_rounded,
                            size: 26,
                            color: Color.fromARGB(207, 0, 123, 255),
                          ),
                          onPressed: () {
                            _dialogBuilder(context);
                          },
                        ))
                  ]),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Name',
                style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 255, 255, 255)),
                controller: _nameController ?? TextEditingController(),
                decoration: InputDecoration(
                  errorText: _nameValidate ? null : 'Enter Valid Name',
                  border: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blue, width: 1.0)),
                ),
                onSubmitted: (value) {
                  setState(() {
                    if (value.isEmpty) {
                      _nameValidate = false;
                    } else {
                      _nameValidate = true;
                    }
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Email',
                style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 255, 255, 255)),
                controller: _emailController ?? TextEditingController(),
                decoration: InputDecoration(
                  errorText: _emailValidate ? null : 'Enter Valid Email',
                  border: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blue, width: 1.0)),
                ),
                onSubmitted: (value) {
                  setState(() {
                    if (value.isEmpty ||
                        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                      _emailValidate = false;
                    } else {
                      _emailValidate = true;
                    }
                  });
                },
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: AppButton(
                  onPressed: () {
                    Modular.to.pop();
                  },
                  text: "Save changes",
                
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
