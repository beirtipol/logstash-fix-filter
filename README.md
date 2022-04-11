[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

# What is this?
This is a filter plugin for logstash allowing the parsing of FIX messages and conversion in to nested document fields which
can be easily in to Elasticsearch.

Rather than using a codec, this is implemented as a filter to allow easy interoperability with standard logstash inputs. 
For example, you can read your FIX messages from a database using [JDBC Input](https://www.elastic.co/guide/en/logstash/current/plugins-inputs-jdbc.html)
, or [File Input](https://www.elastic.co/guide/en/logstash/current/plugins-inputs-file.html) or even let Filebeat handle the 
heavy lifting and have it stream to your logstash instance directly. Up to you.


# Configuration
Here the available configuration fields along with the default values are shown
```
filter {
   fix_filter {
      # This specifies the field delimiter. By default, the 'SOH' character is used but pipe-separated fields are common
      delimiter => ""
      
      # This can be any standard FIX dictionary included in QuickFIXJ, or you can specify a filesystem path
      dictionary_path => "FIX50SP2.xml"
      
      # Whether or not to use the dictionary field names or just use tag numbers.
      # Any fields not present in the dictionary will be stored with a field name of the tag number 
      dictionary_field_names => true
      
      # The source field
      source => "message"
      
      # The target field to store the fix_message in
      target => "fix_message"
   }
}
```

See the [./examples](./examples) folder for some more logstash configs using this filter.


# Build instructions

Building logstash plugins can be a little convoluted. This project makes use of docker to download and build the 
required logstash dependencies in order to build the plugin. Simply run [./buildWithDocker.bat](./buildWithDocker.bat) or [./buildWithDocker.sh](./buildWithDocker.sh)

## Building Manually
This project was built using the logstash 8.3.0 source following the guide [here](https://www.elastic.co/guide/en/logstash/current/java-filter-plugin.html)
There was one nasty gotcha. The `gem` task in [./build.gradle](./build.gradle) in the logstash guide is missing an '=' for the dependsOn.
```
tasks.register("gem"){
    dependsOn=[downloadAndInstallJRuby, removeObsoleteJars, vendor, generateRubySupportFiles]
    doLast {
        buildGem(projectDir, buildDir, pluginInfo.pluginFullName() + ".gemspec")
    }
}
```

1. Clone [https://github.com/elastic/logstash.git](https://github.com/elastic/logstash.git) to [c:\dev\source\logstash](c:\dev\source\logstash)
   1. If you use a different source path, you will need to update [./gradle.properties](./gradle.properties)
2. Open a terminal in the current path and execute  `./gradlew gem`
   1. Note: The gradle daemon seems to hold a handle to the produced artifacts. You may need to kill the gradle daemon before rebuilding with `./gradle -stop`
3. This will produce [./logstash-filter-fix_filter-x.x.x.gem](./logstash-filter-fix_filter-x.x.x.gem). Copy the full path to this file.

# Installing the plugin in to logstash
1. In your logstash installation, install with `.\logstash-plugin install --no-verify --local C:/dev/source/logstash-fix-filter/logstash-filter-fix_filter-1.0.0.gem`
   1. This assumes the current directory of this project is `c:\dev\source\logstash-fix-filter`. Update as appropriate.

## Licensing?
I'm not precious. It's released under GPL3. Do what you like with it. Copy it, rip it apart, extend it, make it better. I would ask that you let me know if you've done any of that, but you don't have to.
