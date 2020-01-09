interface:
{
  hostName = "johnpyp-nixos-laptop";
  networkmanager.enable = true;
  useDHCP = false;
  interfaces.${interface}.useDHCP = true;
  wireguard.enable = true;
  wireguard.interfaces = {
    # "wg0" is the network interface name. You can name the interface arbitrarily.
    ${interface} = {
      # Determines the IP address and subnet of the client's end of the tunnel interface.
      ips = [ "10.29.2.158/24" ];

      # Path to the private key file.
      #
      # Note: The private key can also be included inline via the privateKey option,
      # but this makes the private key world-readable; thus, using privateKeyFile is
      # recommended.
      privateKeyFile = "/home/johnpyp/secret/torguard-private.txt";

      peers = [
        # For a client configuration, one peer entry for the server will suffice.
        {
          # Public key of the server (not a file path).
          publicKey = "ZBvdkjaT6t2h3k/MQjLDgqM/F1JfOB5Vgm3mLkySUhY=";

          # Forward all the traffic via VPN.
          allowedIPs = [ "0.0.0.0/0" ];
          # Or forward only particular subnets
          #allowedIPs = [ "10.100.0.1" "91.108.12.0/22" ];

          # Set this to the server IP and port.
          endpoint = "159.65.251.72:443";

          # Send keepalives every 25 seconds. Important to keep NAT tables alive.
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
