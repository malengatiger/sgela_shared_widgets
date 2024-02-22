import 'package:cached_network_image/cached_network_image.dart';
import 'package:sgela_services/data/branding.dart';
import 'package:sgela_services/data/organization.dart';
import 'package:sgela_services/repositories/basic_repository.dart';
import 'package:sgela_services/sgela_util/functions.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sgela_shared_widgets/util/gaps.dart';
import 'package:sgela_shared_widgets/util/styles.dart';
import 'package:sgela_shared_widgets/util/widget_prefs.dart';
import 'package:sgela_shared_widgets/util/dialogs.dart';

class SponsoredBy extends StatefulWidget {
  const SponsoredBy({
    super.key, this.height, this.logoHeight,
  });
  final double? height, logoHeight;

  @override
  State<SponsoredBy> createState() => _SponsoredByState();
}

class _SponsoredByState extends State<SponsoredBy> {
  static const String mm = '🍎🍎🍎 PoweredBy: ';

  Organization? sponsorOrganization;
  Branding? branding;
  bool busy = false;
  WidgetPrefs prefs = GetIt.instance<WidgetPrefs>();
  BasicRepository repository = GetIt.instance<BasicRepository>();
  @override
  void initState() {
    super.initState();
    _getOrganization();
  }

  List<Branding> brandings = [];
  Future<void> _getOrganization() async {
    setState(() {
      busy = true;
    });
    try {
      sponsorOrganization = prefs.getOrganization();
      brandings = prefs.getBrandings();
      brandings.sort((a,b) => b.date!.compareTo(a.date!));
      if (brandings.isNotEmpty) {
        branding = brandings.first;
      }
    } catch (e,s) {
      pp(e);
      pp(s);
      if (mounted) {
        showErrorDialog(context, 'Unable to get sponsorOrganization ');
      }
    }
    setState(() {
      busy = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height == null? 48 : widget.height!,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            gapW4,
             Text('Sponsored by', style: myTextStyleTiny(context),),
            gapW4,
            sponsorOrganization == null ? gapW4 : Text('${sponsorOrganization!.name}'),
            gapW8,
            branding == null
                ? gapW4
                : Card(
                    elevation: 8,
                    child: CachedNetworkImage(
                      height: widget.logoHeight == null? 28 : widget.logoHeight!,
                      imageUrl: branding!.logoUrl!,
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}