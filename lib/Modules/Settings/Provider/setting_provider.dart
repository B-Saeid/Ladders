import 'package:audio_session/audio_session.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Shared/Components/Toast/toast.dart';
import '../../../Shared/Extensions/on_context.dart';
import '../../../Shared/Services/AudioSession/audio_session_service.dart';
import '../../../Shared/Services/Database/Hive/hive_service.dart';
import '../../../Shared/Services/Routing/routes_base.dart';
import '../../../Shared/Services/l10n/l10n_service.dart';
import '../../../Shared/Utilities/SessionData/session_data.dart';
import '../../Home/provider/home_provider.dart';
import '../../Home/utilities/Speech/helpers/permissions.dart';
import '../../Home/utilities/Speech/speech_service.dart';
import '../../Home/utilities/dialogues.dart';
import '../Models/mic_type_enum.dart';
import '../Models/microphone_model.dart';

final settingProvider = ChangeNotifierProvider((_) {
  AudioSessionService.listenOnDeviceChanges();
  return SettingsProvider();
});

class SettingsProvider extends ChangeNotifier {
  /// GENERAL SETTINGS

  /// Language
  /// OUTDATED NOTE
  // /// NOTE : In here we initialize a class property with a late property of another class
  // /// Since [SettingsProvider] is not abstract and It is crated in the [MultiProviders]
  // /// and Since we DO INITIALIZE THAT late property BEFORE [runApp] is called
  // /// i.e. before [SettingsProvider] is created .. SO IT is Safe and OK IN THIS CASE.

  /// This is intended to stay auto at every startUp so that we keep track
  /// of the device language EVEN IF [localeSettings] is previously set in Hive DB
  ///
  /// This is to have the flexibility to change the language to follow the device
  /// WITHOUT needing to restart the app
  ///
  /// NOTE: After you record the device language we set [localeSettings] to the
  /// its stored value - if exists - and that occurs in the [RoutesBase] root builder
  late LocaleSetting localeSettings = LocaleSetting.auto;

  void setLocaleSetting(LocaleSetting newSetting) {
    HiveService.settings.put(SettingsKeys.locale, newSetting.name);
    final notInitialized = !L10nService.initialized;
    if (newSetting != localeSettings || notInitialized) {
      localeSettings = newSetting;
      notifyListeners();
      if (SpeechService.isSupported) SpeechService.actOnLocaleChange();
    }
  }

  /// ThemeMode
  ThemeMode themeMode = _initThemeMode();

  static ThemeMode _initThemeMode() {
    final storedValue = HiveService.settings.get(SettingsKeys.themeMode);
    final storedThemeMode = ThemeMode.values.firstWhereOrNull((e) => e.name == storedValue);
    return storedThemeMode ?? ThemeMode.system;
  }

  void setThemeMode(ThemeMode newMode) {
    if (themeMode == newMode) return;
    HiveService.settings.put(SettingsKeys.themeMode, newMode.name);
    themeMode = newMode;
    notifyListeners();
  }

  /// TTS Settings
  bool ttsAvailable = HiveService.settings.get(SettingsKeys.ttsAvailable) ?? false;

  void setTtsAvailable(bool value) {
    if (ttsAvailable == value) return;
    ttsAvailable = value;
    HiveService.settings.put(SettingsKeys.ttsAvailable, value);
    notifyListeners();
  }

  // static String? get _ttsStoredLocale => HiveService.settings.get(SettingsKeys.ttsLocale);
  // SupportedLocale? ttsLocale =
  //     _ttsStoredLocale == null ? null : SupportedLocale.fromSpeechID(_ttsStoredLocale!);
  //
  // void setTtsLocale(SupportedLocale? newLocale) {
  //   if (ttsLocale == newLocale) return;
  //   ttsLocale = newLocale;
  //   HiveService.settings.put(SettingsKeys.ttsLocale, newLocale?.speechID);
  //   notifyListeners();
  // }

  /// TIMER SETTINGS
  bool enableStartCount = HiveService.settings.get(SettingsKeys.enableStartCount) ?? true;

  void setEnableStartCount(bool value) {
    if (enableStartCount == value) return;
    enableStartCount = value;
    HiveService.settings.put(SettingsKeys.enableStartCount, value);
    notifyListeners();
  }

  int startCount = HiveService.settings.get(SettingsKeys.startCount) ?? 3;

  void setStartCount(int count) {
    if (startCount == count) return;
    startCount = count;
    HiveService.settings.put(SettingsKeys.startCount, count);
    notifyListeners();
  }

  bool speakStartCount = HiveService.settings.get(SettingsKeys.speakStartCount) ?? true;

