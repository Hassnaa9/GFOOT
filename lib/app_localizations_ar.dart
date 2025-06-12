// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'جي فوت';

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navLearn => 'تعلم';

  @override
  String get navSettings => 'الإعدادات';

  @override
  String get navProfile => 'الملف الشخصي';

  @override
  String get yourCarbonFootprintTitle => 'بصمتك الكربونية';

  @override
  String get whatItIsTitle => 'ما هي؟';

  @override
  String get whatItIsDescription => 'بصمتك الكربونية هي إجمالي كمية غازات الدفيئة التي تنتجها، بما في ذلك ثاني أكسيد الكربون والميثان.';

  @override
  String get benefitsTitle => 'الفوائد';

  @override
  String get benefitsDescription => 'يساعد تقليل بصمتك الكربونية على إبطاء تغير المناخ، والحفاظ على الموارد الطبيعية، وإنشاء مستقبل أكثر استدامة.';

  @override
  String get waysToReduceTitle => 'طرق التخفيض';

  @override
  String get waysToReduceDescription => 'يمكنك تقليل بصمتك عن طريق توفير الطاقة، وتقليل النفايات، واختيار وسائل النقل المستدامة، ودعم المنتجات الصديقة للبيئة.';

  @override
  String get seeYourCarbonFootprintToday => 'شاهد بصمتك الكربونية اليوم!';

  @override
  String get todayLabel => 'اليوم';

  @override
  String get goodJobMessage => 'أحسنت!';

  @override
  String get exploreOurServices => 'اكتشف خدماتنا';

  @override
  String get calculationsTile => 'الحسابات';

  @override
  String get statisticsTile => 'الإحصائيات';

  @override
  String get recommendationTile => 'التوصيات';

  @override
  String get rankTile => 'الترتيب';

  @override
  String get passwordChangedTitle => 'تم تغيير كلمة المرور!';

  @override
  String get passwordChangedSuccessMessage => 'تم تغيير كلمة المرور الخاصة بك بنجاح!';

  @override
  String get backToLoginButton => 'العودة لتسجيل الدخول';

  @override
  String get createNewPasswordTitle => 'إنشاء كلمة مرور جديدة';

  @override
  String get newPasswordUniqueHint => 'يجب أن تكون كلمة المرور الجديدة فريدة عن تلك المستخدمة مسبقاً!';

  @override
  String get enterYourPasswordHint => 'أدخل كلمة المرور الخاصة بك';

  @override
  String get confirmYourPasswordHint => 'تأكيد كلمة المرور الخاصة بك';

  @override
  String get resetPasswordButton => 'إعادة تعيين كلمة المرور';

  @override
  String get otpVerificationTitle => 'التحقق من رمز OTP';

  @override
  String get otpSentToEmailMessage => 'أدخل الرمز المكون من 6 أرقام المرسل إلى بريدك الإلكتروني';

  @override
  String get verifyButton => 'تحقق';

  @override
  String get didntReceiveOtp => 'لم تتلقَ الرمز؟';

  @override
  String get resendOtp => 'إعادة إرسال الرمز';

  @override
  String resendOtpCountdown(int seconds) {
    return 'إعادة إرسال الرمز ($seconds ث)';
  }

  @override
  String get forgotPasswordTitle => 'هل نسيت كلمة المرور؟';

  @override
  String get forgotPasswordHint => 'لا تقلق! يحدث هذا. الرجاء إدخال عنوان بريدك الإلكتروني، وسنرسل رمز OTP إلى بريدك الإلكتروني.';

  @override
  String get enterYourEmailHint => 'أدخل بريدك الإلكتروني';

  @override
  String get continueButton => 'متابعة';

  @override
  String get enterYourPhoneNumberHint => 'أدخل رقم هاتفك (مثال: +20123456789)';

  @override
  String get enterYourCountryHint => 'أدخل دولتك';

  @override
  String get enterYourCityHint => 'أدخل مدينتك';

  @override
  String get registerButton => 'تسجيل';

  @override
  String get orRegisterWith => 'أو سجل بواسطة';

  @override
  String get alreadyHaveAccount => 'هل لديك حساب بالفعل؟';

  @override
  String get loginNowLink => 'تسجيل الدخول الآن';

  @override
  String get helloRegisterToGetStarted => 'مرحباً! سجل لتبدأ';

  @override
  String get enterYourUsernameHint => 'أدخل اسم المستخدم الخاص بك';

  @override
  String get enterYourDisplayNameHint => 'أدخل اسم العرض الخاص بك';

  @override
  String get individualUserDropdown => 'مستخدم فردي';

  @override
  String get companyUserDropdown => 'مستخدم شركة';

  @override
  String get organizationUserDropdown => 'مستخدم منظمة';

  @override
  String get welcomeBackMessage => 'أهلاً بعودتك! سعيد برؤيتك مرة أخرى!';

  @override
  String get loginButton => 'تسجيل الدخول';

  @override
  String get orLoginWith => 'أو تسجيل الدخول بواسطة';

  @override
  String get dontHaveAccount => 'ليس لديك حساب؟';

  @override
  String get registerNowLink => 'سجل الآن';

  @override
  String get signInButton => 'تسجيل الدخول';

  @override
  String get signUpButton => 'التسجيل';

  @override
  String get enterValidEmail => 'الرجاء إدخال بريد إلكتروني صحيح';

  @override
  String get passwordMinLength => 'يجب أن تكون كلمة المرور 8 أحرف على الأقل';

  @override
  String get unknownErrorOccurred => 'حدث خطأ غير معروف';

  @override
  String get emailAlreadyRegistered => 'هذا البريد الإلكتروني مسجل بالفعل. يرجى استخدام بريد إلكتروني آخر.';

  @override
  String get registrationSuccessVerifyEmail => 'تم التسجيل بنجاح! يرجى التحقق من بريدك الإلكتروني.';

  @override
  String get requiredField => 'حقل مطلوب';

  @override
  String get passwordOneUppercase => 'حرف كبير واحد مطلوب';

  @override
  String get passwordOneSpecialChar => 'حرف خاص واحد مطلوب';

  @override
  String get passwordsDoNotMatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get selectUserType => 'اختر نوع المستخدم';

  @override
  String get pleaseSelectUserType => 'الرجاء تحديد نوع المستخدم';

  @override
  String get invalidPhoneNumberExample => 'رقم هاتف غير صالح (مثال: +20123456789)';

  @override
  String get emailVerifiedSuccessfully => 'تم التحقق من البريد الإلكتروني بنجاح!';

  @override
  String get otpResentSuccessfully => 'تم إعادة إرسال الرمز بنجاح';

  @override
  String get pleaseEnterValidOtp => 'الرجاء إدخال رمز OTP صالح مكون من 6 أرقام';

  @override
  String get completeQuestionnaireMessage => 'الرجاء إكمال الاستبيان لرؤية بصمتك الكربونية.';

  @override
  String get redirectingToLogin => 'جارِ إعادة التوجيه إلى تسجيل الدخول...';

  @override
  String get errorPrefix => 'خطأ';

  @override
  String get notificationsSection => 'الإشعارات';

  @override
  String get enablePushNotifications => 'تفعيل الإشعارات الفورية';

  @override
  String get appearanceSection => 'المظهر';

  @override
  String get darkTheme => 'الوضع الداكن';

  @override
  String get unitsSection => 'الوحدات';

  @override
  String get useMetricUnits => 'استخدام الوحدات المترية';

  @override
  String get useMetricUnitsSubtitle => 'التبديل بين الوحدات المترية والإمبريالية';

  @override
  String get languageSection => 'اللغة';

  @override
  String get toggleLanguage => 'تبديل اللغة';

  @override
  String get accountSection => 'الحساب';

  @override
  String get editProfile => 'تعديل الملف الشخصي';

  @override
  String get logoutButton => 'تسجيل الخروج';

  @override
  String get questionnaireBodyType => '🏋️‍♀️ ما هو نوع جسمك؟';

  @override
  String get bodyTypeObese => '⚖️ بدين';

  @override
  String get bodyTypeOverweight => '⚖️ زائد الوزن';

  @override
  String get bodyTypeUnderweight => '⚖️ ناقص الوزن';

  @override
  String get bodyTypeNormal => '⚖️ طبيعي';

  @override
  String get questionnaireGender => '👤 ما هو جنسك؟';

  @override
  String get genderFemale => '♀️ أنثى';

  @override
  String get genderMale => '♂️ ذكر';

  @override
  String get questionnaireDietType => '🍽️ ما هو نوع نظامك الغذائي؟';

  @override
  String get dietOmnivore => '🍖 آكل لحوم';

  @override
  String get dietVegetarian => '🥗 نباتي';

  @override
  String get dietVegan => '🌱 نباتي صرف';

  @override
  String get dietPescatarian => '🐟 نباتي بحري';

  @override
  String get questionnaireShowerFrequency => '🚿 كم مرة تستحم؟';

  @override
  String get showerTwiceDaily => '🕒 مرتين يوميًا';

  @override
  String get showerDaily => '📅 يوميًا';

  @override
  String get showerLessFrequently => '⏳ أقل تكرارًا';

  @override
  String get showerMoreFrequently => '⏰ أكثر تكرارًا';

  @override
  String get questionnaireHeatingSource => '🔥 ما هو مصدر التدفئة الرئيسي لمنزلك؟';

  @override
  String get heatingCoal => '🪨 فحم';

  @override
  String get heatingNaturalGas => '💨 غاز طبيعي';

  @override
  String get heatingWood => '🪵 خشب';

  @override
  String get heatingElectricity => '⚡ كهرباء';

  @override
  String get questionnaireTransportation => '🚗 ما هو وسيلة النقل الرئيسية الخاصة بك؟';

  @override
  String get transportPrivate => '🚘 خاص';

  @override
  String get transportPublic => '🚌 عام';

  @override
  String get transportWalkBicycle => '🚶‍♂️ مشي/دراجة';

  @override
  String get questionnaireVehicleType => '🚙 ما نوع المركبة التي تستخدمها؟';

  @override
  String get vehicleHybrid => '🔋 هجين';

  @override
  String get vehiclePetrol => '⛽ بنزين';

  @override
  String get vehicleDiesel => '🛢️ ديزل';

  @override
  String get vehicleLPG => '💧 غاز بترولي مسال';

  @override
  String get vehicleElectric => '⚡ كهربائي';

  @override
  String get vehicleNaN => '❓ غير معروف';

  @override
  String get questionnaireSocialActivity => '🎉 كم مرة تشارك في الأنشطة الاجتماعية؟';

  @override
  String get socialSometimes => '🤷‍♂️ أحيانًا';

  @override
  String get socialOften => '🥳 غالبًا';

  @override
  String get socialNever => '🚫 أبدًا';

  @override
  String get questionnaireMonthlyGrocery => '🛒 ما هو متوسط فاتورة البقالة الشهرية (بعملتك المحلية)؟';

  @override
  String get questionnaireAirTravel => '✈️ كم مرة سافرت بالطائرة؟';

  @override
  String get airTravelNever => '🚫 أبدًا';

  @override
  String get airTravelRarely => '🌟 نادرًا';

  @override
  String get airTravelFrequently => '🛫 غالبًا';

  @override
  String get airTravelVeryFrequently => '✈️ كثيرًا جدًا';

  @override
  String get questionnaireVehicleDistance => '🛣️ كم كيلومترًا تقود شهريًا؟';

  @override
  String get questionnaireWasteBagSize => '🗑️ ما هو حجم كيس القمامة الخاص بك؟';

  @override
  String get wasteBagMedium => '📏 متوسط';

  @override
  String get wasteBagSmall => '📏 صغير';

  @override
  String get wasteBagLarge => '📏 كبير';

  @override
  String get questionnaireWasteBagCount => '♻️ في المتوسط، كم عدد أكياس القمامة التي تستخدمها أسرتك أسبوعيًا؟';

  @override
  String get questionnaireTvPcHours => '📺 في المتوسط، كم ساعة تقضيها يوميًا في مشاهدة التلفزيون أو استخدام الكمبيوتر؟';

  @override
  String get questionnaireInternetHours => '🌐 في المتوسط، كم ساعة تقضيها على الإنترنت يوميًا؟';

  @override
  String get questionnaireNewClothes => '👕 في المتوسط، كم عدد الملابس الجديدة التي تشتريها شهريًا؟';

  @override
  String get questionnaireEnergyEfficiency => '💡 هل تبحث بنشاط عن الأجهزة الموفرة للطاقة؟';

  @override
  String get energyEfficiencyYes => '✅ نعم';

  @override
  String get energyEfficiencySometimes => '🤔 أحيانًا';

  @override
  String get energyEfficiencyNo => '❌ لا';

  @override
  String get questionnairePleaseAnswer => 'الرجاء الإجابة على:';

  @override
  String get questionnairePleaseCorrect => 'الرجاء التصحيح:';

  @override
  String get questionnaireMustBeNumber => 'يجب أن يكون رقمًا صحيحًا';

  @override
  String get questionnaireHoursRange => 'يجب أن يكون بين 0 و 24 ساعة';

  @override
  String get questionnairePositiveNumber => 'يجب أن يكون رقمًا موجبًا';

  @override
  String get submitButton => 'إرسال';

  @override
  String get enterValue => 'أدخل القيمة';

  @override
  String get invalidNumber => 'رقم غير صالح';

  @override
  String get permissionDeniedMessage => 'تم رفض الإذن. يرجى تمكينه في الإعدادات.';

  @override
  String get errorPickingImageMessage => 'خطأ في اختيار الصورة';

  @override
  String get errorSavingImageMessage => 'خطأ في حفظ الصورة';

  @override
  String get editProfileTitle => 'تعديل الملف الشخصي';

  @override
  String get fullNameLabel => 'الاسم الكامل';

  @override
  String get addressLabel => 'العنوان';

  @override
  String get dateOfBirthLabel => 'تاريخ الميلاد';

  @override
  String get emailLabel => 'البريد الإلكتروني';

  @override
  String get updateButton => 'تحديث';

  @override
  String get profileUpdateSuccessMessage => 'تم تحديث الملف الشخصي بنجاح!';

  @override
  String get profileUpdateFailedMessage => 'فشل تحديث الملف الشخصي';

  @override
  String get cameraOption => 'الكاميرا';

  @override
  String get galleryOption => 'المعرض';

  @override
  String get notificationsTitle => 'الإشعارات';

  @override
  String get noNotificationsYetMessage => 'لا توجد إشعارات بعد!';

  @override
  String dayAgo(int days) {
    return 'منذ يوم واحد';
  }

  @override
  String daysAgo(int days) {
    return 'منذ $days أيام';
  }

  @override
  String hourAgo(int hours) {
    return 'منذ ساعة واحدة';
  }

  @override
  String hoursAgo(int hours) {
    return 'منذ $hours ساعات';
  }

  @override
  String minuteAgo(int minutes) {
    return 'منذ دقيقة واحدة';
  }

  @override
  String minutesAgo(int minutes) {
    return 'منذ $minutes دقائق';
  }

  @override
  String get justNow => 'الآن';

  @override
  String get notificationLogActivityTitle => 'سجل نشاطك اليومي';

  @override
  String get notificationLogActivityDescription => 'لا تنس تسجيل سفرك ووجباتك لتتبع بصمتك الكربونية!';

  @override
  String get notificationGreatJobTitle => 'عمل رائع!';

  @override
  String get notificationGreatJobDescription => 'لقد خفضت بصمتك الكربونية بنسبة 5% هذا الأسبوع. استمر في ذلك!';

  @override
  String get notificationSustainableTipTitle => 'نصيحة مستدامة';

  @override
  String get notificationSustainableTipDescription => 'حاول المشي أو ركوب الدراجة بدلاً من القيادة لتقليل الانبعاثات.';

  @override
  String get notificationHighCarbonAlertTitle => 'تنبيه كربون عالي!';

  @override
  String get notificationHighCarbonAlertDescription => 'رحلتك الأخيرة زادت بصمتك الكربونية بشكل كبير. فكر في التعويض عن طريق إجراء مستدام.';

  @override
  String get notificationMilestoneAchievedTitle => 'تم تحقيق إنجاز!';

  @override
  String get notificationMilestoneAchievedDescription => 'تهانينا! لقد عادلت 1 طن من ثاني أكسيد الكربون من خلال خياراتك المستدامة هذا الشهر!';

  @override
  String get notificationEnergySavingTipTitle => 'نصيحة لتوفير الطاقة';

  @override
  String get notificationEnergySavingTipDescription => 'أطفئ الأنوار وافصل الأجهزة عندما لا تكون قيد الاستخدام لتقليل استهلاكك للطاقة.';

  @override
  String get notificationChallengeAcceptedTitle => 'تم قبول التحدي!';

  @override
  String get notificationChallengeAcceptedDescription => 'لقد انضممت إلى تحدي \'الاثنين الخالي من اللحوم\'. سجل وجباتك النباتية لكسب النقاط!';

  @override
  String get notificationCommunityUpdateTitle => 'تحديث المجتمع';

  @override
  String get notificationCommunityUpdateDescription => 'مدينتك أطلقت للتو برنامج إعادة تدوير جديد. تحققه لتقليل النفايات!';

  @override
  String get notificationWaterConservationTipTitle => 'نصيحة للحفاظ على المياه';

  @override
  String get notificationWaterConservationTipDescription => 'قلل مدة استحمامك لتوفير المياه وتقليل تأثيرك البيئي.';

  @override
  String get notificationMonthlySummaryTitle => 'ملخص شهري';

  @override
  String get notificationMonthlySummaryDescription => 'بصمتك الكربونية لهذا الشهر هي 1.2 طن. اهدف إلى 1 طن الشهر المقبل بتغييرات صغيرة!';

  @override
  String get profileTitle => 'الملف الشخصي';

  @override
  String get editMyAccount => 'تعديل حسابي';

  @override
  String get helpCenter => 'مركز المساعدة';

  @override
  String get emailPrefix => 'البريد الإلكتروني';

  @override
  String get phonePrefix => 'الهاتف';

  @override
  String get locationPrefix => 'الموقع';

  @override
  String get notAvailable => 'غير متاح';

  @override
  String get rankTitle => 'الترتيب';

  @override
  String get loadingUser => 'جارٍ تحميل المستخدم...';

  @override
  String get failedToLoadUser => 'فشل تحميل المستخدم';

  @override
  String get retryButton => 'إعادة المحاولة';

  @override
  String get userNamePlaceholder => 'اسم المستخدم';

  @override
  String get cityRankTitle => 'ترتيب المدينة';

  @override
  String get countryRankTitle => 'ترتيب الدولة';

  @override
  String get globalRankTitle => 'الترتيب العالمي';

  @override
  String get noRankingsAvailable => 'لا توجد تصنيفات متاحة';

  @override
  String get yourEcoRecommendationsTitle => 'توصياتك البيئية';

  @override
  String get noRecommendationsYetMessage => 'لا توجد توصيات بعد!';

  @override
  String get carbonEmissionReportTitle => 'تقرير انبعاثات الكربون';

  @override
  String get dailyTab => 'يومي';

  @override
  String get monthlyTab => 'شهري';

  @override
  String get yearlyTab => 'سنوي';

  @override
  String get emissionTrendsTitle => 'اتجاهات الانبعاثات';

  @override
  String get noDataAvailable => 'لا توجد بيانات متاحة';

  @override
  String get kilogramAbbreviation => 'كجم';
}
