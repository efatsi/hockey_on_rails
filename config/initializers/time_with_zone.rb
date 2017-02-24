module ActiveSupport
  class TimeWithZone

    def to_mst_time
      in_time_zone("MST").strftime("%-I:%M:%S")
    end

    def to_mst_datetime
      in_time_zone("MST").strftime("%m/%d %-I:%M")
    end
  end
end
