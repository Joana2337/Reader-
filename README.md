
***Reader App***
Overview
The Reader App is a simple iOS application designed to help users track their reading progress. Users can add books to "Currently Reading" and "Want to Read" shelves. It integrates with the Google Books API to search for books, and Apple CloudKit is used for local data storage.

***Features***
Book Search: Search for books using the Google Books API.
Track Reading Progress: Add books to "Currently Reading" or "Want to Read" shelves.
Local Data Storage: Uses Apple CloudKit for data storage and synchronization.

***Setup Instructions***

Clone the Repository
git clone https://github.com/Joana2337/Reader-.git


***Google Books API Key:***

Obtain your API key from the Google Books API.
Store the API key securely in a .swift file (e.g., APIKey.swift).
Make sure to add this file to the .gitignore to avoid pushing sensitive data.

***Set Up CloudKit:***
The app uses Apple CloudKit for local storage. No cloud services are required for deployment as everything is stored locally.

***Run the App:***
Open the project in Xcode and run it on a simulator or physical device.


