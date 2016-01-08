require 'rails_helper'

RSpec.describe Api::TextMeasurementsController, type: :controller do
  describe '#create' do
    it 'notified Twillio' do
      message = double(from: '123-4567', body: 'weight: 180lbs')
      allow(TwilioMessage).to receive(:get).with('123456789') { message }
      tokenized_text = double
      allow(TextBodyTokenizer).to receive(:new).with('weight: 180lbs') {tokenized_text}
      patient = double
      allow(Patient).to receive(:find_by_preferred_phone_number).
                        with('123-4567') { patient}

      measurement = double(:save! => true, value: 180, name: 'weight')
      allow(MeasurementFromTextFactory).to receive(:from_text).with(tokenized_text, patient) { measurement }

      allow(TwilioMessage).to receive(:create)

      post :create, MessageSid: '123456789'

      expect(TwilioMessage).to have_received(:create).with(
        from: '555-1212',
        to: '123-4567',
        body: 'Success! We have recorded 180 for weight!'
      )
    end
  end
end
