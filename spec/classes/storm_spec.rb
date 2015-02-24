require 'spec_helper'

describe 'storm' do

  it { should compile.with_all_deps }
  it { should contain_class('storm')}
  it { should contain_package('storm').with({
      'ensure' => 'present'
      })
  }

  it { should contain_file(
    '/etc/default/storm'
    ).with({
    'owner'   => 'root',
    'group'   => 'root',
    'mode'    => '0644',
    })
  }

  it { should contain_concat('/etc/storm/storm.yaml') }
  it { should contain_concat__fragment(
    'core'
    ).with_content(/storm.cluster.mode: "distributed"/)
  }

  it { should contain_concat__fragment(
    'core'
    ).with_content(/storm.zookeeper.port: 2181/)
  }

  it { should contain_concat__fragment(
    'core'
    ).with_content(/storm.local.dir: "\/usr\/lib\/storm\/storm-local"/)
  }

  context 'install latest version' do
    let(:params) {{:packages_ensure => 'latest'}}

    it { should contain_package('storm').with({
      'ensure' => 'latest'
      }) }
  end

  context 'allow installing alternative storm distribution' do
    let(:params) {{:packages => ['storm-mesos']}}

    it { should contain_package('storm-mesos').with({
      'ensure' => 'present'
      })
    }

    it { should_not contain_package('storm').with({
      'ensure' => 'present'
      })
    }
  end
end