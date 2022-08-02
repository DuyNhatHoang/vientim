import 'parents/model.dart';

class Setting extends Model {
  String appName;
  String providerAppName;
  bool enableStripe;
  String defaultTax;
  String defaultCurrency;
  String fcmKey;
  bool enablePaypal;
  String defaultTheme;
  String mainColor;
  String mainDarkColor;
  String secondColor;
  String secondDarkColor;
  String accentColor;
  String accentDarkColor;
  String scaffoldDarkColor;
  String scaffoldColor;
  String googleMapsKey;
  String mobileLanguage;
  String defaultCountryCode;
  String appVersion;
  bool enableVersion;
  bool currencyRight;
  int defaultCurrencyDecimalDigits;
  bool enableRazorpay;
  String homeSection1;
  String homeSection2;
  String homeSection3;
  String homeSection4;
  String homeSection5;
  String homeSection6;
  String homeSection7;
  String homeSection8;
  String homeSection9;
  String homeSection10;
  String homeSection11;
  String homeSection12;

  Setting(
      {appName,
      providerAppName,
      enableStripe,
      defaultTax,
      defaultCurrency,
      fcmKey,
      enablePaypal,
      mainColor,
      mainDarkColor,
      secondColor,
      secondDarkColor,
      accentColor,
      accentDarkColor,
      scaffoldDarkColor,
      scaffoldColor,
      googleMapsKey,
      mobileLanguage,
      defaultCountryCode,
      appVersion,
      enableVersion,
      currencyRight,
      defaultCurrencyDecimalDigits,
      enableRazorpay,
      homeSection1,
      homeSection2,
      homeSection3,
      homeSection4,
      homeSection5,
      homeSection6,
      homeSection7,
      homeSection8,
      homeSection9,
      homeSection10,
      homeSection11,
      homeSection12});

  Setting.fromJson(Map<String, dynamic> json)   {
    appName = stringFromJson(json, 'app_name');
    providerAppName = stringFromJson(json, 'provider_app_name');
    defaultTax = json['default_tax'];
    defaultCurrency = json['default_currency'];
    fcmKey = json['fcm_key'];
    defaultTheme = json['default_theme'];
    mainColor = json['main_color'];
    mainDarkColor = json['main_dark_color'];
    secondColor = json['second_color'];
    secondDarkColor = json['second_dark_color'];
    accentColor = json['accent_color'];
    accentDarkColor = json['accent_dark_color'];
    scaffoldDarkColor = json['scaffold_dark_color'];
    scaffoldColor = json['scaffold_color'];
    googleMapsKey = json['google_maps_key'];
    mobileLanguage = json['mobile_language'];
    defaultCountryCode = json['default_country_code'];
    appVersion = json['app_version'];
    enableVersion = boolFromJson(json, 'enable_version');
    currencyRight = boolFromJson(json, 'currency_right');
    enableRazorpay = boolFromJson(json, 'enable_razorpay');
    enableStripe = boolFromJson(json, 'enable_stripe');
    enablePaypal = boolFromJson(json, 'enable_paypal');
    defaultCurrencyDecimalDigits = int.tryParse(json['default_currency_decimal_digits'] ?? '2') ?? 2;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['app_name'] = appName;
    data['provider_app_name'] = providerAppName;
    data['enable_stripe'] = enableStripe;
    data['default_tax'] = defaultTax;
    data['default_currency'] = defaultCurrency;
    data['fcm_key'] = fcmKey;
    data['enable_paypal'] = enablePaypal;
    data['main_color'] = mainColor;
    data['default_theme'] = defaultTheme;
    data['main_dark_color'] = mainDarkColor;
    data['second_color'] = secondColor;
    data['second_dark_color'] = secondDarkColor;
    data['accent_color'] = accentColor;
    data['accent_dark_color'] = accentDarkColor;
    data['scaffold_dark_color'] = scaffoldDarkColor;
    data['scaffold_color'] = scaffoldColor;
    data['google_maps_key'] = googleMapsKey;
    data['mobile_language'] = mobileLanguage;
    data['default_country_code'] = defaultCountryCode;
    data['app_version'] = appVersion;
    data['enable_version'] = enableVersion;
    data['currency_right'] = currencyRight;
    data['default_currency_decimal_digits'] = defaultCurrencyDecimalDigits;
    data['enable_razorpay'] = enableRazorpay;
    return data;
  }
}
