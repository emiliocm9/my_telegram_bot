require 'telegram/bot'
require 'geocoder'
require_relative 'motive.rb'

class Bot

  def initialize
    token = '1175332363:AAFsytcuXCfYSGpWPpcYRlWJ7uOPEvbWxZE'
      begin
        start_telegram_api
      rescue Telegram::Bot::Exceptions::ResponseError => e
        puts "Bot not connecting properly. Presenting: #{e}"
      end
  end

  def reply(bot, chat_id, content, markup = nil)
    bot.api.send_message(chat_id: chat_id, text: content, reply_markup: markup)
  end

  def start_telegram_api
    Telegram::Bot::Client.run(token) do |bot|
      listen(bot)
    end
  end

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
  
    Telegram::Bot::Client.run(token) do |bot|
      bot.listen do |message|
        case message.text
        when '/start'
          bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name} , welcome to Newsbot created by Emilio Contreras, where you can find the most interesting news, depending on where you are and what you want to read. Please select your country")
        
        when '/stop'
  
          bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}", date: message.date)
        when '/motivate'
          values = Motivate.new
          value = values.select_random
          bot.api.send_message(chat_id: message.chat.id, text: "#{value['text']}", date: message.date)
        else bot.api.send_message(chat_id: message.chat.id, text: "Invalid entry, #{message.from.first_name}, you need
           to use  /start,  /stop , /motivate or /joke")
        end
      end

  def main_menu
    kb = [
      Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Latest news around the world', url: 'https://news.google.com/covid19/map?hl=en-US&gl=US&ceid=US:en'),
      Telegram::Bot::Types::InlineKeyboardButton.new(text: 'How are the numbers in my location?',
                                                     callback_data: 'location'),
      Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Select a specific country', callback_data: 'countries')
    ]
    Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
  end
end

end