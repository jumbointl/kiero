const mainUrl = "https://kiero.com.py/";
const aboutUsUrl = "https://kiero.com.py/quienes-somos/";
const contactUsUrl = "https://kiero.com.py/contacto/";
const rateUsUrl = "https://kiero.com.py/solicitar-credito/";
const moreFromUsUrl = "https://www.facebook.com/kieropy";
const requestCreditUrl = "https://kiero.com.py/solicitar-credito/";
const shoppingCartUrl = "https://kiero.com.py/carrito/";
const loginUrl = "https://kiero.com.py/mi-cuenta/";
const onSaleUrl = "https://kiero.com.py/tienda/?stock_status=onsale";

//Change the app icon for both android and ios
//Copy your image file to assets/icons/ for both android and ios
//Run " flutter pub run flutter_launcher_icons:main " inside your terminal

const appIcon = "assets/icons/app_icon.png";
const appIconDemo = "assets/icons/order_picker.png";
const appIconDemo2 = "assets/icons/splash_screen.jpg";
const splashScreenBackground = appIconDemo;
//set appIconColor to 0 if app icon has default color in built
int appIconColor = "#FFFFFF".getHexValue();
//int appIconColor = 0;

int appThemeColor = "#4169E1".getHexValue();

//home screen setting
const homeScreenTitle = "www.kiero.com.py";

//splash settings
//change the "#152515" with the color you want
int splashBackgroundColor = "#4169E1".getHexValue();
int splashSecondaryColor = "#FFFFFF".getHexValue();
int splashDuration = 2; //in seconds

int pageCalledCount = 0;


//walkthrough settings
int walkthroughBackgroundColor = "#FFFFFF".getHexValue();
int walkthroughSecondaryColor = "#4169E1".getHexValue();

const walkthroughImage1 = "assets/images/walkthough1.png";
const walkthroughImage2 = "assets/images/walkthough2.png";
const walkthroughImage3 = "assets/images/walkthough3.png";

const walkThroughPageOneTitle = "CHANGING YOUR VISION";
const walkThroughPageOneSubtitle = "Convert your website\nto application in 5 minutes";
const walkThroughPageTwoTitle = "BUILD FASTER APPLICATION";
const walkThroughPageTwoSubtitle = "Convert your website\nto application in 5 minutes";
const walkThroughPageThreeTitle = "UP YOUR GAME";
const walkThroughPageThreeSubtitle = "Convert your website\nto application in 5 minutes";

const enableWalkThrough = false;

//main screen controller
const enableAppBar = false;
const enableFloatIcon = false;

//ad settings
const enableBannerAds = false;
const enableInterstitialAds = false;

const String testDevice = 'B3EEABB8EE11C2BE770B684D95219ECB';

//Ids for interstitial Ad
const androidInterstitialAdId = 'ca-app-pub-3940256099942544/5354046379';
const iosInterstitialAdId = 'ca-app-pub-3940256099942544/6978759866';

//Ids for banner Ad
const androidBannerAdId = 'ca-app-pub-3940256099942544/6300978111';
const iosBannerAdId = 'ca-app-pub-3940256099942544/2934735716';

//Ids for app open Ad
const androidOpenAdId = 'ca-app-pub-3940256099942544/3419835294';
const iosOpenAdId = 'ca-app-pub-3940256099942544/5662855259';

const defaultDarkMode = false;

extension HexString on String {
  int getHexValue() => int.parse(replaceAll('#', '0xff'));
}

