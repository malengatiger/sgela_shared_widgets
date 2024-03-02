import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sgela_services/data/branding.dart';
import 'package:sgela_services/sgela_util/environment.dart';

import '../util/gaps.dart';
import '../util/styles.dart';


class OrgLogoWidget extends StatelessWidget {
  const OrgLogoWidget({super.key, this.branding, this.height, this.width,});

  final Branding? branding;
  final double? height, width;


  @override
  Widget build(BuildContext context) {
    var mLogoUrl = ChatbotEnvironment.sgelaLogoUrl;
    var splashUrl = ChatbotEnvironment.sgelaSplashUrl;
    if (logoUrl != null) {
      mLogoUrl = logoUrl!;
    }
    if (branding != null) {
      if (branding!.logoUrl != null) {
        mLogoUrl = branding!.logoUrl!;
      }
      if (branding!.splashUrl != null) {
        splashUrl = branding!.splashUrl!;
      }
    } else {
      branding = Branding(organizationId: 0,
          id: 0,
          date: 'date',
          logoUrl: mLogoUrl,
          splashUrl: splashUrl,
          tagLine: null,
          organizationName: defaultName,
          organizationUrl: mLogoUrl,
          splashTimeInSeconds:
          5,
          colorIndex: 0,
          boxFit: 0,
          activeFlag: true);
    }
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
              '${branding!.organizationName}',
              style: myTextStyle(context, Theme
                  .of(context)
                  .primaryColor,
                  16, FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }

  static const defaultName = 'SgelaAI Inc.';
}
