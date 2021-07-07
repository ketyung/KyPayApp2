# KyPay
The KyPay app is built for the Rapyd Hackathon. The app is a universal app which the current version consists of an eWallet for ease of sending and receiving money and a shopping market place for the any KyPay users to buy things and any approved KyPay users to be the sellers.

The app consists of the mobile version and the backend portal for storing the KyPay user's data.

The mobile version is the iOS version which is built by the use of Apple's UI framework SwiftUI, UIKit and the Rapyd Mobile iOS SDK 
https://docs.rapyd.net/works-with/reference/introduction-to-mobile-sdk and the Firebase Authentication for allowing users to use phone number and one-time
password to sign into the app. Here is an intro video of the app https://www.youtube.com/watch?v=nXFGD52hP44

![KyPay app screenshots on iOS simualator](https://user-images.githubusercontent.com/67858418/124703977-e1340980-df25-11eb-9d87-a8adc82b9815.png)

The backend is built with PHP with MySQL or MariaDB as the database to serve the REST API for the iOS mobile app to exchange data with it.

To test this app, you can clone this in your Xcode. And you must also install the backend PHP, e.g. on an Apache (such as MAMP) or Nginx 
running on a localhost with port 808. 

The PHP files all reside in the RapydPHP folder.

And go to RapydPHP -> lib -> Core -> sqlfiles , look for the file kypay_db.sql and run this SQL file in your local MySQL to create all the required
tables and import the data.

A quick note for a quick configuration on a MAMP or Apache on localhost, you should have the .htaccess with a rewrite rule to point to the 
RapydPHP/public/index.php , as shown below is how mine is configured 

RewriteEngine on
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule ^([A-Za-z0-9]+) /KyPay/public/index.php [NC]

Please note the KyPay folder in the above is a symbolic link in my Apache's document root to the RapydPHP folder.

And then you can run the app on the Xcode iOS simulator with the PHP backend on a localhost.

If you wanna test it on an iOS device, you have to add the Rapyd framework for device, currently, what's included here is the Rapyd framework for the simulator
only as I had problem to make the two frameworks to co-exist when developing/testing with Xcode 12.5 and I haven't figured out why. Due to rushing for the hackathon's deadline and the ease of testing it on a simulator with the backend on the localhost instead of remote with frequent changes, so I leave it as it is. As shown in the image below boxed in red, which is the Rapyd Framework for iOS simulator only

![Screenshot 2021-07-07 at 3 22 43 PM](https://user-images.githubusercontent.com/67858418/124718652-e3ec2a00-df38-11eb-983f-354e497a5fe0.png)

If you want to test on the iOS device, you'll have to change the urlBase property of ApiRequestHandler.swift resides in the folder ApiClient, which is the main component encapsulating codes to communicate with the backend PHP api. Change this urlBase property (as shown in the above image boxed in green) to my server's test point https://techchee.com/KyPayApiTestPointV1/ , I should configure and add the PHP backend to my public web server later. Contact me at ketyung@techchee.com or WhatsApp +60138634848 for faster response.







