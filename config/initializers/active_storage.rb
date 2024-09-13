Rails.application.config.after_initialize do
  ActiveStorage::Current.url_options = {
    host: "127.0.0.1:3000",
    protocol: "http"
  }
end
