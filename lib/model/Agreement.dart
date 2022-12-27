class Agreement {
  final String account_no;
  final String client_date;
  final String client_location;
  final String client_name;
  final String client_signature;
  final String signature;
  final String date;
  final String description;
  final String img;
  final String institution_no;
  final String location;
  final String name;
  final String price;
  final String transit_no;
  final String user_Id;
  final String agreementId;
  final String partial_pay;

  Agreement(
      {required this.name,
      required this.description,
      required this.price,
      required this.signature,
      required this.location,
      required this.user_Id,
      required this.img,
      required this.date,
      required this.agreementId,
      required this.client_signature,
      required this.client_name,
      required this.client_location,
      required this.client_date,
      required this.account_no,
      required this.institution_no,
      required this.transit_no,
      required this.partial_pay});
}
