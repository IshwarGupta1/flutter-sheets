class FeedbackForm {

  String _name;
  String _email;
  String _marks;


  FeedbackForm(this._name, this._email,this._marks);

  // Method to make GET parameters.
  String toParams() =>
      "?name=$_name&email=$_email&marks=$_marks";


}