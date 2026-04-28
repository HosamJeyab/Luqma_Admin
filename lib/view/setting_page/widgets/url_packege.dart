import 'package:url_launcher/url_launcher.dart';

class UrlPackage {
  //open email
  Future<void> openEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: "hosamkhjeyab@gmail.com",
      query: 'subject=Support Request&body=مرحبا أريد المساعدة',
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      print('Could not launch $emailUri');
    }
  }

  //open whatsapp
  Future<void> openWhatsApp() async {
    final phone = '+962780611037';
    final message = Uri.encodeComponent("مرحبا أريد المساعدة");
    final Uri whatsappUri = Uri.parse("https://wa.me/$phone?text=$message");

    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    } else {
      print('Could not open WhatsApp');
    }
  }
}
