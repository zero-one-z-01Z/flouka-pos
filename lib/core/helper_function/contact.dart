import 'package:url_launcher/url_launcher.dart';

void launchLink(String link) async {
  await launchUrl(Uri.parse(link));
}

void openWhatsApp(String phone) {
  if (phone.startsWith('+')) {
    phone = phone.substring(1);
  }
  if (phone.startsWith('966')) {
    phone = phone.substring(3);
  }
  if (phone.startsWith('0')) {
    phone = phone.substring(1);
  }
  launchLink('https://wa.me/+966$phone');
}

void openTelegram(String phone) {
  launchLink('https://telegram.me/$phone');
}

void callPhone(String phone) {
  launchLink('tel:$phone');
}

void openEmail(String email) {
  launchLink('mailto:$email');
}
