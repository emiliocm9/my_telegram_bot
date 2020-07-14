require 'telegram/bot'
require 'geocoder'
require 'open-uri'
require_relative 'motive.rb'
require 'news-api'

class Bot
  attr_reader :commands, :token, :uri

  def initialize
    @token = '1311446527:AAH2ffDev6-BCNjIwanP0IrsWxtR45qztGc'
    begin
      start_telegram_api
    rescue Telegram::Bot::Exceptions::ResponseError => e
      puts "Bot not connecting properly. Presenting: #{e}"
    end
  end

  # Replies messages to the user
  def reply(bot, chat_id, content, markup = nil)
    bot.api.send_message(chat_id: chat_id, text: content, reply_markup: markup)
  end

  private

  # Starts the bot input.
  def start_telegram_api
    Telegram::Bot::Client.run(token) do |bot|
      listen(bot)
    end
  end

  # Listens for user input
  def listen(bot)
    bot.listen do |message|
      case message
      when Telegram::Bot::Types::Message
        listen_message_text(bot, message)

      when Telegram::Bot::Types::CallbackQuery
        case message.data
        when 'location'
          reply(bot, message.from.id, 'Please provide me your location...', inline_menu)

        when 'countries'
          reply(bot, message.from.id, 'Please type one of the following countries to get information:')
          reply(bot, message.from.id, search('countries'))

        else
          reply(bot, message.from.id, "I don't know how to help you with this")
        end
      end
    end
  end

  def listen_message_text(bot, message)
    if message.text == '/start'
      reply(bot, message.chat.id, "Hello, #{message.from.first_name}.")
      reply(bot,
            message.chat.id,
            "This bot will help to know any stock information you want on #{Date.today.strftime('%a, %-d %b of %Y:')}")
            reply(bot,
              message.chat.id,
              "Please type the STOCK symbol you want to search")

    elsif message.text != '/start' && message.text != '/stop'
      # Provides stats according to the country if given a location.
      message.text = message.text.to_s
      reply(bot, message.chat.id, search(message.text))
    else
      reply(bot, message.chat.id, "I can't help you, please select from the following options:", main_menu)
    end
  end

  # Connects with the Covid API Class
  def search(commands)
    covid_api = CovidApi.new
    covid_api.get_information(commands)
  end

  # Provides the user with the current options
  def main_menu
    kb = [
      Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Breaking News-World', url: 'https://news.google.com/covid19/map?hl=en-US&gl=US&ceid=US:en'),
      Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Breaking News-My Location',
                                                     callback_data: 'location'),
      Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Select a Specific Country', callback_data: 'countries')
    ]
    Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
  end

  # Prompts the user to provide its location
  def inline_menu
    kb = [
      Telegram::Bot::Types::KeyboardButton.new(
        text: 'Provide my Location',
        request_location: true,
        one_time_keyboard: true
      )
    ]
    Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: kb)
  end
end