import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{
  late AnimationController controller;

  @override
  void initState(){
    super.initState();

    controller = AnimationController(
      vsync: this);
    controller.addStatusListener((status) async{
      if (status == AnimationStatus.completed){
          Navigator.pop(context);
          controller.reset();
      }
    });
  }
  @override
  void dispose(){
    super.dispose();
    controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text('Lottie Animations',style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Lottie.network('your url',
            animate: true),
          ),
          ElevatedButton(
              onPressed: (){
                  showDoneDialog();
              },
              child: Text('Open Next Screen'))
        ],
      ),
    );
  }
  void showDoneDialog() =>showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.network('your url',
          repeat: false,
          controller: controller,
          onLoaded: (composition){
            controller.duration = composition.duration;
            controller.forward();
          }),
          Text('Enjoy your Today', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
          const SizedBox(height: 16)
        ],
      ),
    )
  );
}
