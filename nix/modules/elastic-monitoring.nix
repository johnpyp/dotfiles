{ config, pkgs, ... }:
{
  services.elasticsearch = {
    enable = true;
    port = 9200;
    single_node = true;
    listenAddress = "0.0.0.0";
    extraJavaOptions = [
      "-Xms1G"
      "-Xmx1G"
    ];
    package = pkgs.elasticsearch7;
  };

  services.kibana = {
    enable = true;
    listenAddress = "0.0.0.0";
    elasticsearch = {
      hosts = [ "http://localhost:9200" ];
      # username = "poggers";
      # password = "Poggerinos31";
    };
    package = pkgs.kibana7;
  };

  services.logstash = {
    enable = true;
    inputConfig =
      ''
        syslog {
          port => 2122
        }
      '';
    filterConfig =
      ''

    '';
    outputConfig =
      ''
        elasticsearch {
            index => "logstash-syslog-%{+yyyy.MM.dd}"
        }
      '';
  };
}
