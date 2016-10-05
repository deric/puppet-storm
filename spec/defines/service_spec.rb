require 'spec_helper'

describe 'storm::service' do
  let(:title) { 'nimbus' }

  let(:facts) {{
    :operatingsystem => 'Debian',
    :osfamily => 'Debian',
    :lsbdistcodename => 'jessie',
    :majdistrelease => '8',
    :operatingsystemmajrelease => 'jessie',
  }}

  context 'managed service' do
    let(:params) {{
      :manage_service => true,
    }}

    it { should contain_service('storm-nimbus').with(
      :ensure     => 'running',
      :enable     => true,
      :hasstatus  => true,
      :hasrestart => true
    )
    }
  end
end
