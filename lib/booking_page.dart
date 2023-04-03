import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        "My Bookings",
        textAlign: TextAlign.center,
      ),
      alignment: Alignment.center,
    );
  }
}