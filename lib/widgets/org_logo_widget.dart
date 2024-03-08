import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sgela_services/data/branding.dart';

import '../util/gaps.dart';
import '../util/styles.dart';

class OrgLogoWidget extends StatelessWidget {
  const OrgLogoWidget({
    super.key,
    this.branding,
    this.height,
    this.width,
  });

  final Branding? branding;
  final double? height, width;

  @override
  Widget build(BuildContext context) {
    if (branding == null) {
      return DefaultLogo(
        height: height,
      );
    }
    String? name = '';
    if (branding!.organizationName != null) {
      name = branding!.organizationName;
    }
    if (name!.isEmpty) {
      name = DefaultLogo.defaultName;
    }

    String? mLogoUrl = branding!.logoUrl!;
    return SizedBox(
      height: height == null ? 28 : height!,
      // width: width == null? 400: width!,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: CachedNetworkImage(
              imageUrl: mLogoUrl,
              height: height == null ? 36 : height!,
              // width: height == null ? 64*4 : (height! * 4),
            ),
          ),
          gapW16,
          Flexible(
            child: Text(
              name,
              style: myTextStyle(
                  context, Theme.of(context).primaryColor, 16, FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }

}

class DefaultLogo extends StatelessWidget {
  const DefaultLogo({super.key, this.height, this.sponsorName});

  final double? height;
  final String? sponsorName;
  static const defaultName = 'SgelaAI Inc.';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height == null ? 28 : height!,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Image.asset(
              'assets/sgela_logo.png',
              height: height == null ? 36 : height!,
            ),
          ),
          gapW16,
          Flexible(
            child: Text(
              sponsorName == null? defaultName: sponsorName!,
              style: myTextStyle(
                  context, Theme.of(context).primaryColor, 16, FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }
}
