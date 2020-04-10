# A Telegram Bot server in Ruby on Heroku using webhooks

An example of a Ruby Telegram Bot server hosted on Heroku.
It's a simple Rack app that handle POST requests.

## Install

1. Create a new bot on Telegram writing to @BotFather the command `/newbot`; it will return the access token for the bot, put it in `API_TOKEN` env variable
2. Setup your bot project on Heroku (see Heroku setup)
3. Enable webhook for bot (replacing `API_TOKEN` and `HEROKU_PROJECT`): `curl -X POST -H 'Content-Type: application/json' 'https://api.telegram.org/botAPI_TOKEN' --data '{"url":"https://HEROKU_PROJECT.herokuapp.com/"}'`

### Heroku setup

- Create a Ruby project
- Set the API_TOKEN with: `heroku config:set API_TOKEN=bot_token`
- Add the app files to git and commit the changes
- Check the logs with: `heroku logs -t`

## Usage

- Write to your bot one of the commands defined (ex. `.D4`)
- A POST request should be received (check the logs)
- The result should be shown

## Do you like it? Star it!

If you use this component just star it. A developer is more motivated to improve a project when there is some interest.

## Contributors

- [Mattia Roccoberton](https://blocknot.es/): author

## License

[MIT](LICENSE.txt)
