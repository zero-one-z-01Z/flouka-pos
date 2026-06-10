class SettingsEntity {
  int id;
  String? whatsapp, phone, email;
  String termsLink;
  String aboutLink;
  String privacyLink;
  bool mustUpdate;
  int version;
  final num tax;
  String? packageName, appId;
  SettingsEntity({
    required this.id,
    required this.tax,
    required this.termsLink,
    required this.aboutLink,
    required this.email,
    required this.phone,
    required this.whatsapp,
    required this.version,
    required this.privacyLink,
    required this.mustUpdate,
    required this.packageName,
    required this.appId,
  });

}
