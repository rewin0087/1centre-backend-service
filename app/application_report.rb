# frozen_string_literal: true

require 'json'
require 'time'

class ApplicationReport
  def initialize(json_filename)
    @json_filename = json_filename
  end

  #
  # channel parameter
  #   * 'all': returns all applications
  #   * 'qr': filter applications with channel = 'qr'
  #   * 'sales': filter applications with channel = 'sales'
  #   * 'website': filter applications with channel = 'website'
  #
  # Returns the average number of applications by hour (0 to 23) depending on
  # the total number of days available in the JSON file.
  def retrieve_trend(channel = 'all')
    data = filter_records(fetch_data, channel).map(&method(:parse_timestamp_field))

    data.group_by { |record| record['timestamp'].hour }
        .reduce({}) { |hash, (key, records)| hash.merge(key => compute_avg(records)) }
        .sort_by { |k, _v| k }
        .to_h
  end

  private

    attr_reader :json_filename

    def parse_timestamp_field(record)
      record.tap { |item| item['timestamp'] = Time.parse(item['timestamp']) }
    end

    def fetch_data
      file = File.read(File.join(Dir.pwd, json_filename))
      JSON.parse(file)['applications']
    end

    def filter_records(data, channel)
      return data if channel == 'all'

      data.select { |record| record['channel'] == channel.downcase }
    end

    def compute_avg(records)
      grouped_records = records.group_by { |record| record['timestamp'].day }
      days = grouped_records.keys
      total_days = (days.min..days.max).count

      (grouped_records.values.flatten.count / total_days.to_f).round
    end
end
