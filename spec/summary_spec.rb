require_relative '../lib/summary.rb'

describe KeyStats do
  let(:summary) { KeyStats.new }

  describe '#get_information' do
    let(:info_wrong) { summary.get_information('CREA') }
    let(:info_right) { summary.get_information('DIS') }
    it 'Will display an error message if the STOCK symbol does not exist.' do
      expect(info_wrong).to eql('Error: please type the STOCK symbol again.')
    end

    it 'Returns a string including a financial statements' do
      expect(info_right.include?('price')).to eql(true)
    end
  end
end