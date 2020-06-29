import 'package:flutter/material.dart';
import 'package:googledocs/controller.dart';
import 'package:googledocs/form.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // TextField Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController marksController = TextEditingController();

  void _submitForm() {

    if(_formKey.currentState.validate()){
      FeedbackForm feedbackForm = FeedbackForm(
          nameController.text,
          emailController.text,
          marksController.text,
      );

      FormController formController = FormController((String response){
        print("Response: $response");
        if(response == FormController.STATUS_SUCCESS){
          //
          _showSnackbar("Submitted");
        } else {
          _showSnackbar("Something Wrong Happened!");
        }
      });

      _showSnackbar("Submitting....");

      // Submit 'feedbackForm' and save it in Google Sheet

      formController.submitForm(feedbackForm);
    }


  }

  // Method to show snackbar with 'message'.
  _showSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fill the Details"),
        backgroundColor: Colors.tealAccent,
      ),
      key:  _scaffoldKey,
      body: Center(
    child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 50,horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: nameController,
                      validator: (value){
                        if(value.isEmpty){
                          return "Enter Valid Name";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: "Your Name"
                      ),
                    ),
                    TextFormField(
                      controller: emailController,
                      validator: (value){
                        if(value.isEmpty){
                          return "Enter Valid Email";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: "Your E-mail"
                      ),
                    ),

                    TextFormField(
                      controller: marksController,
                      validator: (value){
                        if(value.isEmpty){
                          return "Enter Valid Marks";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: "Your Marks"
                      ),
                    ),
                    RaisedButton(

                      color: Colors.teal,
                      textColor: Colors.white,
                      onPressed: _submitForm,
                      child: Text('Submit'),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ),
    );
  }
}