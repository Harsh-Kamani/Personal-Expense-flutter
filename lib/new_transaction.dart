
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './transaction.dart';

class NewTransaction extends StatefulWidget {
  final Function addtx;

  NewTransaction(this.addtx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? selectDate;

  void submitData() {
    if(_amountController.text.isEmpty){
      return;
    }
    final enterTitle = _titleController.text;
    final enteramount = double.parse(_amountController.text);


    if (enterTitle.isEmpty || enteramount <= 0 || selectDate == null  ) {
      return;
    }

    widget.addtx(_titleController.text, double.parse(_amountController.text),selectDate);
    Navigator.of(context).pop();
  }

  void presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((pickedData) {
      if (pickedData == null) {
        return;
      }
      setState(() {
       selectDate = pickedData;
      });
    });
    print('...');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(top:10,left: 10,right: 10,bottom: MediaQuery.of(context).viewInsets.bottom+10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: "Title"),
                controller: _titleController,
                onSubmitted: (_) => submitData,
              ),
              TextField(
                controller: _amountController,
                decoration: InputDecoration(labelText: "Amount"),
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData,
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(selectDate == null?
                        'No date choose':
                           DateFormat('dd-MM-yyyy').format(selectDate!),
                      ),
                    ),
                    RaisedButton(
                      onPressed: presentDatePicker,
                      child: Text('Choose date'),
                    )
                  ],
                ),
              ),

              RaisedButton(
                child: Text("Add Transaction"),
                textColor: Colors.black,
                onPressed: submitData,
                color: Colors.lime,
              )
            ],
          ),
        ),
      ),
    );
  }
}
