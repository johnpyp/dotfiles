{ config, pkgs, ... }:
{
  networking = {
    networkmanager.enable = true;
    useDHCP = false;
    wireguard.interfaces = {
      # "wg0" is the network interface name. You can name the interface arbitrarily.
      "wg0" = {
        # Determines the IP address and subnet of the client's end of the tunnel interface.
        ips = [
          "10.65.178.54/32"
          "fc00:bbbb:bbbb:bb01::2:b235/128"
        ];
        listenPort = 51820;
        # Path to the private key file.
        #
        # Note: The private key can also be included inline via the privateKey option,
        # but this makes the private key world-readable; thus, using privateKeyFile is
        # recommended.
        privateKeyFile = "/home/johnpyp/secret/mullvad-ny.txt";
        # privateKey = "/o2pNKOrDIzPP1WA+6Fa27kL2aoyB0wV8sRwmhXM37M=";

        peers = [
          # For a client configuration, one peer entry for the server will suffice.
          {
            # Public key of the server (not a file path).
            publicKey = "Wy2FhqDJcZU03O/D9IUG/U5BL0PLbF06nvsfgIwrmGk=";

            # Forward all the traffic via VPN.
            allowedIPs = [ "0.0.0.0/1" "::0/1" ];
            # Or forward only particular subnets
            #allowedIPs = [ "10.100.0.1" "91.108.12.0/22" ];

            # Set this to the server IP and port.
            endpoint = "185.232.22.58:51820";

            # Send keepalives every 25 seconds. Important to keep NAT tables alive.
            persistentKeepalive = 25;
          }
        ];
      };
    };

  };
}
