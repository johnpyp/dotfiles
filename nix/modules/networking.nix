{ config, pkgs, ... }:
let
  vpnConfig = import "/home/johnpyp/secret/torguard/current.nix";
in
{
  networking = {
    networkmanager.enable = true;
    useDHCP = false;
    nameservers = [ "1.1.1.1" "0.0.0.0" ];
    wg-quick.interfaces = {
      # "wg0" is the network interface name. You can name the interface arbitrarily.
      "wg0" = {
        # Determines the IP address and subnet of the client's end of the tunnel interface.
        address = vpnConfig.address;
        listenPort = 51820;
        dns = [ "1.1.1.1" ];
        # Path to the private key file.
        #
        # Note: The private key can also be included inline via the privateKey option,
        # but this makes the private key world-readable; thus, using privateKeyFile is
        # recommended.
        privateKey = vpnConfig.privateKey;
        # preUp = "${pkgs.nettools}/bin/route add -host $(${pkgs.curl}/bin/curl -s https://ipecho.net/plain) gw 192.168.1.1";
        # postDown = "${pkgs.nettools}/bin/route del -host $(${pkgs.curl}/bin/curl -s https://ipecho.net/plain) gw 192.168.1.1";

        peers = [
          # For a client configuration, one peer entry for the server will suffice.
          {
            # Public key of the server (not a file path).
            publicKey = vpnConfig.publicKey;

            # Forward all the traffic via VPN.
            allowedIPs = [ "0.0.0.0/0" "::0/0" ];
            # Or forward only particular subnets
            #allowedIPs = [ "10.100.0.1" "91.108.12.0/22" ];

            # Set this to the server IP and port.
            endpoint = vpnConfig.endpoint;

            # Send keepalives every 25 seconds. Important to keep NAT tables alive.
            persistentKeepalive = 25;
          }
        ];
      };
    };

  };
}
