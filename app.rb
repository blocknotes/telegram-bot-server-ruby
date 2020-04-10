# frozen_string_literal: true

require 'dotenv/load'
require 'telegram/bot'

# Main class
class App
  def call(env)
    if env['REQUEST_METHOD'] == 'POST'
      handle_post(env)
    elsif env['REQUEST_METHOD'] == 'GET'
      handle_get
    end
  end

  def initialize
    @api = Telegram::Bot::Client.new(ENV.fetch('API_TOKEN')).api
  end

  private

  def eval_val(val)
    val.to_i
  end

  def handle_get
    [200, { 'Content-Type' => 'text/plain' }, ['This is not the bot you are looking for...']]
  end

  def handle_post(env)
    req = Rack::Request.new(env)
    parse_command JSON.parse(req.body.read)
    [204, {}, ['']]
  end

  def keyboard_options
    {
      keyboard: [
        %w[.D4 .D6 .D8],
        %w[.D10 .D12 .D20]
      ]
    }
  end

  def parse_command(params)
    text = params&.dig('message', 'text') || ''
    chat_id = params&.dig('message', 'chat', 'id')
    return unless chat_id

    if text == '.dice'
      markup = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard_options)
      @api.send_message(chat_id: chat_id, text: 'Dice selector:', reply_markup: markup)
    elsif (tokens = text.match(/\A\.[dD](\d+)\Z/))
      text = (sides = tokens[1].to_i) > 1 ? roll(sides).to_s : 'Invalid number of sides'
      @api.send_message(chat_id: chat_id, text: text)
    end
  end

  def roll(sides)
    rand(sides) + 1
  end
end
