import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pet_app/components/widget.dart';
import '../../components/constant.dart';

class CustomSignUpDate extends StatefulWidget {
  const CustomSignUpDate({
    Key? key,
    this.onChanged,
    this.text,
  }) : super(key: key);

  // Change the onChanged callback to return a String
  final void Function(String)? onChanged;
  final String? text;
  @override
  State<CustomSignUpDate> createState() => _CustomSignUpDateState();
}

class _CustomSignUpDateState extends State<CustomSignUpDate> {
  TextEditingController dateController = TextEditingController();
  DateTime? selectedDateTime;

  @override
  void initState() {
    dateController.text = "";
    super.initState();
  }

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return customTextFormField(
      onChanged: (data) {
        log('onChanged: $data');
      },
      controller: dateController,
      readOnly: true,
      hintText: widget.text ?? 'Age',
      onTap: () {
        customDatePicker();
      },
    );
  }

  Future<void> customDatePicker() async {
    // Show date picker first
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2080),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: primaryColor,
              onPrimary: secondColor,
              onSurface: primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );

    // If date is picked, show time picker
    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: primaryColor,
                onPrimary: secondColor,
                onSurface: primaryColor,
              ),
            ),
            child: child!,
          );
        },
      );

      // If both date and time are picked, combine them
      if (pickedTime != null) {
        selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        // Format the DateTime as a string
        String formattedDateTime =
            DateFormat('yyyy-MM-dd HH:mm:ss').format(selectedDateTime!);

        // Update the text field with the formatted string
        setState(() {
          dateController.text = formattedDateTime;
        });

        // Notify parent widget with the string version of the DateTime
        if (widget.onChanged != null) {
          widget.onChanged!(formattedDateTime);
        }
      }
    }
  }
}
