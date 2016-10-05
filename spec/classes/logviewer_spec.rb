require 'spec_helper'

describe 'storm::logviewer' do

  let(:facts) {{
    :operatingsystem => 'Debian',
    :osfamily => 'Debian',
    :lsbdistcodename => 'jessie',
    :majdistrelease => '8',
    :operatingsystemmajrelease => 'jessie',
  }}

  it { is_expected.to compile.with_all_deps }
  it { is_expected.to contain_class('storm::logviewer') }
  it { is_expected.to contain_package('storm') }

  it { is_expected.to contain_concat__fragment(
    'logviewer'
    ).with_content(/logviewer.port: 8000/)
  }

  context 'change logviewer port' do
    let(:params){{ :port => 9000 }}

    it { is_expected.to contain_concat__fragment(
      'logviewer'
      ).with_content(/logviewer.port: 9000/)
    }
  end

  context 'manage service' do
    let(:params){{
      :manage_service => true
    }}

    it { is_expected.to contain_storm__service('logviewer')}
    it { is_expected.to contain_service('storm-logviewer').with({
      :enable     => true,
      :hasstatus  => true,
      :ensure     => 'running'
    }) }
  end
end