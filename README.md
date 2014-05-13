# Puppet Storm
[![Build Status](https://travis-ci.org/deric/puppet-storm.svg?branch=master)](https://travis-ci.org/deric/puppet-storm)

Puppet module for managing Storm installation.

Features:

  * Hiera support
  * Mesos integration

## Requirements

  * binary package of Storm
    * [Debian/Ubuntu](https://github.com/deric/storm-deb-packaging)
  * Puppet >= 2.7

## Usage

Main storm class includes default configuration, each component is afterwards configured individually.

On master node include Nimbus:
```puppet
class {'storm::nimbus': }
```

You can adjust all the parameters directly:

```puppet
class {'storm::nimbus':
  host => '192.168.1.1'
}
```
or via Hiera:

```yaml
storm::nimbus::host: '192.168.1.1'
```

### UI

```puppet
class {'storm::ui': }
```

### Supervisor

```puppet
class {'storm::supervisor': }
```
### DRPC

```puppet
class {'storm::drpc': }
```

### Mesos

Mesos integration requires special binary package which provides `storm-mesos` service (framework).

```puppet
class {'storm::mesos': }
```

## Installation

puppet-librarian:

```ruby
mod 'deric/storm', :git => 'https://github.com/deric/puppet-storm.git'
```

dependencies:
  * `puppetlabs/stdlib`
  * `puppetlabs/concat`