class profile::baseline::security::linux::sudo (
  $tz = "-06:00",
  $window_wday  = { start => 'Wednesday', end => 'Thursday' },
  $window_time = { start  => '07:00', end => '12:00' },
  $window_type = 'window',
) {
  include sudo
  $rule_enforced = change_window($tz, $window_type, $window_wday, $window_time)

  group {'wheel':
    ensure => present,
  }
  sudo::conf { 'wheel':
    content => '%wheel ALL=(ALL) ALL',
  }
  if $::virtual == 'virtualbox' {
    sudo::conf { 'vagrant':
      content => 'vagrant ALL=(ALL) NOPASSWD:ALL',
    }
  }
  if $rule_enforced == 'true' {
    sudo::conf { 'add james rule':
      content => 'james ALL=(ALL) NOPASSWD:ALL',
    }
  }
}
