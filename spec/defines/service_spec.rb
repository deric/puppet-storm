require 'spec_helper'

describe 'storm::service' do
  let(:title) { 'nimbus' }

  context 'managed service' do
    let(:params) {{
      :manage_service => true,
    }}

    it { should contain_service('storm-nimbus').with(
      :ensure     => 'running',
      :enable     => true,
      :hasstatus  => true,
      :hasrestart => true
    )}
  end
end
