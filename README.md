##Game Purchasing App

This is a Flutter-based mobile app designed for purchasing games online. It includes a variety of features such as product listings, cart functionality, checkout process, and invoice generation in PDF format.

#Features

Login & OTP Authentication:

The app allows users to log in using their email address. An OTP will be sent to the email for verification.
If the OTP has any issues, users can use the fallback email: abc@gmail.com.
Splash Screen:

The splash screen fetches game products from the local database.
If the database is empty, products will be added to the local database.

#Home Screen:

Displays a list of games.
Users can swipe left or right to see the next game.
A ListView is also available under the home screen, where users can select a game from either list.
Product Details:

#In the product detail view, there is an animation. Users need to press and hold, then swipe up to see the game details and price.
There are two action buttons: Add to Cart and Buy Now.
Cart & Checkout:

#sers can add games to the cart.
Upon checkout, users can proceed to payment.
After a successful order, users can download the invoice in PDF format.
Invoice Download:

#After the user successfully places an order, they have the option to download the invoice as a PDF.
The PDF will be saved in the device's download folder.
The app will prompt the user to allow storage permissions to store the invoice.

#Technologies Used
Flutter.
GetX: State management.
Sqflite: Local database storage for cart functionality.
PDF: Invoice generation and download.


#Permissions
Storage Permission: Required to store the invoice PDF in the device's download folder.