cd ../app/
echo 'generate for app'
flutter packages pub run build_runner build
cd ../feature/feature_chats_list_impl/
echo 'generate for feature_chats_list_impl'
flutter packages pub run build_runner build
cd ../feature_main_screen_impl/
echo 'generate for feature_main_screen_impl'
flutter packages pub run build_runner build
cd ../feature_chat_impl/
echo 'generate for feature_chat_impl'
flutter packages pub run build_runner build
cd ../feature_settings_impl/
echo 'generate for feature_settings_impl'
flutter packages pub run build_runner build
cd ../feature_dev/
echo 'generate for feature_dev'
flutter packages pub run build_runner build
cd ../feature_chat_settings_impl/
echo 'generate for feature_chat_settings_impl'
cd ../feature_wallpappers_impl/
echo 'generate for feature_wallpappers_impl'