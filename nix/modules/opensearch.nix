{ config, pkgs, ... }:
{

  services.opensearch = {
    enable = true;
    settings = {
      "http.port" = 9200;
      "transport.port" = 9300;
      "network.host" = "0.0.0.0";
      "discovery.type" = "single-node";
      "cluster.name" = "opensearch";
    }
  };
}
