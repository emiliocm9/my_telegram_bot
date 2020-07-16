require_relative '../lib/financial.rb'

describe FinStatus do
  let(:finance) { FinStatus.new }

  describe '#get_finance' do
    let(:symbol_wrong) { finance.get_finance('ALSEA') }
    let(:symbol_right) { finance.get_finance('NFLX') }
    it 'Will display an error message if the STOCK symbol does not exist.' do
      expect(p symbol_wrong).to eql('Error: please type the STOCK symbol again.')
    end

    it 'Returns a string including a financial statements' do
      expect((p symbol_right).include?('financials')).to eql(true)
    end
  end
end
