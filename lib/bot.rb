require 'telegram/bot'
require 'geocoder'
require 'open-uri'
require_relative 'motive.rb'
require 'news-api'

class Bot
  attr_reader :commands, :token

  def initialize
    @token = '1175332363:AAFsytcuXCfYSGpWPpcYRlWJ7uOPEvbWxZE'
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
            "These are the latest news around the World for #{Date.today.strftime('%a, %-d %b of %Y:')}")
      reply(bot, message.chat.id, search('/start'))
      reply(bot, message.chat.id, 'Please select one of the following options', main_menu)

    elsif message.text.nil?
      # Provides stats according to the country if given a location.
      location = Geocoder.search([message.location.latitude, message.location.longitude])
      reply(bot, message.chat.id, search('location', location))

    elsif search('countries').include? message.text.downcase
      reply(bot, message.chat.id, search(message.text))
    else
      reply(bot, message.chat.id, "I can't help you, please select from the following options:", main_menu)
    end
  end

  # Connects with the Covid API Class
  def search(command, location = nil)
    covid_api = CovidApi.new
    newsapi = News.new('bb3ba6f0ed7f48689708122da76ecdcc')

    case command
    when '/start'
      newsapi.get_top_headlines(q: 'bitcoin',
        sources: 'bbc-news,the-verge',
        category: 'business',
        language: 'en',
        country: 'us')

    when 'countries'
      covid_api.countries.join(', ')

    when 'location'
      covid_api.country(covid_api.get_slug_country(location.first.country)) if location

    else
      covid_api.country(command)
    end
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