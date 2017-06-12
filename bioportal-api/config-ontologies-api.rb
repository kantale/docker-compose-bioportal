#local IP address lookup. This hack doesn't make connection to external hosts
require 'socket'
  def local_ip
    orig, Socket.do_not_reverse_lookup = Socket.do_not_reverse_lookup, true  # turn off reverse DNS resolution temporarily

    UDPSocket.open do |s|
      s.connect '8.8.8.8', 1 #google
      s.addr.last
    end
  ensure
    Socket.do_not_reverse_lookup = orig
  end

$LOCAL_IP = local_ip
$SITE_URL = "localhost"

begin
  # For prefLabel extract main_lang first, or anything if no main found.
  # For other properties only properties with a lang that is included in main_lang are used
  Goo.main_lang = ["en", "eng", "fr"]
  Goo.use_cache = true
rescue NoMethodError
  puts "(CNFG) >> Goo.main_lang not available"
end

begin
  LinkedData.config do |config|
    config.repository_folder  = "/srv/bioportal/repository"
    config.goo_host           = "bioportal-4store"
    config.goo_port           = 9000
    config.search_server_url  = "http://bioportal-solr:8983/solr/term_search_core1"
    config.property_search_server_url = "http://bioportal-solr:8983/solr/prop_search_core1"

    config.replace_url_prefix = true
    config.rest_url_prefix    = "http://localhost:8080/"
    config.id_url_prefix      = "http://data.bioontology.org/"

    # Set this on true to ask for users apikey, if set on false everyone can do anything without apikey (interesting for testing)
    config.enable_security    = false 

    config.apikey             = "24e0e77e-54e0-11e0-9d7b-005056aa3316" # is it really used?
    config.ui_host            = "#{$SITE_URL}"
    config.sparql_endpoint_url = "http://bioportal-4store:9000/test"
    config.enable_monitoring  = false
    config.cube_host          = "localhost"
    config.enable_slices      = true
    config.enable_resource_index  = false

    # Used to define other bioportal that can be mapped to
    # Example to map to ncbo bioportal : {"ncbo" => {"api" => "http://data.bioontology.org", "ui" => "http://bioportal.bioontology.org", "apikey" => ""}
    # Then create the mapping using the following class in JSON : "http://purl.bioontology.org/ontology/MESH/C585345": "ncbo:MESH"
    # Where "ncbo" is the namespace used as key in the interportal_hash
    config.interportal_hash   = {"ncbo" => {"api" => "http://data.bioontology.org", "ui" => "http://bioportal.bioontology.org", "apikey" => "4a5011ea-75fa-4be6-8e89-f45c8c84844e"},
                                 "agroportal" => {"api" => "http://data.agroportal.lirmm.fr", "ui" => "http://agroportal.lirmm.fr", "apikey" => "1cfae05f-9e67-486f-820b-b393dec5764b"}}

    # Caches
    config.http_redis_host    = "redis-http"
    config.http_redis_port    = 6379
    config.enable_http_cache  = true
    config.goo_redis_host     = "redis-goo"
    config.goo_redis_port     = 6379

    # Email notifications
    config.enable_notifications   = false
    config.email_sender           = "notifications@bioportal.lirmm.fr" # Default sender for emails
    config.email_override         = "override@example.org" # all email gets sent here. Disable with email_override_disable.
    config.email_disable_override = true
    config.smtp_host              = "smtp.lirmm.fr"
    config.smtp_port              = 25
    config.smtp_auth_type         = :none # :none, :plain, :login, :cram_md5
    config.smtp_domain            = "lirmm.fr"
    # Emails of the instance administrators to get mail notifications when new user or new ontology
    config.admin_emails           = ["", ""]

    # PURL server config parameters
    config.enable_purl            = false
    config.purl_host              = "localhost"
    config.purl_port              = 80
    config.purl_username          = "admin"
    config.purl_password          = "password"
    config.purl_maintainers       = "admin"
    config.purl_target_url_prefix = "localhost"

    # Ontology Google Analytics Redis
    # disabled
    config.ontology_analytics_redis_host = "redis-annotator"
    config.enable_ontology_analytics = false
    config.ontology_analytics_redis_port = 6379
end
rescue NameError
  puts "(CNFG) >> LinkedData not available, cannot load config"
end

begin
  Annotator.config do |config|
    config.mgrep_dictionary_file   = "/srv/mgrep/dictionary/dictionary.txt"
    config.stop_words_default_file = "/srv/ncbo/ncbo_cron/config/french_stop_words.txt"
    config.mgrep_host              = "bioportal-mgrep"
    config.mgrep_port              = 55555
    config.mgrep_alt_host          = "bioportal-mgrep"
    config.mgrep_alt_port          = 55555
    config.annotator_redis_host    = "redis-annotator"
    config.annotator_redis_port    = 6379
    config.annotator_redis_prefix  = "c1:"
    config.annotator_redis_alt_prefix  = "c2:"

    # Config for lemmatization
    config.lemmatizer_jar   = "/srv/ncbo/Lemmatizer/"
    config.mgrep_lem_dictionary_file  = "/srv/mgrep/dictionary/dictionary-lem.txt"
    config.mgrep_lem_host          = "localhost"
    config.mgrep_lem_port          = 55557

    # To add other recognizers
    config.enable_recognizer_param = false
    config.supported_recognizers = []
end
rescue NameError
  puts "(CNFG) >> Annotator not available, cannot load config"
end

begin
  OntologyRecommender.config do |config|
end
rescue NameError
  puts "(CNFG) >> OntologyRecommender not available, cannot load config"
end

NcboCron.config do |config|
  config.redis_host  = "redis-annotator"
  config.redis_port  = 6379
  config.search_index_all_url = "http://bioportal-solr:8983/solr/term_search_core2"
  config.property_search_index_all_url = "http://bioportal-solr:8983/solr/prop_search_core2"

  # Ontologies Report config
  config.ontology_report_path = "./srv/bioportal/reports/ontologies_report.json"

  # Google Analytics config
  config.analytics_service_account_email_address = "123456789999-sikipho0wk8q0atflrmw62dj4kpwoj3c@developer.gserviceaccount.com"
  config.analytics_path_to_key_file              = "config/bioportal-analytics.p12"
  config.analytics_profile_id                    = "ga:1234567"
  config.analytics_app_name                      = "BioPortal"
  config.analytics_app_version                   = "1.0.0"
  config.analytics_start_date                    = "2013-10-01"
  config.analytics_filter_str                    = "ga:networkLocation!@stanford;ga:networkLocation!@amazon"

  # this is a Base64.encode64 encoded personal access token
  # you need to run Base64.decode64 on it before using it in your code
  # this is a workaround because Github does not allow storing access tokens in a repo
  config.git_repo_access_token = "YOUR GITHUB REPO PERSONAL ACCESS TOKEN, encoded using Base64"
end


begin
  LinkedData::OntologiesAPI.config do |config|
    config.cube_host                   = "redis-http"
    config.http_redis_host             = "redis-http"
    config.http_redis_port             = 6379
    config.resolver_redis_host = "redis-http"
    config.resolver_redis_port = 6379
    config.restrict_download = []
end
#rescue NameError
#	  puts "(CNFG) >> OntologiesAPI not available, cannot load config"
end

