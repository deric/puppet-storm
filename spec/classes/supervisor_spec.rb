require 'spec_helper'

describe 'storm::supervisor' do

  it { should compile.with_all_deps }
  it { should contain_class('storm::supervisor') }
  it { should contain_package('storm') }
  # by default service is not installed
  it { should_not contain_service('storm-supervisor') }

  it { should contain_concat__fragment(
    'supervisor'
    ).with_content(/supervisor.childopts: "-Xmx1024m"/)
  }

  context 'change supervisor port' do
    let(:params){{ :start_port => 9090 }}

    it { should contain_concat__fragment(
      'supervisor'
      ).with_content(/supervisor.slots.ports:/)
    }
  end

  context 'manage service' do
    let(:params){{
      :manage_service => true
    }}

    it { should contain_storm__service('supervisor')}
    it { should contain_service('storm-supervisor').with({
      :enable     => true,
      :hasstatus  => true,
      :ensure     => 'running'
    }) }
  end

end