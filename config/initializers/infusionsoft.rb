Infusionsoft.configure do |config|
  config.api_url = 'fy226.infusionsoft.com' # example infused.infusionsoft.com
  config.api_key = '5cdd1e3a3e905d9dabe3ba44d180cee6'
  config.api_logger = Logger.new("#{Rails.root}/log/infusionsoft_api.log") # optional logger file
end