# KyPay
The KyPay app is built for the Rapud Hackathon contest. The app is a universal app which the current version consists of an eWallet for ease of sending and receiving money and a shopping market place for the any KyPay users to buy things and any approved KyPay users to be the sellers.

The app consists of the mobile version and the backend portal for storing the KyPay user's data.

The mobile version is the iOS version which is built by the use of Apple's UI framework SwiftUI, UIKit and the Rapyd Mobile iOS SDK 
https://docs.rapyd.net/works-with/reference/introduction-to-mobile-sdk and the Firebase Authentication for allowing users to use phone number and one-time
password to sign into the app

![KyPay app screenshots on iOS simualator](https://user-images.githubusercontent.com/67858418/124703977-e1340980-df25-11eb-9d87-a8adc82b9815.png)

The backend is built with PHP with MySQL or MariaDB as the database to serve the REST API for the iOS mobile app to exchange data with it.

To test this app, you can clone this in your Xcode. And you must also install the backend PHP, e.g. on an Apache (such as MAMP) or Nginx 
running on a localhost with port 808. 

The PHP files all reside in the RapydPHP folder.

And go to RapydPHP -> lib -> Core -> sqlfiles , look for the file kypay_db.sql and run this SQL file in your local MySQL to create all the required
tables and import the data.

