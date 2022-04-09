# Usage instructions


# Build instructions
This project was built using the logstash 8.3.0 source.

1. Clone [https://github.com/elastic/logstash.git](https://github.com/elastic/logstash.git) to [c:\dev\source\logstash](c:\dev\source\logstash)
   1. If you use a different source path, you will need to update [./gradle.properties](./gradle.properties)
2. Open a terminal in the current path and execute  `./gradlew gem`
   1. Note: The gradle daemon seems to hold a handle to the produced artifacts. You may need to kill the gradle daemon before rebuilding with `./gradle -stop`
3. This will produce [./logstash-codec-fix_codec-x.x.x.gem](./logstash-codec-fix_codec-x.x.x.gem). Copy the full path to this file.
4. In your logstash installation, install with `.\logstash-plugin install --no-verify --local C:/dev/source/logstash-fix-codec/logstash-codec-fix_codec-1.0.0.gem`

