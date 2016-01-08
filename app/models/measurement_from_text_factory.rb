class MeasurementFromTextFactory
  def self.from_text(text, patient)
    case text.marker_abbreviation
    when 'bp'
      Measurement.new(name: 'bp', patient: patient, value: text.marker_value)
    when 'wt'
      Measurement.new(name: 'wt', patient: patient, value: text.marker_value)
    else
      raise "oops I don't know what to do"
    end
  end
end
