import 'package:dat_nhh_63133655_flutter/widgets/wrapper_data.dart';
import 'package:flutter/material.dart';

class MyGroupRadio extends StatefulWidget {
  List<String> labels;
  StringWrapper groupValue;
  bool? isHorizontal;

  MyGroupRadio({required this.labels, required this.groupValue,
    this.isHorizontal = true, super.key});
  @override
  State<MyGroupRadio> createState() => _MyGroupRadioState();
}

class _MyGroupRadioState extends State<MyGroupRadio> {
  @override
  Widget build(BuildContext context) {
    if(widget.isHorizontal == true)
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _buildListRadio(),
      );
    else
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildListRadio(),
      );
  }
  _buildListRadio(){
    return widget.labels.map(
        (label) => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Radio(
                value: label,
                groupValue: widget.groupValue.value,
                onChanged: (value) {
                  setState(() {
                    widget.groupValue.value = value;
                  });
                }
            ),
            Text(label),
          ],
        )
    ).toList();
  }
}

