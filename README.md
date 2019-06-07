# Gmail_API_CSV

With this Ruby applicaction you will be able to obtain a CSV format containing the relation of users that sent you an email. Keep in mind that this is Gmail users oriented. 

## Requirements

- Ruby 2.0 or greater
- A Google account with Gmail enabled

## Installation

Firts clone or download the repo with the [git commands](https://confluence.atlassian.com/bitbucket/clone-a-repository-223217891.html)

Then, in order to use the Gmail API you will need to create a project into your Google console. You can easily do it throught the following Gmail documentation [GMAIL API](https://developers.google.com/gmail/api/quickstart/ruby). This will give you your credentials.json.

Follow Step 1 to turn on the Gmail API and don't forget to download your client configuration (your file probably will be on the download's folder, please change it at the project root folder )

Step 2 - You need to Install the Google Client Library. Verify that you are on the right path and add this line to your terminal to add the gem:
```bash
gem install google-api-client
```
As the application purpose is to create a CSV, you need to have the csv gem, if you don't have it, then you can install it executing:
```bash
gem install 'csv'
```
Time to run the program:
```bash
ruby app.rb
```

The first time you execute the file, you will be asked to authorize access:
- You can copy the given link and paste it into your favorite browser. Then Google will be prompted to log in, in case you are not, and if you are logged into differents Gmail accounts, Google will ask you to select one account to use for the authorization. Here you should grant the right permisions to the application.

- Click the Accept button.

- Copy the given code and paste it into your terminal. At this point you can close the browser tab.

Last Step, follow the simple instructions that appear on the terminal and at the end this attempt to open a file CSV to show you the results. 
