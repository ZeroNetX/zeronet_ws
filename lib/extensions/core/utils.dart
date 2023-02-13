import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:zeronet_ws/models/models.dart';

List<UserID> extractCertSelectDomains(PromptResult promptResult) {
  final params = (promptResult.value as Notification).params;
  final htmlStr = params!.last as String;
  final domains = parseFragment(htmlStr).nodes;
  domains.retainWhere(
    (Node node) {
      if (node is Element &&
          node.localName == 'a' &&
          node.className.contains('cert')) {
        return true;
      }
      return false;
    },
  );
  final mapped = domains.map((element) {
    final title = element.attributes['title']!;
    var username = (element as Element)
        .innerHtml
        .replaceAll('<b>', '')
        .replaceAll('</b>', '');
    var isActive = false;
    if (username.contains(' <small>')) {
      username = username.split(' ').first;
      isActive = true;
    }
    return UserID(
      title,
      username,
      isActive,
    );
  }).toList();
  return mapped;
}

class UserID {
  final String domain;
  final String username;
  final bool active;

  const UserID(
    this.domain,
    this.username,
    this.active,
  );
}
