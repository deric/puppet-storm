require 'spec_helper'

describe 'storm::drpc' do

  it { should compile.with_all_deps }
  it { should contain_class('storm::drpc') }
  it { should contain_package('storm') }
  # by default service is not installed
  it { should_not contain_service('storm-drpc') }

  it { should contain_concat__fragment(
    'drpc'
    ).with_content(/drpc.port: 3772/)
  }

  context 'change DRPC port' do
    let(:params){{ :port => 3882 }}

    it { should contain_concat__fragment(
      'drpc'
      ).with_content(/drpc.port: 3882/)
    }
  end

  context 'manage service' do
    let(:params){{
      :manage_service => true
    }}

    it { should contain_storm__service('drpc')}
    it { should contain_service('storm-drpc').with({
      :enable     => true,
      :hasstatus  => true,
      :ensure     => 'running'
    }) }
  end
end