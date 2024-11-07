import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'constant.dart';

Widget customButton({
  required String title,
  required var function,
}) {
  return GestureDetector(
    onTap: function,
    child: Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: primaryColor),
      child: Center(
          child: Text(
        title,
        style: const TextStyle(fontSize: 18, color: Colors.white),
      )),
    ),
  );
}

class PasswordTextFormField extends StatefulWidget {
  const PasswordTextFormField({
    super.key,
    required this.title,
    this.hintText = '',
    this.onSaved,
  });
  final String title, hintText;
  final void Function(String?)? onSaved;

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 15,
        ),
        Text(
          widget.title,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
          onSaved: widget.onSaved,
          obscureText: obscureText,
          decoration: InputDecoration(
            suffixIcon: GestureDetector(
              onTap: () {
                obscureText = !obscureText;
                setState(() {});
              },
              child: obscureText
                  ? const Icon(Icons.remove_red_eye_outlined)
                  : const Icon(
                      Icons.remove_red_eye,
                    ),
            ),
            hintText: widget.hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ],
    );
  }
}

Widget customTextFormField(
    {String? title,
    FontWeight? fontWeight,
    double? fontSize,
    String? hintText,
    bool password = false,
    bool readOnly = false,
    void Function(String?)? onSaved,
    Color? color,
    bool hasBorder = true,
    int? maxLines = 1,
    List<BoxShadow>? boxShadow, // Parameter to control the border visibility
    TextEditingController? controller,
    void Function(String)? onChanged,
    void Function()? onTap}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(
        height: 15,
      ),
      Text(
        '${title ?? 'Age'}',
        style: TextStyle(
          fontSize: fontSize ?? 16,
          fontWeight: fontWeight,
        ),
      ),
      const SizedBox(
        height: 8,
      ),
      Container(
        decoration: BoxDecoration(
          color: color, // Background color
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: boxShadow,
        ),
        child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
          maxLines: maxLines,
          controller: controller,
          readOnly: readOnly,
          onSaved: onSaved,
          onChanged: onChanged,
          onTap: onTap,
          obscureText: password,
          decoration: InputDecoration(
            suffixIcon: password
                ? const Icon(Icons.remove_red_eye_outlined)
                : const SizedBox.shrink(),
            hintText: hintText,
            border: hasBorder
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  )
                : InputBorder.none,
            enabledBorder: hasBorder
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  )
                : InputBorder.none,
            focusedBorder: hasBorder
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: primaryColor),
                  )
                : InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12.0, // Adjust vertical padding as needed
              horizontal: 16.0, // Adjust horizontal padding as needed
            ), // Padding inside the TextFormField
          ),
        ),
      ),
    ],
  );
}

class CustomPasswordProfileTextFormField extends StatefulWidget {
  const CustomPasswordProfileTextFormField(
      {super.key,
      this.hintText,
      this.width,
      this.onSaved,
      this.color,
      this.hasBorder = false,
      this.boxShadow,
      this.onChanged});
  final String? hintText;
  final double? width;
  final bool obscureText = false;
  final void Function(String?)? onSaved;
  final Color? color;
  final bool hasBorder;
  final int? maxLines = 1;
  final List<BoxShadow>? boxShadow;
  final void Function(String)? onChanged;
  @override
  State<CustomPasswordProfileTextFormField> createState() =>
      CustomPasswordProfileTextFormFieldState();
}

class CustomPasswordProfileTextFormFieldState
    extends State<CustomPasswordProfileTextFormField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: widget.width,
          decoration: BoxDecoration(
            color: widget.color ?? const Color(0xffFDFDFD), // Background color
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: widget.boxShadow,
          ),
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
            maxLines: widget.maxLines,
            onSaved: widget.onSaved,
            onChanged: widget.onChanged,
            obscureText: obscureText,
            decoration: InputDecoration(
              suffixIcon: GestureDetector(
                onTap: () {
                  obscureText = !obscureText;
                  setState(() {});
                },
                child: obscureText
                    ? const Icon(Icons.remove_red_eye_outlined)
                    : const Icon(
                        Icons.remove_red_eye,
                      ),
              ),
              hintText: widget.hintText,
              border: widget.hasBorder
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: Colors.grey),
                    )
                  : InputBorder.none,
              enabledBorder: widget.hasBorder
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: Colors.grey),
                    )
                  : InputBorder.none,
              focusedBorder: widget.hasBorder
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: primaryColor),
                    )
                  : InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 12.0, // Adjust vertical padding as needed
                horizontal: 16.0, // Adjust horizontal padding as needed
              ), // Padding inside the TextFormField
            ),
          ),
        ),
      ],
    );
  }
}

