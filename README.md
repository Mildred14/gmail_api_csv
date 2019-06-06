# Gmail_API_CSV

This documentation is about how to use the API from Gmail and providing a CSV file as a result on Ruby.  

## Requirements

- Ruby 2.0 or greater
- A Google account with Gmail enabled

## Installation

Firts clone or download the repo with the [git commands](https://confluence.atlassian.com/bitbucket/clone-a-repository-223217891.html)

After that open the file on your text editor and execute this on the terminal

Then, go to the official page of [GMAIL API](https://developers.google.com/gmail/api/quickstart/ruby) to obtain your credentials.json

Follow Step 1 to turn on the Gmail API and don't forget to download your client configuration (your file probably will be on the download's folder, please change it at the right folder)

Step 2 you need to Install the Google Client Library. Verify that you are on the right path and add this line to your terminal to add the gem
```bash
gem install google-api-client
```
Execute this
```bash
gem install 'csv'
```
After that execute this on the terminal
```bash
ruby nameofyourfile.rb
```

The first time you run the project, it going to prompt you to authorize access:

- Click on the link that gives you and this going to open a new window or tab in your browser. It this fails, don't worry about it just copy the URL on your browser

- Then Google will be prompted to log in in case you are not. If you are logged into differents Gmail accounts, Google will ask you to select one account to use for the authorization.

- Click the Accept button.

- Copy the code on your terminal 

Now you may close the window/tab.

Last Step, follow the simple instructions that appear on the terminal and at the end this attempt to open a file CSV to show you the results. 