  void setSpeakStartCount(bool value) {
    if (speakStartCount == value) return;
    speakStartCount = value;
    HiveService.settings.put(SettingsKeys.speakStartCount, value);
    notifyListeners();
  }

  bool sayGoWhenRestIsOver = HiveService.settings.get(SettingsKeys.sayGoWhenRestIsOver) ?? true;

  void setSayGoWhenRestIsOver(bool value) {
    if (sayGoWhenRestIsOver == value) return;
    sayGoWhenRestIsOver = value;
    HiveService.settings.put(SettingsKeys.sayGoWhenRestIsOver, value);
    notifyListeners();
  }

  bool enableReadyB4Go = HiveService.settings.get(SettingsKeys.enableReadyB4Go) ?? false;

  void setEnableReadyB4Go(bool value) {
    if (enableReadyB4Go == value) return;
    enableReadyB4Go = value;
    HiveService.settings.put(SettingsKeys.enableReadyB4Go, value);
    notifyListeners();
  }

  int readyB4Go = HiveService.settings.get(SettingsKeys.readyB4Go) ?? 5;

  void setReadyB4Go(int count) {
    if (readyB4Go == count) return;
    readyB4Go = count;
    HiveService.settings.put(SettingsKeys.readyB4Go, count);
    notifyListeners();
  }

  bool halfTotalTimeReminder = HiveService.settings.get(SettingsKeys.halfTotalTimeReminder) ?? true;

  void setHalfTotalTimeReminder(bool value) {
    if (halfTotalTimeReminder == value) return;
    halfTotalTimeReminder = value;
    HiveService.settings.put(SettingsKeys.halfTotalTimeReminder, value);
    notifyListeners();
  }

  bool enableNearEndReminder = HiveService.settings.get(SettingsKeys.enableNearEndReminder) ?? true;

  void setEnableNearEndReminder(bool value) {
    if (enableNearEndReminder == value) return;
    enableNearEndReminder = value;
    HiveService.settings.put(SettingsKeys.enableNearEndReminder, value);
    notifyListeners();
  }

  int nearEndReminderValue = HiveService.settings.get(SettingsKeys.nearEndReminderValue) ?? 30;

  void setNearEndReminderValue(int count) {
    if (nearEndReminderValue == count) return;
    nearEndReminderValue = count;
    HiveService.settings.put(SettingsKeys.nearEndReminderValue, count);
    notifyListeners();
  }

  /// VOICE ACTIONS SETTINGS

  bool speechAvailable = HiveService.settings.get(SettingsKeys.speechAvailable) ?? false;

  void setSpeechAvailable(bool value) {
    if (speechAvailable == value) return;
    speechAvailable = value;
    HiveService.settings.put(SettingsKeys.speechAvailable, value);
    notifyListeners();
  }

  bool enableVoiceActions = HiveService.settings.get(SettingsKeys.enableVoiceActions) ?? false;
  bool loadingEnablingVoiceActions = false;

  Future<void> setEnableVoiceActions(bool value) async {
    void rollBack() {
      HiveService.settings.delete(SettingsKeys.enableVoiceActions);
      enableVoiceActions = false;
      loadingEnablingVoiceActions = false;
      notifyListeners();
    }

    // if (enableVoiceActions == value) return;
    loadingEnablingVoiceActions = true;
    notifyListeners();
    if (value) {
      final ok1 = await SpeechService.initialize(RoutesBase.activeContext!);
      if (!(ok1 ?? false)) return rollBack();

      /// Updating microphones List
      final ok2 = await updateInputDevices();
      if (!ok2) return rollBack();
    }

    enableVoiceActions = value;
    await HiveService.settings.put(SettingsKeys.enableVoiceActions, value);
    if (!enableVoiceActions) await _disposeAnyVoiceActivity();
    loadingEnablingVoiceActions = false;
    notifyListeners();
  }

  Future<void> _disposeAnyVoiceActivity() async {
    final provider = RoutesBase.activeContext!.read(homeProvider);
    if (provider.monitoring || provider.recognizing || provider.loading) {
      if (!provider.loading) {
        Toast.show(
          restOnlyTrigger ? L10nR.tStoppedListening() : L10nR.tRecognitionStopped(),
        );
      }
      await SpeechService.dispose();
    }
    // if (!restOnlyTrigger && !enableVoiceActions) await AudioSessionService.dispose();
  }

  bool restOnlyTrigger = HiveService.settings.get(SettingsKeys.restOnlyTrigger) ?? false;
  bool restOnlyTriggerLoading = false;

