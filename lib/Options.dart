import 'package:flutter/material.dart';

class Options extends StatefulWidget {
  @override
  _OptionsState createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: 
      Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 100),
        child: Column(
          children: [
           Container(
             color: Colors.green,
             child: Column(
               children: [
                 Text('nic tu nie działa xdddddDD, tutaj robie opcje'),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.end,
                   children: [
                     Expanded(
                         child: RadioListTile(
                             value: null,
                             groupValue: null,
                             onChanged: null,
                         title: Text('one card'),)
                     ),
                     Expanded(
                         child: RadioListTile
                           (value: null,
                             groupValue: null,
                             onChanged: null,
                         title: Text('all matching'),)
                     ),
                   ],
                 ),
                 CheckboxListTile(
                     value: true,
                     onChanged: (T){},
                 title: Text('opt in 1'),
                 ),
                 CheckboxListTile(
                   value: true,
                   onChanged: (T){},
                   title: Text('opt in 2'),
                 ),
                 CheckboxListTile(
                   value: true,
                   onChanged: (T){},
                   title: Text('opt in 3'),
                 ),

               ],
             ),
           )
          ],
        )
      ),
      );
  }
}