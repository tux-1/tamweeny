import 'package:flutter/material.dart';
import '../../generated/l10n.dart';
import '../../widgets/custom_scaffold.dart';
import 'tamween-signUp_screen.dart';

class TamweenInfo extends StatelessWidget {
  static const routeName = '/tamween-info';

  const TamweenInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBar(
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Text(
                    S.of(context).foodCardConditions,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 20),
                  Text(S.of(context).condition1),
                  Text(S.of(context).condition2),
                  Text(S.of(context).condition3),
                  const InfoDivider(),
                  Text(
                    S.of(context).eligibleCategories,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    S.of(context).categoriesList,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  Text(S.of(context).category1),
                  Text(S.of(context).category2),
                  Text(S.of(context).category3),
                  Text(S.of(context).category4),
                  Text(S.of(context).category5),
                  Text(S.of(context).category6),
                  Text(S.of(context).category7),
                  Text(S.of(context).category8),
                  Text(S.of(context).category9),
                  Text(S.of(context).category10),
                  const InfoDivider(),
                  Text(
                    S.of(context).proceduresForNewCard,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  Text(S.of(context).procedure1),
                  Text(S.of(context).procedure2),
                  Text(S.of(context).procedure3),
                  const InfoDivider(),
                  Text(
                    S.of(context).requiredDocuments,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  Text(S.of(context).document1),
                  Text(S.of(context).document2),
                  Text(S.of(context).document3),
                  Text(S.of(context).document4),
                  Text(S.of(context).document5),
                  const InfoDivider(),
                  Text(
                    S.of(context).replacementCardProcess,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  Text(S.of(context).replacementDocument1),
                  Text(S.of(context).replacementDocument2),
                  Text(S.of(context).replacementDocument3),
                  Text(S.of(context).replacementDocument4),
                  const SizedBox(height: 15),
                  Center(
                      child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(TamweenSignUpScreen.routeName);
                    },
                    child: Text(
                      S.of(context).apply_for_tamween_card,
                      textAlign: TextAlign.center,
                    ),
                  )),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoDivider extends StatelessWidget {
  const InfoDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: Colors.white,
      height: 20,
      thickness: 1,
    );
  }
}
