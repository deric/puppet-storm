require 'spec_helper'

describe 'storm::supervisor' do

  it { should compile.with_all_deps }
  it { should contain_class('storm::supervisor') }
  it { should contain_package('storm') }
  it { should contain_service('storm-supervisor') }

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

end