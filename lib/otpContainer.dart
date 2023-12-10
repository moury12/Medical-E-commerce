import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medi_source_apitest/constant/colorConstant.dart';



class OtpContainer extends StatefulWidget {
  const OtpContainer({super.key, required this.controller, required this.focusNode});

  final TextEditingController controller;
  final FocusNode focusNode;
  @override
  State<OtpContainer> createState() => _OtpContainerState();
}

class _OtpContainerState extends State<OtpContainer> {
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: .7,
      child: Container(
        height: 48,
        width: 48,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(width: widget.controller.text.isNotEmpty ? 0.5 : 0.2, color: AppColors.kPrimaryColor)),
        child: TextField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.kPrimaryColor,
            fontSize: 20,
          ),
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
              setState(() {});
            }
            if (value.isEmpty) {
              FocusScope.of(context).previousFocus();
              setState(() {});
            }
          },
          cursorColor: AppColors.kPrimaryColor,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: AppColors.kPrimaryColor2P,
              contentPadding: EdgeInsets.zero,
              isDense: false),
        ),
      ),
    );
  }
}
