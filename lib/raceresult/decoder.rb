module RaceResult
  class Decoder
    attr_accessor :host, :port

    def initialize(host, port: 3601)
      self.host = host
      self.port = port
    end
  end
end
