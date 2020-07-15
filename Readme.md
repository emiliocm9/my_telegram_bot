# Financial Statements and Company Summary Bot
```
Financial Modeling Prep is a new concept that informs you about stock markets information (news, currencies and stock prices). 
```
This bot will provide the financial statements quarterly, and a company summary for every company in the stock market, using a the Telegram Application. Run the [Stock-Bot](https://t.me/Market_StockPrice_Bot)

## Table of Contents
- [Getting Started](https://github.com/emiliocm9/my_telegram_bot/blob/financial_branch/Readme.md#getting-started)
- [Commands](https://github.com/emiliocm9/my_telegram_bot/blob/financial_branch/Readme.md#commands)
- [Built with](https://github.com/emiliocm9/my_telegram_bot/blob/financial_branch/Readme.md#built-with)
- [Authors](https://github.com/emiliocm9/my_telegram_bot/blob/financial_branch/Readme.md#authors)
- [Contribuiting](https://github.com/emiliocm9/my_telegram_bot/blob/financial_branch/Readme.md#-contributing)

## Getting Started
You can easily chat directly with the bot by searching @Market_StockPrice_Bot on Telegram. Or you can click on this [link](https://t.me/Market_StockPrice_Bot).

### Requirements of Installation.

If you want to download the source code and be able to use its logic to create another bot, you should have installed the next tools.
 - Ruby.
 - Gems within Ruby.
 - Heroku.
 - Rspec.

### Install

  -  Fork this project into your local machine.
  -  Create a bot token and include it on a .env file. Save the variable as 'TOKEN'.
  -  Open your project directory on your terminal
  -  Install gems by running "bundle install" on your terminal
  -  Run 'ruby bin/main.rb' on your terminal.
  -  Open Telegram and start talking with @Market_StockPrice_Bot.

## Commands
  These are the following commands to run the bot correctly and get the desired results. You just need to type them like you were sending a normal message on Telegram.

### Start
  This command will give you the starting instructions. You just need to type 
  > /start
  ![Start Command](https://github.com/emiliocm9/my_telegram_bot/blob/financial_branch/ProjectSS/Start%20Screenshot.png)

### 'Company Summary [symbol]'

  This command will give you a Company Summary depending on the Stock Symbol you use. E.g., NFLX, TSLA, MSFT, etc.
  You just need to type 'Company Summary' before the Stock Symbol of the Company you want to search for. E.g., if want to get a Company Summary of Netflix, I should send the next message.
  > Company Summary NFLX

  ![Company Summary Command](https://github.com/emiliocm9/my_telegram_bot/blob/financial_branch/ProjectSS/CompanySummaryScreenshot.png)

  This command will give you the next information.
   - Price
   - Beta
   - Volume Average
   - Market Capitalisation
   - Last Dividend
   - 52 week range
   - Stock price change
   - Stock price change in percentage
   - Company Name
   - Exchange
   - Description
   - Industry
   - Sector
   - CEO
   - Website
   - Image

### 'Financial Statements [symbol]'

  This command will give you access to financial statement reports, income statement, balance sheet statement and cash flow statement. E.g., NFLX, TSLA, MSFT, etc.
  Each data is Quarter.
  You just need to type 'Financial Statements' before the Stock Symbol of the Company you want to search for. E.g., if want to get a Financial Statement of Tesla, I should send the next message.
  > Financial Statements TSLA

  ![Financial Statements Command](https://github.com/emiliocm9/my_telegram_bot/blob/financial_branch/ProjectSS/FinancialStatementsScreenshot.png)

  This command will give you the next information.
   - Filling Date
   - Period
   - Revenue
   - Cost of Revenue
   - Gross Profit
   - Gross Profit Ratio
   - Cost and Expenses
   - Net Income
   - Deprecation and Amortization
  and more.

## Built with

- Ruby
- Telegram/bot
- Financial Modeling API
- Rspec

## Authors

👤 **Emilio Contreras**

- Github: [@emiliocm9](https://github.com/emiliocm9)
- Twitter: [@emiliocm31](https://twitter.com/emiliocm31)
- Email: [email](emilio.contreras97@gmail.com)

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](https://github.com/emiliocm9/my_telegram_bot/issues).

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

- Project inspired by Microverse Program
  


