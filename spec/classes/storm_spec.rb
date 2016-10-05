require 'spec_helper'

describe 'storm' do

  it { is_expected.to compile.with_all_deps }
  it { is_expected.to contain_class('storm')}
  it { is_expected.to contain_package('storm').with({
      'ensure' => 'present'
      })
  }

  it { is_expected.to contain_file(
    '/etc/default/storm'
    ).with({
    'owner'   => 'root',
    'group'   => 'root',
    'mode'    => '0644',
    })
  }

  it { is_expected.to contain_file(
    '/etc/storm'
    ).with({
    'owner'   => 'root',
    'group'   => 'root',
    'mode'    => '0750', # TODO permissions per osfamily
    })
  }

  it { is_expected.to contain_concat('/etc/storm/storm.yaml') }
  it { is_expected.to contain_concat__fragment(
    'core'
    ).with_content(/storm.cluster.mode: "distributed"/)
  }

  it { is_expected.to contain_concat__fragment(
    'core'
    ).with_content(/storm.zookeeper.port: 2181/)
  }

  it { is_expected.to contain_concat__fragment(
    'core'
    ).with_content(/storm.local.dir: "\/usr\/lib\/storm\/storm-local"/)
  }

  context 'install latest version' do
    let(:params) {{:packages_ensure => 'latest'}}

    it { is_expected.to contain_package('storm').with({
      'ensure' => 'latest'
      }) }
  end

  context 'allow installing alternative storm distribution' do
    let(:params) {{:packages => ['storm-mesos']}}

    it { is_expected.to contain_package('storm-mesos').with({
      'ensure' => 'present'
      })
    }

    it { is_expected.not_to contain_package('storm').with({
      'ensure' => 'present'
      })
    }
  end
end