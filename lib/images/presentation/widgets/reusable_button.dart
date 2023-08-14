
import 'package:flutter/material.dart';
class ReusableButton extends StatelessWidget {

  final VoidCallback? onPressed;
  final Widget child;
  const ReusableButton({super.key,required this.onPressed,required this.child});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(left: 15.0,right: 15.0,top: 5.0,bottom: 10),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(


              backgroundColor: Colors.greenAccent,
              shape: const RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.all(Radius.circular(10))),
            ),
            child:   child),
      ),
    );
  }
}
