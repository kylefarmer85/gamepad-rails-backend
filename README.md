# 
GamePad (Backend)
======
Old games, new friends! GamePad is a vintage video game social media app that enables people to connect through their appreciation of old video games. Discover "new" games for consoles released from 1977-1999 and build a collection of favorites. Leave reviews, comments and find new friends that you can follow to see their reviews, ratings and favorite games!

![](gamepad.gif)

Deployed on Heroku: https://game-pad.herokuapp.com

YouTube Demo Video: https://www.youtube.com/watch?v=uQLKLM_15yA

![Alt text](src/assets/images/gamepad-logo.png?raw=true 'Logo')

## How to run the application
  - Clone this backend and the frontend: https://github.com/kylefarmer85/gamepad-react-frontend
  - Navigate to the backend directory and run `$ bundle install`
  - Next, migrate the database `$ rails db:migrate`
  - Get your own RAWG API access key https://rawg.io/apidocs and save it as a Rails env variable in an .env file like this `RAWG_API_KEY=<your key here>`
  - To start the server run `$ rails s`
  - The API will begin running on localhost:3000
  - Navigate to the frontend directory
  - Run `$ npm install`
  - Run `$ npm start` and the app should connect to localost:3001

Created using the excellent RAWG API - https://rawg.io/apidocs
