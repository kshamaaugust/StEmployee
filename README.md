# stemployee
Security Troops Employee

## Flutter setup on local
	export PATH="$PATH:/Library/WebServer/Documents/flutter/flutter/bin"

## Open Simulator
	open -a Simulator

## Make your flutter folder:
	flutter create stemployee

## To see all details:
	flutter doctor

## To run flutter app:
	flutter run

## After implement in yaml file:
	flutter pub get

## After import package in amy file:
	flutter packages upgrade

## For percent Indicator implement in yaml file: 
	dependencies:
		percent_indicator: "^2.1.5"

## To add assets to your application, add an assets section, like this:
	assets:
    - assets/images/

## Modify .yaml file for using API:
	http: any
	shared_preferences: any  

## After update yaml file run command: 
	flutter pub get

## For use localstorage update yaml file: 
	dependencies:
		localstorage: ^3.0.0

## For use flutterSEcureStorage update yaml file: 
	dependencies:
		flutter_secure_storage: ^3.3.3

## /var/www/apps/time/ForTimeStint/android/app/build.gradle :
	 minSdkVersion 18

## For use geolocator, update in yaml file:
	dependencies:
		geolocator: ^5.1.3

