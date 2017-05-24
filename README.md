# web_guesser
Introductory Sinatra app that simulates a number guessing game that has now been changed to be an ajax example

# Setup

  If you do not have yarn installed:
  `$ bundle && npm install`

  If you have yarn installed:
  `$ bundle && yarn install`

### development

  If you do not have yarn installed:
  `$ npm start`

  If you have yarn installed:
  `$ yarn start`

  Then in a new tab/pane/screen
  `$ bundle exec shotgun`

  Go to your browser: [localhost](http://localhost:9393)

### production

  `$ bundle install --without development test`

  If you do not have yarn installed:
  `$ npm run prod`

  If you have yarn installed:
  `$ yarn run prod`

  proxy pass (via apache or nginx) to port **4567** on *127.0.0.1*

  ***

  Production uses WEBrick and can accept 1024 connections by default

### Enjoy!