Widget customProfileTextFormField({
  String? hintText,
  double? width,
  bool obscureText = false,
  void Function(String?)? onSaved,
  Color? color,
  bool hasBorder = true,
  int? maxLines = 1,
  List<BoxShadow>? boxShadow,
  void Function(String)? onChanged,
  TextInputType? keyboardType,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: width,
        decoration: BoxDecoration(
          color: color ?? const Color(0xffFDFDFD), // Background color
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: boxShadow,
        ),
        child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
          maxLines: maxLines,
          onSaved: onSaved,
          onChanged: onChanged,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            border: hasBorder
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  )
                : InputBorder.none,
            enabledBorder: hasBorder
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  )
                : InputBorder.none,
            focusedBorder: hasBorder
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: primaryColor),
                  )
                : InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12.0, // Adjust vertical padding as needed
              horizontal: 16.0, // Adjust horizontal padding as needed
            ), // Padding inside the TextFormField
          ),
        ),
      ),
    ],
  );
}

Widget customTextButton({
  required String title,
  required var function,
}) {
  return TextButton(
      onPressed: function,
      child: Text(
        title,
        style: TextStyle(color: primaryColor, fontSize: 12),
      ));
}

void showToast({required String message, required Color color}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 20);

Widget headerOfScreen({required String title, required var function}) {
  return Row(
    children: [
      GestureDetector(
        onTap: function,
        child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: primaryColor, width: 2)),
            child: Center(
                child: Icon(
              Icons.arrow_back_ios_new,
              size: 10,
              color: primaryColor,
            ))),
      ),
      const SizedBox(
        width: 15,
      ),
      Text(
        title,
        style: const TextStyle(fontSize: 20, fontFamily: 'PoppinsBold'),
      ),
    ],
  );
}

class CustomGenderDropDown extends StatefulWidget {
  const CustomGenderDropDown(
      {super.key,
      required this.width,
      required this.height,
      required this.onGenderSelected,
      this.text,
      this.title});
  final double width, height;
  final Function(String) onGenderSelected;
  final String? text, title;

  @override
  State<CustomGenderDropDown> createState() => _CustomGenderDropDownState();
}

class _CustomGenderDropDownState extends State<CustomGenderDropDown> {
  List<String> gender = ['Male', 'Female'];
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 15,
        ),
        Text(
          '${widget.title}',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          width: widget.width,
          height: widget.height,
          decoration: ShapeDecoration(
            color: const Color(0xFFE1F5FF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 8,
              ),
              const SizedBox(
                width: 8,
              ),
              DropdownButton(
                borderRadius: BorderRadius.circular(16),
                menuMaxHeight: 250,
                value: selectedGender,
                dropdownColor: const Color(0xFFE1F5FF),
                hint: Text(
                  widget.text ?? gender[0],
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    color: Colors.black,
                  ),
                ),
                icon: Padding(
                  padding: const EdgeInsets.only(left: 55),
                  child: Image.asset(
                    'assets/images/arrow.png',
                  ),
                ),
                items: gender.map(
                  (String gender) {
                    return DropdownMenuItem<String>(
                      value: gender,
                      child: Text(gender),
                    );
                  },
                ).toList(),
                onChanged: (String? gender) {
                  setState(
                    () {
                      selectedGender = gender!;
                      widget.onGenderSelected(selectedGender!);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomTypeDropDown extends StatefulWidget {
  const CustomTypeDropDown(
      {super.key,
      required this.width,
      required this.height,
      required this.onTypeSelected,
      this.text,
      this.title});
  final double width, height;
  final Function(String) onTypeSelected;
  final String? text, title;

  @override
  State<CustomTypeDropDown> createState() => _CustomTypeDropDownState();
}

class _CustomTypeDropDownState extends State<CustomTypeDropDown> {
  List<String> type = [
    'Dog',
    'Cat',
    'Fish',
    'Bird',
    'Turtle',
  ];
  String? selectedType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 15,
        ),
        Text(
          '${widget.title}',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          width: widget.width,
          height: widget.height,
          decoration: ShapeDecoration(
            color: const Color(0xFFE1FDF0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 8,
              ),
              const SizedBox(
                width: 8,
              ),
              DropdownButton(
                borderRadius: BorderRadius.circular(16),
                menuMaxHeight: 250,
                value: selectedType,
                dropdownColor: const Color(0xFFE1FDF0),
                hint: Text(
                  widget.text ?? type[0],
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    color: Colors.black,
                  ),
                ),
                icon: Padding(
                  padding: const EdgeInsets.only(left: 70),
                  child: Image.asset(
                    'assets/images/arrow.png',
                  ),
                ),
                items: type.map(
                  (String type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  },
                ).toList(),
                onChanged: (String? type) {
                  setState(
                    () {
                      selectedType = type!;
                      widget.onTypeSelected(selectedType!);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
