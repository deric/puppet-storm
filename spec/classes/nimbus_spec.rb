require 'spec_helper'

describe 'storm::nimbus' do

  it { should compile.with_all_deps }
  it { should contain_class('storm::nimbus') }
  it { should contain_package('storm') }
  # by default service is not installed
  it { should_not contain_service('storm-nimbus') }

  it { should contain_concat__fragment(
    'nimbus'
    ).with_content(/nimbus.host: "localhost"/)
  }

  context 'manage service' do
    let(:params){{
      :manage_service => true
    }}

    it { should contain_storm__service('nimbus')}
    it { should contain_service('storm-nimbus').with({
      :enable     => true,
      :hasstatus  => true,
      :ensure     => 'running'
    }) }
  end

end