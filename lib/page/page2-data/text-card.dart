import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';

class TextCard1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 1,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        crossAxisSpacing: 25,
        mainAxisSpacing: 25,
        childAspectRatio: 3.5,
      ),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => FileInfoCard1(),
    );
  }
}

class FileInfoCard1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'FA Feed : 0 Litter', // Customize the title text here
            style: GoogleFonts.ramabhadra(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            'AC Feed : 0 Litter', // Customize the title text here
            style: GoogleFonts.ramabhadra(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            'FA Error : 0 Litter', // Customize the title text here
            style: GoogleFonts.ramabhadra(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            'AC Error : 0 Litter', // Customize the title text here
            style: GoogleFonts.ramabhadra(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class TextCard2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 1,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        crossAxisSpacing: 25,
        mainAxisSpacing: 25,
        childAspectRatio: 3.5,
      ),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => FileInfoCard2(),
    );
  }
}

class FileInfoCard2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'FA Feed : 0 Litter', // Customize the title text here
            style: GoogleFonts.ramabhadra(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            'AC Feed : 0 Litter', // Customize the title text here
            style: GoogleFonts.ramabhadra(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            'FA Error : 0 Litter', // Customize the title text here
            style: GoogleFonts.ramabhadra(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            'AC Error : 0 Litter', // Customize the title text here
            style: GoogleFonts.ramabhadra(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class TextCard3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 1,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        crossAxisSpacing: 25,
        mainAxisSpacing: 25,
        childAspectRatio: 3.5,
      ),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => FileInfoCard3(),
    );
  }
}

class FileInfoCard3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'FA Feed : 0 Litter', // Customize the title text here
            style: GoogleFonts.ramabhadra(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            'AC Feed : 0 Litter', // Customize the title text here
            style: GoogleFonts.ramabhadra(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            'FA Error : 0 Litter', // Customize the title text here
            style: GoogleFonts.ramabhadra(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            'AC Error : 0 Litter', // Customize the title text here
            style: GoogleFonts.ramabhadra(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class TextCard4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 1,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        crossAxisSpacing: 25,
        mainAxisSpacing: 25,
        childAspectRatio: 3.5,
      ),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => FileInfoCard4(),
    );
  }
}

class FileInfoCard4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'FA Feed : 0 Litter', // Customize the title text here
            style: GoogleFonts.ramabhadra(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            'AC Feed : 0 Litter', // Customize the title text here
            style: GoogleFonts.ramabhadra(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            'FA Error : 0 Litter', // Customize the title text here
            style: GoogleFonts.ramabhadra(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            'AC Error : 0 Litter', // Customize the title text here
            style: GoogleFonts.ramabhadra(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class TextCard5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 1,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        crossAxisSpacing: 25,
        mainAxisSpacing: 25,
        childAspectRatio: 3.5,
      ),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => FileInfoCard5(),
    );
  }
}

class FileInfoCard5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'FA Feed : 0 Litter', // Customize the title text here
            style: GoogleFonts.ramabhadra(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            'AC Feed : 0 Litter', // Customize the title text here
            style: GoogleFonts.ramabhadra(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            'FA Error : 0 Litter', // Customize the title text here
            style: GoogleFonts.ramabhadra(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            'AC Error : 0 Litter', // Customize the title text here
            style: GoogleFonts.ramabhadra(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class TextCard6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 1,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        crossAxisSpacing: 25,
        mainAxisSpacing: 25,
        childAspectRatio: 3.5,
      ),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => FileInfoCard6(),
    );
  }
}

class FileInfoCard6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'FA Feed : 0 Litter', // Customize the title text here
            style: GoogleFonts.ramabhadra(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            'AC Feed : 0 Litter', // Customize the title text here
            style: GoogleFonts.ramabhadra(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            'FA Error : 0 Litter', // Customize the title text here
            style: GoogleFonts.ramabhadra(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            'AC Error : 0 Litter', // Customize the title text here
            style: GoogleFonts.ramabhadra(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
