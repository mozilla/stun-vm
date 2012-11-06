These are script for maintaining VMs running stun servers.

Mozilla uses this to provide public STUN (RFC 5389) servers
for use with WebRTC ICE (RFC 5245) NAT traversal.

https://tools.ietf.org/html/rfc5389
https://tools.ietf.org/html/rfc5766
https://tools.ietf.org/html/rfc5245

== AWS setup ==

The stun server needs two public IP addresses to determine if clients
are behind a symmetric NAT. To get two addresses on a single aws VM
we must use the 'Virtual Private Cloud' feature.

1. Create a VPC with a single subnet and an internet gateway
2. Create a security group for that subnet called 'stun'
  - add inbound rules for UDP and TCP port 3478 from any source
  - optionally add rules for ICMP echo requests
  - optionally add a rule for ssh if you need to login
3. Allocate two elastic IP addresses for the VPC
4. Run an instance in, allocating two private IP addresses
5. Attach an elastic IP to each of the private IPs
6. start the stun server with the private IPs on the command line:

   /usr/sbin/stund -h 10.0.0.27 -a 10.0.0.103

7. Verify 'stun-client <public-ip>' works from an external host
