module Api
  class TextMeasurementsController < ApplicationController
    def create
      measurement = MeasurementFromTextFactory.from_text(tokenized_text, patient)
      measurement.save!

      send_response_text("Success! We have recorded #{measurement.value} for #{measurement.name}!")

      render nothing: true
    rescue
      if patient.patient
        text = <<-TXT.gsub(/^ {8}/, '')
        Sorry! I didn't recognize that. You can submit fasting glucose like this:
        fgc 50
        Or weight like this:
        wt 180.2
        TXT
        send_response_text(text)
      end
      render nothing: true
    end

    private

    def send_response_text(body)
      @response_text ||= TwilioMessage.create(
        from: from_number,
        to: message.from,
        body: body)
    end

    def from_number
      '555-1212'
    end

    def message
      @message ||= TwilioMessage.get(params['MessageSid'])
    end

    def patient
      @patient ||= Patient.find_by_preferred_phone_number(message.from)
    end

    def tokenized_text
      @tokenized_text ||= TextBodyTokenizer.new(message.body)
    end

  end
end
