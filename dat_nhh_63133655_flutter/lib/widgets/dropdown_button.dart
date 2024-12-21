import 'package:dat_nhh_63133655_flutter/widgets/wrapper_data.dart';
import 'package:flutter/material.dart';

class MyDropdownButton extends StatefulWidget {
  List<String> labels;
  StringWrapper value;
  Widget Function(String label)? itemBuilder; //Tạo icon
  MyDropdownButton({required this.labels, required this.value, this.itemBuilder ,super.key});

  @override
  State<MyDropdownButton> createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<MyDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        isExpanded: true,
        value: widget.value.value,
        items: widget.labels.map(
                (label) => DropdownMenuItem(
                    value: label,
                    child: widget.itemBuilder!=null?
                    widget.itemBuilder!(label):
                        Text(label)
                )
        ).toList(),
        onChanged: (value){
          setState(() {
            widget.value.value = value ;
          });
        },
    );
  }
}
