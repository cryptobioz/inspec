require 'aws-sdk'

class SOSBucket < Inspec.resource(1)
  name 'sos_bucket'

  def initialize(raw_params)
    @params = raw_params
  end

  def to_s
    "SOS Bucket #{@params[:bucket_name]}"
  end

  def exists?
    begin
      region = inspec.backend.sos_client.get_bucket_location(bucket: @params[:bucket_name]).location_constraint
    rescue Aws::S3::Errors::NoSuchBucket
      @exist = false
      return
    end
    @exist = true
  end
end
