import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:utkarsh/screens/book%20a%20pickup/success.dart';

class BookPickupForm extends StatefulWidget {
  const BookPickupForm({Key? key}) : super(key: key);

  @override
  State<BookPickupForm> createState() => _BookPickupFormState();
}

class _BookPickupFormState extends State<BookPickupForm> {
  final TextEditingController _dateinputController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _mobilenoController = TextEditingController();
  final TextEditingController _timeinputController = TextEditingController();

  late String _name;
  late String _quantity;
  late String _location;
  late String _number;

  late String _date;
  late String _time;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    _timeinputController.text = "";
    super.initState();

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(241, 86, 34,1),
        title : const Text('User Information',style: TextStyle( overflow: TextOverflow.clip),),
      ),
      body: Form(
        key : _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top : 30.0 , left:15, right:15 , bottom: 15),
            child: Column(
              children: [
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 1.12,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextFormField(
                    controller: _nameController,
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      hintText: "Full Name",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,

                      ),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _name = value!;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                // Container(
                //
                //   height: 50,
                //   width: MediaQuery.of(context).size.width / 1.12,
                //   decoration: BoxDecoration(
                //     color: Colors.grey[200],
                //     borderRadius: BorderRadius.circular(15),
                //   ),
                //   child: TextFormField(
                //     cursorColor: Colors.black,
                //
                //     keyboardType: TextInputType.name,
                //     decoration: const InputDecoration(
                //       border: InputBorder.none,
                //       contentPadding:
                //       EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                //       hintText: 'Requirement/Food description ',
                //       hintStyle: TextStyle(
                //         color: Colors.grey,
                //         fontSize: 16,
                //       ),
                //       prefixIcon: Icon(
                //         Icons.food_bank,
                //         color: Colors.grey,
                //       ),
                //     ),
                //   ),
                // ),
                // const SizedBox(height: 20),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 1.12,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextFormField(
                    controller: _mobilenoController,
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      hintText: 'Contact Number',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      prefixIcon: Icon(
                        Icons.mobile_friendly,
                        color: Colors.grey,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter NGO's Contact Number";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _location = value!;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 1.12,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextFormField(
                    controller: _locationController,
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      hintText: 'Location',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      prefixIcon: Icon(
                        Icons.add_location,
                        color: Colors.grey,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your full Address";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _location = value!;
                    },
                  ),
                ),
                const SizedBox(height: 20),

                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 1.12,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextFormField(
                    cursorColor: Colors.black,
                    controller: _dateinputController,
                    keyboardType: TextInputType.none,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      hintText: 'Pickup Date',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      prefixIcon: Icon(
                        Icons.calendar_today,
                        color: Colors.grey,
                      ),
                    ),
                    onTap: ()async{

                      DateTime? pickedDate = await showDatePicker(
                          context: context, initialDate: DateTime.now(),
                          firstDate: DateTime.now(), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101)
                      );
                      if(pickedDate != null ) {
                        String formattedDate = DateFormat('yyyy-MM-dd').format(
                            pickedDate); //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement

                        setState(() {
                          _dateinputController.text =
                              formattedDate; //set output date to TextField value.
                        });
                      }
                    },
                    onSaved: (value) {
                      _date = value! ;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 1.12,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextFormField(
                    controller: _timeinputController,
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      hintText: 'Pickup Time',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      prefixIcon: Icon(
                        Icons.timer,
                        color: Colors.grey,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your full Address";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _time = value!;
                    },
                  ),
                ),
                // Container(
                //   height: 50,
                //   width: MediaQuery.of(context).size.width / 1.12,
                //   decoration: BoxDecoration(
                //     color: Colors.grey[200],
                //     borderRadius: BorderRadius.circular(15),
                //   ),
                //   child: TextFormField(
                //     cursorColor: Colors.black,
                //     controller: _timeinputController,
                //     // keyboardType: TextInputType.none,
                //     style: TextStyle(
                //       color: Colors.black, // Set text color to black
                //       fontSize: 16,
                //     ),
                //     decoration: const InputDecoration(
                //       border: InputBorder.none,
                //       contentPadding:
                //       EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                //       hintText: 'Enter Pickup Time',
                //       hintStyle: TextStyle(
                //         color: Colors.grey,
                //         fontSize: 16,
                //       ),
                //       prefixIcon: Icon(
                //         Icons.timer,
                //         color: Colors.grey,
                //       ),
                //     ),
                //     // readOnly: true,  //set it true, so that user will not able to edit text
                //
                //     onTap: ()async{
                //       TimeOfDay? pickedTime =  await showTimePicker(
                //         initialTime: TimeOfDay.now(),
                //         context: context,
                //       );
                //
                //       if(pickedTime != null ){
                //         print(pickedTime.format(context));   //output 10:51 PM
                //         DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                //         //output 1970-01-01 22:53:00.000
                //         String formattedTime = DateFormat('hh:mm:ss').format(parsedTime);
                //         //DateFormat() is from intl package, you can format the time on any pattern you need.
                //
                //         setState(() {
                //           _timeinputController.text = formattedTime; //set the value of text field.
                //         });
                //       }else{
                //         print("Time is not selected");
                //       }
                //     },
                //     onSaved: (value) {
                //       _time = value! ;
                //     },
                //   ),
                // ),
                const SizedBox(height: 20),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 1.12,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextFormField(
                    controller: _quantityController,
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      hintText: 'Weights in KG',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      prefixIcon: Icon(
                        Icons.numbers,
                        color: Colors.grey,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter quantity";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _location = value!;
                    },
                  ),
                ),

                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        Map<String,dynamic> data = {
                          "name" : _nameController.text ,
                          "mobile" : _mobilenoController.text ,
                          "location" : _locationController.text,
                          "pickupDate" : _dateinputController.text,
                          "pickupTime" : _timeinputController.text,
                          "quantity" : _quantityController.text,
                        };
                        Navigator.push(context,MaterialPageRoute(
                          builder: (context) => const SuccessPage(),
                        ));
                        FirebaseFirestore.instance.collection('pickupInfo').add(data);

                      }
                    },

                    child: const Text('Submit'),
                  ),
                ),
                //Row
              ],
            ),
          ),

        ),
      ),
    );
  }
}
