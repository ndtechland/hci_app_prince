import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../models/VoucherData.dart';
import '../utils/datasource.dart';
import 'generatevoucher_screen.dart';

class VoucherRegisterPage extends StatefulWidget {
  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  _VoucherRegisterPageState createState() => _VoucherRegisterPageState();
}

class _VoucherRegisterPageState extends State<VoucherRegisterPage> {
  bool checkedValue = false;
  var _currentSelectedValue, _currentSelectedValue1, _currentSelectedValue2;
  bool _passwordVisible = false;
  bool _isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  TextEditingController _textNameController = TextEditingController();
  TextEditingController _textPhoneController = TextEditingController();
  TextEditingController _textEmailController = TextEditingController();
  TextEditingController _textPreLoc1Controller = TextEditingController();
  TextEditingController _textPreLoc2Controller = TextEditingController();
  TextEditingController _textIssuedByController = TextEditingController();
  TextEditingController dateCtl = TextEditingController();
  var _currencies = [
    "Jim corbett",
    "Manali",
    "Jaipur",
    "Agra",
    "Goa",
    "Thailand",

    // "Srilanka",
    // "Nepal",
  ];

  void loginUser(String name, String phone, String email, String preLoc1,
      String preLoc2, String issuedBy, String date) async {
    //String url = "https://fcclub.co.in/api/Vacationapi/AddVoucher";
    //Uri.parse('https://fcclub.co.in/api/passwordapi/ChangePassword'), // Convert URL to Uri

    http.Response response = await http.post(
        Uri.parse(
            'https://hci.ndinfotech.com/api/Vacationapi/AddVoucher'), // Convert URL to Uri

        body: {
          'Name': _textNameController.text.toString(),
          'emailid': _textEmailController.text.toString(),
          'Mobile': _textPhoneController.text.toString(),
          'IssuedBy': _textIssuedByController.text.toString(),
          'IssueDate': dateCtl.text.toString(),
          'ChoiceDate': _currentSelectedValue,
          'ChoiceDate1': _currentSelectedValue,
          'ChoiceDate2': _currentSelectedValue1,
          'ChoiceDate3': _currentSelectedValue2,
          'IsChecked': checkedValue.toString(),
        });
    print("response.body:${response.body}");
    //print("DFGFD: ${voucher.sequenceNo}");

    if (response.statusCode == 200) {
      Map responseData = json.decode(response.body);
      setState(() {
        _isLoading = false;
      });
      print("ResponseDate: ${responseData}");
      if (responseData['Status'] == 1) {
        final Voucher voucher = Voucher.fromJson(jsonDecode(response.body));
        print("DFGFDdd: ${voucher.sequenceNo}");
        // String name = voucher.name;
        // Fluttertoast.showToast(
        //     msg: name,
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.BOTTOM,
        //     timeInSecForIosWeb: 1);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => GenerateVoucherPage(voucher: voucher)));
      } else {
        Fluttertoast.showToast(
            msg: "Incorrect username or password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(
          msg: "Something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      body: SafeArea(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
          child: Container(
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.only(left: 0, right: 0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset('images/fci_images/cropped-Logo-HCi.png'),
                  SizedBox(
                    height: 0,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20, top: 10),
                      child: Text(
                        'Generate Gift Voucher',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: TextFormField(
                      controller: _textNameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Required';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        //border: OutlineInputBorder(),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 1, color: primaryColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(width: 1.5, color: primaryColor),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 14, horizontal: 16), // Adjust padding

                        labelText: 'Name',
                        // enabledBorder: OutlineInputBorder(
                        //     borderRadius: BorderRadius.all(Radius.circular(4)),
                        //     borderSide:
                        //         BorderSide(width: 1, color: primaryColor)),
                        // focusedBorder: OutlineInputBorder(
                        //     borderRadius: BorderRadius.all(Radius.circular(4)),
                        //     borderSide:
                        //         BorderSide(width: 1, color: primaryColor)),
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: TextFormField(
                      controller: _textPhoneController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Required';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      decoration: InputDecoration(
                        // border: OutlineInputBorder(
                        //     borderRadius: BorderRadius.circular(12)),
                        labelText: 'Phone/Mobile',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 1, color: primaryColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(width: 1.5, color: primaryColor),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 14, horizontal: 16), // Adjust padding
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: TextFormField(
                      controller: _textEmailController,
                      validator: (v) {
                        String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                        RegExp regExp = new RegExp(pattern);
                        if (v == "") {
                          return "Enter Your Email";
                        } else if (!regExp.hasMatch(v!)) {
                          return 'Invalid Email Id';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        // border: OutlineInputBorder(
                        //     borderRadius: BorderRadius.circular(12)),
                        // border: OutlineInputBorder(),
                        labelText: 'Email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 1, color: primaryColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(width: 1.5, color: primaryColor),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 14, horizontal: 16), // Adjust padding
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: FormField<String>(
                      builder: (FormFieldState<String> state) {
                        return InputDecorator(
                          decoration: InputDecoration(
                            // border: OutlineInputBorder(
                            //     borderRadius: BorderRadius.circular(12)),
                            //border: OutlineInputBorder(),
                            labelText: 'Preferred Location 1',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(width: 1, color: primaryColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(width: 1.5, color: primaryColor),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 14, horizontal: 16), // Adjust padding
                          ),
                          isEmpty: _currentSelectedValue == '',
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _currentSelectedValue,
                              isDense: true,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _currentSelectedValue = newValue;
                                  state.didChange(newValue);
                                });
                              },
                              items: _currencies.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: FormField<String>(
                      builder: (FormFieldState<String> state) {
                        return InputDecorator(
                          decoration: InputDecoration(
                            // border: OutlineInputBorder(
                            //     borderRadius: BorderRadius.circular(12)),
                            // border: OutlineInputBorder(),
                            labelText: 'Preferred Location 2',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(width: 1, color: primaryColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(width: 1.5, color: primaryColor),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 14, horizontal: 16), // Adjust padding
                          ),
                          isEmpty: _currentSelectedValue1 == '',
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _currentSelectedValue1,
                              isDense: true,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _currentSelectedValue1 = newValue;
                                  state.didChange(newValue);
                                });
                              },
                              items: _currencies.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: FormField<String>(
                      builder: (FormFieldState<String> state) {
                        return InputDecorator(
                          decoration: InputDecoration(
                            // border: OutlineInputBorder(
                            //     borderRadius: BorderRadius.circular(12)),
                            // border: OutlineInputBorder(),
                            labelText: 'Preferred Location 3',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(width: 1, color: primaryColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(width: 1.5, color: primaryColor),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 14, horizontal: 16), // Adjust padding

                            // enabledBorder: OutlineInputBorder(
                            //     borderRadius:
                            //         BorderRadius.all(Radius.circular(4)),
                            //     borderSide:
                            //         BorderSide(width: 1, color: primaryColor)),
                            // focusedBorder: OutlineInputBorder(
                            //     borderRadius:
                            //         BorderRadius.all(Radius.circular(4)),
                            //     borderSide:
                            //         BorderSide(width: 1, color: primaryColor)),
                          ),
                          isEmpty: _currentSelectedValue2 == '',
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _currentSelectedValue2,
                              isDense: true,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _currentSelectedValue2 = newValue;
                                  state.didChange(newValue);
                                });
                              },
                              items: _currencies.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: TextFormField(
                      controller: _textIssuedByController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        // border: OutlineInputBorder(
                        //     borderRadius: BorderRadius.circular(12)),
                        // border: OutlineInputBorder(),
                        labelText: 'Issued By',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 1, color: primaryColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(width: 1.5, color: primaryColor),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 14, horizontal: 16), // Adjust padding
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: TextFormField(
                      controller: dateCtl,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        //   border: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(12)),
                        // border: OutlineInputBorder(),
                        labelText: 'Date of issue',
                        suffixIcon: Icon(Icons.calendar_month),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 1, color: primaryColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(width: 1.5, color: primaryColor),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 14, horizontal: 16), // Adjust padding
                      ),
                      onTap: () async {
                        DateTime? date = DateTime(1900);
                        FocusScope.of(context).requestFocus(new FocusNode());

                        date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100));

                        dateCtl.text = date!.toIso8601String();
                      },
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: false,
                    child: Align(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: 50,
                        child: CheckboxListTile(
                          title: Text("Generate movie voucher"),
                          value: checkedValue,
                          onChanged: (newValue) {
                            setState(() {
                              checkedValue = newValue!;
                            });
                          },
                          controlAffinity: ListTileControlAffinity
                              .leading, //  <-- leading Checkbox
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          _isLoading = true;
                        });
                        loginUser(
                            _textNameController.text,
                            _textPhoneController.text,
                            _textEmailController.text,
                            _textPreLoc1Controller.text,
                            _textPreLoc2Controller.text,
                            _textIssuedByController.text,
                            dateCtl.text);
                      } else {
                        Fluttertoast.showToast(
                            msg: "Something  ",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1);
                      }
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        width: 100,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                child: Center(
                              child: Text(
                                '    Generate',
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                  width: 15,
                                  height: 15,
                                  margin: EdgeInsets.only(left: 10),
                                  child: _isLoading
                                      ? CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.white),
                                        )
                                      : Container()),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