  Future<void> setRestOnlyTrigger(bool value) async {
    void rollBack() {
      HiveService.settings.delete(SettingsKeys.restOnlyTrigger);
      restOnlyTriggerLoading = false;
      restOnlyTrigger = false;
      notifyListeners();
    }

    restOnlyTriggerLoading = true;
    notifyListeners();

    if (value) {
      final ok1 = await PermissionsHelper.microphoneCheck(RoutesBase.activeContext!);

      /// This is to set the switch to OFF if the permission is not allowed
      if (!ok1) return rollBack();

      /// Updating microphones List
      final ok2 = await updateInputDevices();
      if (!ok2) return rollBack();
    }

    /// Since [restOnlyTrigger] Mode functions differently from the speech mode
    /// we dispose previous session if exists to avoid any unexpected behavior.
    await _disposeAnyVoiceActivity();

    restOnlyTrigger = value;
    await HiveService.settings.put(SettingsKeys.restOnlyTrigger, value);

    restOnlyTriggerLoading = false;
    notifyListeners();
  }

  // Microphone? microphone;
  //
  late Microphone? microphone = _getMicrophone;

  Microphone? get _getMicrophone {
    final presetMic = HiveService.settings.get(SettingsKeys.presetMic);
    return presetMic != null ? Microphone.fromJson(presetMic) : null;
  }

  Future<void> setMicrophone(Microphone newMic, {bool disposeSession = true}) async {
    print('==================================== setMicrophone');
    if (microphone == newMic) return;
    if (disposeSession) await _disposeAnyVoiceActivity();
    microphone = newMic;
    await HiveService.settings.put(SettingsKeys.presetMic, newMic.toJson);
    notifyListeners();
    print('====================== NEW ======== $newMic');
  }

  List<Microphone> microphones = [];

  Future<bool> updateInputDevices({
    bool toast = false,
    Set<AudioDevice>? sessionInputDevices,
    bool userAction = true,
    bool disposeSession = true,
  }) async {
    final newMicrophones = await AudioSessionService.currentInputDevices(
      oldList: microphones,
      toast: toast,
      sessionInputDevices: sessionInputDevices,
    );

    if (newMicrophones == null || newMicrophones.isEmpty) {
      if (userAction) Toast.showError(L10nR.tCannotAccessMicrophone());
      return false;
    }

    if (microphones.equals(newMicrophones)) return true;
    microphones = newMicrophones;

    /// This is to make it more plausible
    /// If there is a new device, we select it
    /// If not, we see if there is a non-built-in device like headSet or airpods, we select it
    /// Finally, If none of the above we select the first one we find and we can be sure that this
    /// will not throw as we return false if [newMicrophones.isEmpty].
    if (userAction && !StaticData.platform.isMobile) {
      final previousMicExists = microphones.any((element) => element.id == microphone?.id);
      if (previousMicExists) {
        notifyListeners();
        return true;
      }
    }

    final notBuiltIn = microphones.firstWhereOrNull(
      (element) => element.type != null && element.type != MicType.builtIn,
    );
    final newMicrophone = microphones.firstWhereOrNull((element) => element.id != microphone?.id);
    await setMicrophone(
      notBuiltIn ?? newMicrophone ?? microphones.first,
      disposeSession: disposeSession,
    );
    notifyListeners();

    return true;
  }

  bool useBarsList = HiveService.settings.get(SettingsKeys.useBarsList) ?? false;

  void toggleBarsList() {
    useBarsList = !useBarsList;
    HiveService.settings.put(SettingsKeys.useBarsList, useBarsList);
    notifyListeners();
  }

  /// RESET TO DEFAULT SETTINGS
  Future<void> resetDefaults(WidgetRef ref) async {
    final confirmed = await Dialogues.showConfirmSettingsReset();
    if (confirmed != true) return;
    await HiveService.settings.clear();
    ref.invalidate(settingProvider);
    TTSService.init(ensure: true);
  }

  @override
  void dispose() {
    // if (StaticData.platform.isMobile) AudioSessionService.dispose();
    super.dispose();
  }
}

extension OnThemeMode on ThemeMode {
  bool get isAuto => this == ThemeMode.system;

  bool get isLight => this == ThemeMode.light;

  bool get isDark => this == ThemeMode.dark;

  String displayName(WidgetRef ref) => switch (this) {
        ThemeMode.system => L10nR.tAuto(ref),
        ThemeMode.light => L10nR.tLight(ref),
        ThemeMode.dark => L10nR.tDark(ref),
      };

  static ThemeMode? fromStored(storedValue) =>
      ThemeMode.values.firstWhereOrNull((e) => e.name == storedValue);
}
