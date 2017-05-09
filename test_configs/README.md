## How to test BioPortal

### Executing tests

Example with ontologies_linked_data

```shell
cd ruby_workspace/ontologies_linked_data
bundle exec rake test

# Specific test
bundle exec rake test TEST="./test/test_file.rb" TESTOPTS="--name=test_function_name"
bundle exec rake test TEST="./test/models/test_ontology.rb" TESTOPTS="--name=test_ontology_properties"
```

### Copying test config file

The `upload_config_files` script create symbolic link to the different BioPortal projects

It considere that all the projects are located in the same directory (/home/emonet/ruby_workspace by default) wich can be passed as an argument to the script:
`./upload_config_files /home/emonet/ruby_workspace`


### Different projects

* ncbo_annotator

Be careful with dictionary path in config
