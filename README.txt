These are script for maintaining VMs running stun servers.

Mozilla uses this to provide public STUN (RFC 5389) servers
for use with WebRTC ICE (RFC 5245) NAT traversal.

https://tools.ietf.org/html/rfc5389
https://tools.ietf.org/html/rfc5766
https://tools.ietf.org/html/rfc5245

== Build ==

Use the rpm spec file and patches to build the stun server,
and deploy it with the puppet manifest.

The RPM we build is based off the EPEL version, with the NAT
patch from here:

http://www.voip-info.org/wiki/view/Vovida.org+STUN+server

== AWS setup ==

To provision an instance with a single public IP (no vpc required):

1. yum install puppet
2. git clone <this repo>
3. puppet apply --modulepath=<repobase>/puppet/modules <repobase>/puppet/bootstrap.pp

Make sure the security group for that the instance has:
  - inbound rules for UDP and TCP port 3478 from any source
  - optionally rules for ICMP echo requests
  - optionally a rule for ssh if you need to log in

This should leave you with a fully functioning stun server. Verify with:

4. stun-client <public-ip>

You probably want to bind an elastic IP to the instance.

Logs are at /service/stun-server/log/main/current.
