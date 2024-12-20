 import 'package:shared_preferences/shared_preferences.dart';


const String PREFS_KEY_ONBOARDING_SCREEN = "PREFS_KEY_ONBOARDING_SCREEN";
const String PREFS_KEY_IS_USER_LOGGED_IN = "PREFS_KEY_IS_USER_LOGGED_IN";
class AppPreferences{

 SharedPreferences _sharedPreferences;

 AppPreferences(this._sharedPreferences);


 Future<void> setOnBoardingScreenView() async{
   _sharedPreferences.setBool(PREFS_KEY_ONBOARDING_SCREEN, true);
 }

 Future<bool> getOnBoardingScreenView() async{
  return _sharedPreferences.getBool(PREFS_KEY_ONBOARDING_SCREEN) ?? false;
 }

 Future<void> setUserLoggedIn() async{
  _sharedPreferences.setBool(PREFS_KEY_IS_USER_LOGGED_IN, true);
 }

 Future<bool> getUserLoggedIn() async{
  return _sharedPreferences.getBool(PREFS_KEY_IS_USER_LOGGED_IN) ?? false;
 }





 }