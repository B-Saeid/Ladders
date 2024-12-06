import 'package:flutter/material.dart';

import '../../../Shared/Components/Dialogue/dialogue.dart';
import '../../../Shared/Services/Routing/routes_base.dart';
import '../../../Shared/Services/l10n/assets/l10n_resources.dart';

abstract class Dialogues {
  /// TODO: Either get internet service and disable the speech if not available
  /// or show an error message if internet service is not available
  static Future<void> showAndroidGoogleMicRequired([BuildContext? context]) => showAdaptiveDialog(
        context: context ?? RoutesBase.activeContext!,
        builder: (context) => MyDialogue(
          title: L10nR.tNote(),
          content: L10nR.tGoogleMicRequiredMessage(),
          actionTitle: L10nR.tUnderstood(),
          actionFunction: Navigator.of(context).pop,
        ),
      );

  static Future<void> showSpeechNotAvailable([BuildContext? context]) => showAdaptiveDialog(
        context: context ?? RoutesBase.activeContext!,
        builder: (context) => MyDialogue(
          title: L10nR.tNotAvailable(),
          content: L10nR.tSpeechNotAvailable(),
          actionTitle: L10nR.tDiscard(),
          actionFunction: Navigator.of(context).pop,
        ),
      );

  static Future<void> showInternetRequiredForSpeech([BuildContext? context]) => showAdaptiveDialog(
        context: context ?? RoutesBase.activeContext!,
        builder: (context) => MyDialogue(
          title: L10nR.tInternetRequired(),
          content: L10nR.tInternetRequiredForSpeech(),
          actionTitle: L10nR.tDiscard(),
          actionFunction: Navigator.of(context).pop,
        ),
      );

  static Future<void> showSpokenContentNotAvailable([BuildContext? context]) => showAdaptiveDialog(
        context: context ?? RoutesBase.activeContext!,
        builder: (context) => MyDialogue(
          title: L10nR.tNote(),
          content: L10nR.tSpokenContentNotAvailable(),
          actionTitle: L10nR.tDiscard(),
          actionFunction: Navigator.of(context).pop,
        ),
      );

  static Future<void> showSpokenContentError([BuildContext? context]) => showAdaptiveDialog(
        context: context ?? RoutesBase.activeContext!,
        builder: (context) => MyDialogue(
          title: L10nR.tNote(),
          content: L10nR.tSpokenContentError(),
          actionTitle: L10nR.tDiscard(),
          actionFunction: Navigator.of(context).pop,
        ),
      );

  static Future<bool?> showConfirmStopLadder(BuildContext context) => showAdaptiveDialog<bool?>(
        context: context,
        builder: (context) => MyDialogue(
          title: L10nR.tConfirmStop(),
          content: L10nR.tConfirmStopMessage(),
          actionTitle: L10nR.tYes(),
          actionFunction: () => Navigator.of(context).pop(true),
          dismissTitle: L10nR.tNo(),
          dismissFunction: () => Navigator.of(context).pop(false),
          counterRecommended: true,
        ),
      );

  static Future<bool?> showLadderFinishSuccess([BuildContext? context]) => showAdaptiveDialog<bool?>(
        context: context ?? RoutesBase.activeContext!,
        builder: (context) => MyDialogue(
          title: L10nR.tGreatJob(),

          /// TODO : show total time spent and pie chart of work and rest time
          content: L10nR.tGreatJobMessage(),
          actionTitle: L10nR.tSave(),
          actionFunction: () => Navigator.of(context).pop(true),
          dismissTitle: L10nR.tDiscard(),
          dismissFunction: () => Navigator.of(context).pop(false),
        ),
      );

  static Future<bool?> showConfirmSettingsReset([BuildContext? context]) => showAdaptiveDialog<bool?>(
        context: context ?? RoutesBase.activeContext!,
        builder: (context) => MyDialogue(
          title: L10nR.tConfirmReset(),
          content: L10nR.tConfirmResetMessage(),
          actionTitle: L10nR.tRESET(),
          actionFunction: () => Navigator.of(context).pop(true),
          dismissTitle: L10nR.tNO(),
          dismissFunction: () => Navigator.of(context).pop(false),
          counterRecommended: true,
        ),
      );
}
