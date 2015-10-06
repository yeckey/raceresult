require 'socket'

module RaceResult
  class Decoder
    attr_accessor :host, :port

    STATUS_KEYS = [:date, :time, :has_power, :antennas, :timing_mode, :file_no,
                   :gps_fix, :location, :rfid_ok]

    def initialize(host, port = 3601)
      self.host = host
      self.port = port

      connect
    end

    def has_power?
      get_status[:has_power] == "1"
    end

    def timing?
      get_status[:timing_mode] == "1"
    end

    def file_no
      get_status[:file_no].to_i
    end

    def has_gps?
      get_status[:gps_fix] == "1"
    end

    def rfid_ok?
      get_status[:rfid_ok] == "1"
    end

    def antennas
      get_status[:antennas].chars.map do |c|
        c == "1"
      end
    end

    def current_time
      status = get_status
      date = status[:date]
      date = Date.today.to_s if date.start_with?('0')
      DateTime.parse(date + ' ' + status[:time])
    end

  private
    def connect
      @socket = TCPSocket.new(host, port)
    end

    def get_status
      @socket.puts 'GETSTATUS'
      status = @socket.gets.chomp.split(';')
      Hash[STATUS_KEYS.zip(status[1..-1])]
    end
  end
end
