require 'spec_helper'

describe 'storm::nimbus' do

  it { should compile.with_all_deps }
  it { should contain_class('storm::nimbus') }
  it { should contain_package('storm') }
  it { should contain_service('storm-nimbus') }

  it { should contain_concat__fragment(
    'nimbus'
    ).with_content(/nimbus.host: "localhost"/)
  }

end