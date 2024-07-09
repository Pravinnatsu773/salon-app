class AddressModel {
  String id;
  String title;
  String address;
  bool isSelected;

  AddressModel(
      {required this.id,
      required this.title,
      required this.address,
      this.isSelected = false});
}
