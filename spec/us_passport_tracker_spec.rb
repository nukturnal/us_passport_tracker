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
        expect(track.ready_for_pickup?).to be false
        expect(track.response_text).to include('no status update')
      end
    end

    context 'with a valid USA Embassy country code with screenshot disabled' do
      it 'should return a "ready for pickup" or "still with the US" status' do
        track = @track.dup.new(@valid_passport, @valid_country_code)
        track.status
        expect(track.country_name).not_to be nil
        expect(track.response_text).not_to be nil
        expect(track.screenshot_filename).to be nil
        expect(track.ready_for_pickup?).to be(true) | be(false)
        expect(track.response_text).to include('ready for pickup') | include('still with the US')
      end

      it 'with a valid USA Embassy country code with screenshot enabled' do
        track = @track.dup.new(@valid_passport, @valid_country_code, true)
        track.status
        expect(track.screenshot_filename).not_to be nil
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
        expect(track.ready_for_pickup?).to be false
        expect(track.response_text).to include('no status update')
      end
    end

    context 'with a valid USA Embassy country code' do
      it 'should still return a "no status update" status' do
        track = @track.dup.new(@invalid_passport, @valid_country_code)
        track.status
        expect(track.country_name).not_to be nil
        expect(track.response_text).not_to be nil
        expect(track.ready_for_pickup?).to be false
        expect(track.response_text).to include('no status update')
      end
    end
  end
end
