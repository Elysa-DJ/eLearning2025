
import 'package:flutter/material.dart';

import 'loading_state.dart';

class GradientButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;
  const GradientButton({super.key,required this.onPressed,required this.child});

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton>{
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: const [Color(0xFF03A9F4), Color(0xff281537)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextButton(
        onPressed: widget.onPressed,
        style: TextButton.styleFrom(
         padding: EdgeInsets.symmetric(horizontal: 20,vertical:10), 
        ),
        child: widget.child,
        ),
    );
  }
}

class GradientAuthButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isSubmitting;
  const GradientAuthButton({super.key, required this.onPressed, required this.text,this.isSubmitting=false});

  @override
  State<GradientAuthButton> createState() => _GradientAuthButtonState();

}

class _GradientAuthButtonState extends State<GradientAuthButton>{

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFF03A9F4), Color(0xff281537)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextButton(
        onPressed: widget.onPressed,
        style: TextButton.styleFrom(
        minimumSize: Size(double.infinity,35),
         padding: EdgeInsets.symmetric(vertical:15), 
        ),
        child:widget.isSubmitting==true?loadingStateOne():Text(widget.text,style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),),
        ),
    );
  }
}