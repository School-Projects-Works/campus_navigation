import 'package:campus_navigation/core/custom_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

launchURL(String url,) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
  } else {
  CustomDialog.showToast(message: 'Error launching the url');
  }
}
