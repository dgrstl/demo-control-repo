# A puppet role for installation of the chocolatey server
class role::chocolatey_server {
  include profile::baseline
  include profile::inf::chocolatey_server
}
