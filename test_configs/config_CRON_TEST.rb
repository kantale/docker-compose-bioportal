
LinkedData.config do |config|
  #config.repository_folder  = "/srv/test_bioportal/repository"
  config.repository_folder  = "/srv/bioportal/repository"

    # Deploy the 4store SPARQL server on port 9000
    #4s-httpd -p 9000 -s-1 api_test
  config.goo_host           = "localhost"
  config.goo_port           = 9000

  config.search_server_url = "http://localhost:8983/solr/term_search_core1"
  config.property_search_server_url = "http://localhost:8983/solr/prop_search_core1"

  # Change rest_url_prefix for test is creating bugs
#  config.rest_url_prefix   = "http://localhost:9393/"

  config.enable_security   = false

  # Redis host
  config.goo_redis_host     = "localhost"
  config.goo_redis_port     = 6381

  config.http_redis_host    = "localhost"
  config.http_redis_port    = 6380

  # Email notifications
  config.enable_notifications   = true
  config.email_sender           = "notifications@stageportal.lirmm.fr" # Default sender for emails
  config.email_override         = "override@example.org" # all email gets sent here. Disable with email_override_disable.
  config.email_disable_override = true
  config.smtp_host              = "smtp.lirmm.fr"
  config.smtp_port              = 25
  config.smtp_auth_type         = :none # :none, :plain, :login, :cram_md5
  config.smtp_domain            = "lirmm.fr"
  # Emails of the instance administrators to get mail notifications when new user or new ontology
  config.admin_emails           = ["vincent.emonet@lirmm.fr"]

  config.logger   = Logger.new("/srv/logtest.log")
  config.logger.level = Logger.const_get(ENV['LOG_LEVEL'] ? ENV['LOG_LEVEL'].upcase : 'INFO')
end

Annotator.config do |config|
  config.mgrep_dictionary_file   = "/srv/mgrep/mgrep-55555/test_dictionary.txt"
  config.stop_words_default_file = "./config/default_stop_words.txt"
  config.mgrep_host              = "localhost"
  config.mgrep_port              = 55555
  config.annotator_redis_host    = "localhost"
  config.annotator_redis_port    = 6379
end

NcboCron.config do |config|
  config.ontology_report_path    = "/srv/bioportal/ontologies_report.json"
  config.log_path                = "/srv/bioportal/test.log"
end
