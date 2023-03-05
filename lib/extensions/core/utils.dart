import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:zeronet_ws/models/cert.dart';
import 'package:zeronet_ws/models/models.dart';

List<UserID> extractCertSelectDomains(PromptResult promptResult) {
  final params = (promptResult.value as Notification).params;
  final htmlStr = params!.last as String;
  final domains = parseFragment(htmlStr).nodes;
  final registrars = <UserID>[];
  domains.retainWhere(
    (Node node) {
      if (node is Element &&
          (node.localName == 'a' && node.className.contains('cert') ||
              node.localName == 'div')) {
        if (node.localName == 'div') {
          final registers = parseFragment(node.innerHtml).nodes;
          registers.retainWhere(
            (node) =>
                node is Element &&
                node.localName == 'a' &&
                node.className == 'select',
          );
          for (var element in registers) {
            final keys = ['href', 'target', 'class'];
            final result = element.attributes.keys.skipWhile(
              (value) => keys.contains(value),
            );
            if (result.isEmpty) {
              final domain = element.attributes['href']!;
              final String domainString;
              if (!domain.startsWith('/')) {
                domainString = domain;
              } else {
                domainString = domain.substring(1);
              }
              final isEmpty = registrars
                  .where((element) => element.domain == domainString)
                  .isEmpty;
              if (isEmpty) {
                registrars.add(UserID(
                  domainString,
                  '',
                  false,
                  registered: false,
                ));
              }
            }
          }
          return false;
        }
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
  mapped.addAll(registrars);
  return mapped;
}

class UserID {
  final String domain;
  final String username;
  final bool active;
  final bool registered;

  const UserID(
    this.domain,
    this.username,
    this.active, {
    this.registered = true,
  });
}

extension PortOpenedExt on Message {
  ///Return: True (port opened) or False (port closed).
  PortOpened get portOpened {
    return PortOpened.fromJson(result);
  }
}

extension SiteListExt on Message {
  /// Return: SiteList
  List<SiteInfo> get siteList {
    final res = (result as List);
    final list = res.map((e) => SiteInfo.fromJson(e)).toList();
    return list;
  }
}

extension CertListExt on Message {
  /// Return: CertList
  List<Cert> get certList {
    final res = (result as List);
    final list = res.map((e) => Cert.fromJson(e)).toList();
    return list;
  }
}
