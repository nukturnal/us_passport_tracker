RSpec.describe USPassportTracker do
  it 'has a version number' do
    expect(USPassportTracker::VERSION).not_to be nil
  end

  describe 'Tracking a Valid Passport ID Number' do
    context 'with an invalid USA Embassy country code' do
      it 'should return a "no status update" status' do
        track = @track.dup.new(@valid_passport, @valid_country_invalid_embassy)
        track.status
        expect(track.country_name).not_to be nil
        expect(track.response_text).not_to be nil
        expect(track.response_text).to include('no status update')
      end
    end

    context 'with a valid USA Embassy country code' do
      it 'should return a "ready for pickup" or "still with the US" status' do
        track = @track.dup.new(@valid_passport, @valid_country_code)
        track.status
        expect(track.country_name).not_to be nil
        expect(track.response_text).not_to be nil
        valid_response = track.response_text.include?('ready for pickup') ||
                         track.response_text.include?('still with the US')
        expect(valid_response).to be true
      end
    end
  end

  describe 'Tracking an Invalid Passport ID Number' do
    context 'with an invalid USA Embassy country code' do
      it 'should return a "no status update" status' do
        track = @track.dup.new(@invalid_passport, @valid_country_invalid_embassy)
        track.status
        expect(track.country_name).not_to be nil
        expect(track.response_text).not_to be nil
        expect(track.response_text).to include('no status update')
      end
    end

    context 'with a valid USA Embassy country code' do
      it 'should still return a "no status update" status' do
        track = @track.dup.new(@invalid_passport, @valid_country_code)
        track.status
        expect(track.country_name).not_to be nil
        expect(track.response_text).not_to be nil
        expect(track.response_text).to include('no status update')
      end
    end
  end
end
