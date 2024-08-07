import 'package:flutter/material.dart';

import 'P3TANKMASTER/P3TANKMASTERmain.dart';

int _SelectPage = 0;

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Page3Body();
  }
}

class Page3Body extends StatefulWidget {
  const Page3Body({Key? key}) : super(key: key);

  @override
  State<Page3Body> createState() => _Page3BodyState();
}

class _Page3BodyState extends State<Page3Body> {
  @override
  Widget build(BuildContext context) {
    return P3TANKMASTERMAIN();
  }
}
