# KyPay
The KyPay app is built for the Rapyd Hackathon. https://devpost.com/software/kypay

The app is a universal app which the current version consists of an eWallet for ease of sending and receiving money and a shopping market place for the any KyPay users to buy things and any approved KyPay users to be the sellers.

The app consists of the mobile version and the backend portal for storing the KyPay user's data such as the users' profiles, addresses, wallet data, images, transactions, items and orders etc ....

The mobile version is the iOS version which is built by the use of Apple's UI framework SwiftUI, UIKit and the Rapyd Mobile iOS SDK 
https://docs.rapyd.net/works-with/reference/introduction-to-mobile-sdk for handling wallet, payment etc and the Firebase Authentication for allowing users to use phone number and one-time password to sign into the app. Here is an intro video of the app https://www.youtube.com/watch?v=nXFGD52hP44

![KyPay app screenshots on iOS simualator](https://user-images.githubusercontent.com/67858418/124703977-e1340980-df25-11eb-9d87-a8adc82b9815.png)

The backend is built with PHP with MySQL or MariaDB as the database to serve the REST API for the iOS mobile app to exchange data with it.

To test this app, you can download it and open it in your Xcode and run it on an iOS simulator. Currently, the iOS app is communicating with the KyPay's backend API which is hosted on my public web server https://techchee.com/KyPayApiTestPointV1/ . If in any case, my API web server isn't working properly maybe due to insufficient resources, just contact me by email ketyung@techchee.com or ketyung@gmail.com or WhatsApp +60138634848 for faster response so I can give the server a reboot.


Or alternatively, you can run the backend on a localhost to communicate with the iOS simulator.

If so, you must install the backend PHP on a localhost web server, e.g. on an Apache (such as MAMP) or Nginx 
running on a localhost . 

The PHP files all reside in the RapydPHP folder. The name of the folder just happened to be RapydPHP but there is no major code in the PHP side that communicates with the Rapyd API except some test PHP files which I used to test the Rapyd API. The RapydPHP folder mainly contains PHP scripts that power the backend of KyPay.

And also go to RapydPHP -> lib -> Core -> sqlfiles , look for the file kypay_db.sql and run this SQL file in your local MySQL to create all the required
tables and import the data.

A quick note for a quick configuration on a MAMP or Apache on localhost, you should have the .htaccess with a rewrite rule to point to the 
RapydPHP/public/index.php , as shown below is how mine is configured 

RewriteEngine on

RewriteCond %{REQUEST_FILENAME} !-f

RewriteCond %{REQUEST_FILENAME} !-d

RewriteRule ^([A-Za-z0-9]+) /KyPay/public/index.php [NC]

Please note the KyPay folder in the above is a symbolic link in my Apache's document root to the RapydPHP folder.

And then you can run the app on the Xcode iOS simulator with the PHP backend on a localhost  .

Please also change the urlBase property of ApiRequestHandler.swift resides in the folder ApiClient, which is the main component encapsulating codes to communicate with the backend PHP api. Change this urlBase property (as shown in the image below boxed in green) from the current https://techchee.com/KyPayApiTestPointV1/ to your localhost and port.

If you wanna test it on an iOS device, you have to add the Rapyd framework for device, currently, what's included here is the Rapyd framework for the simulator
only as I had problem to make the two frameworks to co-exist when developing/testing with Xcode 12.5 and I haven't figured out why. Perhaps the Rapyd dev team could have the answers later. Due to rushing for the hackathon's deadline and the ease of testing it on a simulator with the backend on the localhost instead of remote with frequent changes, so I leave it as it is. As shown in the image below boxed in red, which is the Rapyd Framework for iOS simulator only

![Screenshot 2021-07-07 at 3 22 43 PM](https://user-images.githubusercontent.com/67858418/124718652-e3ec2a00-df38-11eb-983f-354e497a5fe0.png)

Be sure to change the urlBase property of the ApiRequestHandler back to my web server's API test point https://techchee.com/KyPayApiTestPointV1/ if you wanna test ona device as device can't communicate with the localhost. 

About testing.

The app is actually built for my country - Malaysia as default. The testing shopping items by sellers are all items with price of the currency of MYR instead of other currencies.

The app works this way - will determine a country and its currency based on the user's first sign-in phone number's dial code. Of course, you can use any phone number to sign up and an OTP will be sent to that phone number. 

For the purpose of testing for the hackathon, only Malaysia phone numbers are able to test the full features of the app. Or you can use a list of the following Firebase test phone numbers with the preset OTP to sign in (the image below) :

![firebase-test-users](https://user-images.githubusercontent.com/67858418/124722308-822dbf00-df3c-11eb-8172-c52f7f26deea.png)

About the code in Swift and SwiftUI.

The programming approach of UIs and the flow for the iOS is based on the MVVM (Model View ViewModel) architecture pattern. So you can find most of the SwiftUI views are organized in the Views folder, whereas the ViewModels are in the ViewModels folder and so on for the Models.

External Swift packages used including :

Kingfisher - for asynchronously loading images remotely or from URL https://github.com/onevcat/Kingfisher 

SwiftUIX - only two components used from this framework as I needed a TextField that can programmatically become and resign as and from first responder respectively
, thus I use the CocoaTextField from the SwiftUIX and also an ActivityIndicator. https://github.com/SwiftUIX/SwiftUIX.  Or altenatively, these can be written by myself by wrapping UIKit with UIViewRepresentable but due to the rush for the deadline, therefore it's best to use a ready package... 

Firebase and SwiftKeychainWrapper installed by Podfile, for the authentication and a keychain wrapper for more securely storing data like the UserDefauls' way. :D 

The app supports iOS 13 and above but being tested only on the iOS simulators (iPhone and iPad) and iOS devices (iPhone X) running iOS 14.5 only.

Some unfinished work/features that need to be completed later are :

1. The request money section
2. The message section & remote notifications etc 
3. The payment by other options (e.g. bank redirect) during cart checkout

That's all for now... Btw, anyone wish to learn SwiftUI you can read my blog :D https://blog.techchee.com/


https://www.dmca.com/r/d32jwd5 (Limited for use for Rapyd and DevPost testing and teams only) 




