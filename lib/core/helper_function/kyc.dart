import '../../features/auth/domain/entities/user_entity.dart';

bool isKycMedia(String? url) {
  if (url == null || url.trim().isEmpty) return false;
  final u = url.toLowerCase();
  return !u.contains('place_holder') &&
      !u.contains('placeholder') &&
      !u.endsWith('/default.png');
}

bool isCompanyAccount(UserEntity? user) {
  return (user?.accountType ?? '').toLowerCase() == 'company';
}

bool isKycDocsComplete(UserEntity? user) {
  if (user == null) return false;
  final cin = (user.nationalId ?? '').trim().isNotEmpty;
  final photos = isKycMedia(user.frontIdCard) && isKycMedia(user.backIdCard);
  if (!cin || !photos) return false;
  if (isCompanyAccount(user)) return isKycMedia(user.businessLicense);
  return true;
}
