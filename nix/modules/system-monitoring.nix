{ config, pkgs, ... }:
{
  services.influxdb.enable = true;
  services.influxdb.dataDir = "/var/db/influxdb";

  services.prometheus.enable = true;

  services.telegraf.enable = true;
  systemd.services.telegraf.path = [ pkgs.lm_sensors ];

  security.sudo.extraRules = [
    { commands = [ { command = "${pkgs.smartmontools}/bin/smartctl"; options = [ "NOPASSWD" ]; } ]; users = [ "telegraf" ]; }
  ];
  services.telegraf.extraConfig = {
    inputs = {
      # zfs = { poolMetrics = true; };
      net = { interfaces = [ "enp*" ]; };
      netstat = {};
      cpu = { totalcpu = true; };
      sensors = {};
      kernel = {};
      mem = {};
      swap = {};
      processes = {};
      system = {};
      disk = {};
      diskio = {};
      sysstat = {};
      smart = {
        path = "${pkgs.writeShellScriptBin "smartctl" "/run/wrappers/bin/sudo ${pkgs.smartmontools}/bin/smartctl $@"}/bin/smartctl";
      };
    };
    outputs = {
      influxdb = { database = "telegraf"; urls = [ "http://localhost:8086" ]; };
      prometheus_client = { listen = ":9273"; };
    };
  };

  services.grafana = {
    enable = true;
    port = 3240;
    addr = "127.0.0.1";
    dataDir = "/var/lib/grafana";
    auth.anonymous.enable = true;
  };

  hardware.mcelog.enable = true;
  services.sysstat.enable = true;
}
