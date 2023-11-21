import 'package:abraj_al_buhaira_attendance_eng_ashraf/core/constants/colors.dart';
import 'package:flutter/material.dart';

//List<String> listOfLocation = ['Attend', 'Extra time',];

class CustomDropDownMenu extends StatefulWidget {
   CustomDropDownMenu({
    super.key,
     required this.label,
    required this.listChoices ,
  });

   final String label ;
   final List<String> listChoices;

  @override
  State<CustomDropDownMenu> createState() => _CustomDropDownMenuState();
}
class _CustomDropDownMenuState extends State<CustomDropDownMenu> {
  TextEditingController textEditingControllerMenu = TextEditingController();

  // String selectedLocation ='select';
  @override
  Widget build(BuildContext context) {

    return DropdownMenu(
      selectedTrailingIcon: IconButton(onPressed: (){},icon: Icon(Icons.ac_unit),),
      initialSelection: widget.listChoices.first,
      width:  MediaQuery.of(context).size.width*0.57,
      enableSearch: true,
      enableFilter: true,
      hintText: widget.label,
      controller: textEditingControllerMenu,
       inputDecorationTheme: InputDecorationTheme(
         constraints: BoxConstraints(
           maxHeight: 58,
         ),
         enabledBorder: OutlineInputBorder(
           borderRadius: BorderRadius.all(Radius.circular(8.0)),
           borderSide: BorderSide(color: ColorHelper.borderColor),

         ),

           /*border: OutlineInputBorder(
             borderRadius: BorderRadius.all(Radius.circular(8.0)),
             borderSide: BorderSide(color: Colors.red),
           ),*/


       ),
      onSelected: (String? value) {
        // This is called when the user selects an item.
        /*setState(() {
          selectedLocation = value!;
        });*/
      },
      dropdownMenuEntries: widget.listChoices.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}
