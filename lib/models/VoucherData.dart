class Voucher {
  Voucher(
      {required this.id,
      required this.status,
        this.choiceDate,
      required this.choiceDate1,
      required this.choiceDate2,
      required this.choiceDate3,
      required this.emailId,
      required this.issueDate,
      required this.issuedBy,
      required this.message,
      required this.mobile,
      required this.name,
      required this.sequenceNo,
      required this.password,
      required this.isChecked});

  int id, status;
  String? choiceDate;
  String   choiceDate1, choiceDate2, choiceDate3;
  String emailId,
      issueDate,
      issuedBy,
      message,
      mobile,
      name,
      sequenceNo,
      password;
  bool isChecked;

  factory Voucher.fromJson(Map<String, dynamic> json) => Voucher(
        choiceDate: json["ChoiceDate"],
        choiceDate1: json["ChoiceDate1"],
        choiceDate2: json["ChoiceDate2"],
        choiceDate3: json["ChoiceDate3"],
        emailId: json["EmailId"],
        id: json["Id"],
        issueDate: json["IssueDate"],
        issuedBy: json["IssuedBy"],
        message: json["Message"],
        mobile: json["Mobile"],
        name: json["Name"],
        status: json["Status"],
        isChecked: json["IsChecked"],
        sequenceNo: json["SequenceNo"],
        password: json["Password"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "ChoiceDate": choiceDate,
        "ChoiceDate1": choiceDate1,
        "ChoiceDate2": choiceDate2,
        "ChoiceDate3": choiceDate3,
        "EmailId": emailId,
        "IssueDate": issueDate,
        "IssuedBy": issuedBy,
        "Message": message,
        "Mobile": mobile,
        "Name": name,
        "Status": status,
        "IsChecked": isChecked,
        "SequenceNo": sequenceNo,
        "Password": password
      };
}
