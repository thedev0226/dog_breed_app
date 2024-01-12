require 'rails_helper'

RSpec.describe DogApiService do
  describe '.fetch_breed_image' do
    context 'with a valid breed name' do
      it 'returns a successful result with the breed image URL' do
        allow(Faraday).to receive(:get).and_return(double(success?: true, body: '{"status": "success", "message": "image_url"}'))

        result = DogApiService.fetch_breed_image('husky')

        expect(result.success).to be true
        expect(result.data).to eq('image_url')
        expect(result.error_message).to be nil
      end
    end

    context 'with an invalid breed name' do
      it 'returns an unsuccessful result with an error message' do
        allow(Faraday).to receive(:get).and_return(double(success?: true, body: '{"status": "error", "message": "Breed not found"}'))

        result = DogApiService.fetch_breed_image('invalid_breed')

        expect(result.success).to be false
        expect(result.data).to be nil
        expect(result.error_message).to eq('Breed not found: invalid_breed. Possible breeds: ')
      end
    end

    context 'with a connection error' do
      it 'returns an unsuccessful result with an error message' do
        allow(Faraday).to receive(:get).and_raise(Faraday::ConnectionFailed.new('Connection failed'))

        result = DogApiService.fetch_breed_image('husky')

        expect(result.success).to be false
        expect(result.data).to be nil
        expect(result.error_message).to eq('Error connecting to Dog API: Connection failed')
      end
    end
  end
end
