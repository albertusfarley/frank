import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frank/services/database.dart';
import 'package:frank/shared/loading.dart';
import 'package:provider/provider.dart';

class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  TextEditingController quantityController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String _currentSelectedValue = '_';
  String errorMsg = '';

  String name = '';
  String quantity = '';

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<QuerySnapshot>(context);

    if (data == null) return Loading();

    List listSeries = data.docs.map((doc) => doc.data()).toList();

    List<String> seriesNames = [];
    for (var s in listSeries) {
      seriesNames.add(s['code']);
    }

    seriesNames.sort((a, b) => a.compareTo(b));

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        brightness: Brightness.light,
        title: Text(
          'Add Item',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blueAccent),
        elevation: 0,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * .7,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    FormField<String>(
                      builder: (FormFieldState<String> state) {
                        return InputDecorator(
                          decoration: InputDecoration(
                              labelText: 'Type',
                              hintText: 'Type',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16))),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _currentSelectedValue,
                              isDense: true,
                              onChanged: (String newValue) {
                                setState(() {
                                  _currentSelectedValue = newValue;

                                  nameController
                                    ..text =
                                        newValue == '_' ? '' : newValue + ' ';

                                  if (quantityController.text == '') {
                                    quantityController..text = '0';
                                  }

                                  state.didChange(newValue);
                                });
                              },
                              items: seriesNames.map<DropdownMenuItem<String>>(
                                  (String value) {
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
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                          labelText: 'Name',
                          hintText: 'Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          )),
                      validator: (value) {
                        if (value.isEmpty)
                          setState(() {
                            errorMsg = 'Item name cannot be empty.';
                          });

                        return;
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty)
                          setState(() {
                            errorMsg = 'Item quantity cannot be empty.';
                          });

                        return;
                      },
                      controller: quantityController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Quantity',
                          hintText: 'Quantity',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          )),
                    ),
                    SizedBox(
                      height: 24.0,
                      width: 60.0,
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child:
                    Text(errorMsg, style: TextStyle(color: Colors.redAccent)),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .7,
                height: MediaQuery.of(context).size.width * .15,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      String name = nameController.text.toString();
                      var selectedSeries = listSeries
                          .where((s) => s['code'] == _currentSelectedValue)
                          .toList()[0];
                      String series = selectedSeries['_id'];
                      String type = selectedSeries['type'];
                      int quantity =
                          int.parse(quantityController.text.toString());

                      DatabaseService().addItem(name, type, series, quantity);

                      Navigator.pop(context);
                    }
                  },
                  color: Colors.blueAccent,
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
