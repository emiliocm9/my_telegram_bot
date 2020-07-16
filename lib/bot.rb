require 'telegram/bot'
require 'geocoder'
require 'open-uri'
require_relative 'summary.rb'
require_relative 'financial.rb'

class Bot
  attr_reader :commands, :token, :uri

  def initialize
    @token = '1075499722:AAHFsXOCXod9YEtiokU-bDJ2Q0SmQTS6egc'
    begin
      start_telegram_api
    rescue Telegram::Bot::Exceptions::ResponseError => e
      puts "Bot not connecting properly. Presenting: #{e}"
    end
  end

  def reply(bot, chat_id, content, markup = nil)
    bot.api.send_message(chat_id: chat_id, text: content, reply_markup: markup)
  end

 # private

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
        when 'Company Summary'
          reply(bot, message.from.id, 'Data for a company such as 52 week high,
             52 week low, market capitalization, and key stats to understand a company finance.')
          reply(bot, message.from.id, 'Please type the stock symbol you want
             to search. E.g., TSLA, MSFT, NFLX, etc.')
        when 'Financial Statements'
          reply(bot, message.from.id, 'Access to financial statement reports, income statement,
             balance sheet statement and cash flow statement quarterly.')
          reply(bot, message.from.id, 'Please type the stock symbol you want to search. E.g., TSLA, MSFT, NFLX, etc.')

        else
          reply(bot, message.from.id, "I don't know how to help you with this")
        end
      end
    end
  end

  def listen_message_text(bot, message)
    if message.text == '/start'
      start_bot(bot, message)
    elsif message.text != '/start' && message.text != '/stop'
      if message.text.include?('Company Summary')
        comp = message.text.split(' ').to_a[-1]
        reply(bot, message.chat.id, search(comp))
      elsif message.text.include?('Financial Statement')
        compa = message.text.split(' ').to_a[-1]
        reply(bot, message.chat.id, finance_first(compa))
      else
        reply(bot,
              message.chat.id,
              "Please type the STOCK symbol after 'Company Summary' or 'Financial Statements'
            to get the desired result.\nE.g., Company Summary TSLA,\nFinancial Statements MSFT,\netc.")
        reply(bot, message.chat.id, 'If you want to read the latest news, select the button bellow.', main_menu)
      end
    else
      reply(bot, message.chat.id, "I can't help you, please select from the following options:", main_menu)
    end
  end

  def search(commands)
    stats = KeyStats.new
    stats.get_information(commands)
  end

  def finance_first(commands)
    finance = FinStatus.new
    finance.get_finance(commands)
  end

  def start_bot(bot, message)
    reply(bot, message.chat.id, "Hello, #{message.from.first_name}.")
    reply(bot, message.chat.id, "This bot will give you the Financial DATA of every company
    in the Market and cashflow statement quarterly.\nToday: #{Date.today.strftime('%a, %-d %b of %Y:')}")
    reply(bot, message.chat.id, "Please type the STOCK symbol after 'Company Summary' or 'Financial Statements'
    to get the desired result.\nE.g., Company Summary TSLA,\nFinancial Statements MSFT,\netc.")
    reply(bot, message.chat.id, 'If you want to read the latest news, select the button bellow.', main_menu)
  end

  def main_menu
    kb = [
      Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Latest News', url: 'https://www.google.com/search?q=finance&output=search&tbm=nws&source=lnms&sa=X&ved=2ahUKEwjuvK_qoc7qAhUFLKwKHQRVBA4Q_AUoAXoECAcQCQ&biw=1366&bih=581&dpr=1')
    ]
    Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
  end
end
