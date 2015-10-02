module RaceResult
  class Passing
    attr_accessor :file_id, :passing_no, :detected_at, :chip_code, :event_id,
                  :hits, :max_rssi, :internal_data, :active
  end
end
