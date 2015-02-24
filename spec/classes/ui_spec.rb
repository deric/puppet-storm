require 'spec_helper'

describe 'storm::ui' do

  it { should compile.with_all_deps }
  it { should contain_class('storm::ui') }
  it { should contain_package('storm') }
  # by default service is not installed
  it { should_not contain_service('storm-ui') }

  it { should contain_concat__fragment(
    'ui'
    ).with_content(/ui.port: 8080/)
  }

  context 'change UI port' do
    let(:params){{ :port => 9090 }}

    it { should contain_concat__fragment(
      'ui'
      ).with_content(/ui.port: 9090/)
    }
  end

  context 'manage service' do
    let(:params){{
      :manage_service => true
    }}

    it { should contain_storm__service('ui')}
    it { should contain_service('storm-ui').with({
      :enable     => true,
      :hasstatus  => true,
      :ensure     => 'running'
    }) }
  end

end