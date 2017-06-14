
LinkedData.config do |config|
  config.repository_folder  = "/srv/test_bioportal/repository"

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

  # Used to define other bioportal that can be mapped to
  config.interportal_hash   = {"ncbo" => {"api" => "http://data.bioontology.org", "ui" => "http://bioportal.bioontology.org", "apikey" => "4a5011ea-75fa-4be6-8e89-f45c8c84844e"}}

  #config.logger   = Logger.new("/srv/logtest.log")
  #config.logger.level = Logger.const_get(ENV['LOG_LEVEL'] ? ENV['LOG_LEVEL'].upcase : 'INFO')
end

Annotator.config do |config|
  config.mgrep_dictionary_file   = "/srv/mgrep/mgrep-55555/dictionary.txt"
  config.stop_words_default_file = "./config/default_stop_words.txt"
  config.mgrep_host              = "localhost"
  config.mgrep_port              = 55555
  config.annotator_redis_host    = "localhost"
  config.annotator_redis_port    = 6379

  config.enable_recognizer_param = true
  config.supported_recognizers = ["mgrep"]
end

NcboCron.config do |config|
  config.ontology_report_path    = "/srv/test_bioportal/ontologies_report.json"
  config.log_path                = "/srv/test_bioportal/test.log"
end

# Ontology_rank should be removed in the next release (it will be calculated on ontologies views)
LinkedData::OntologiesAPI.config do |config|
  config.resolver_redis_host = "localhost"
  config.resolver_redis_port = 6379
  config.restrict_download = ["ACR0", "ACR1", "ACR2"]
end
