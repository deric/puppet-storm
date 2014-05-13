require 'spec_helper'

describe 'storm::nimbus' do

  it { should compile.with_all_deps }

  it { should contain_package('storm') }

  it { should contain_service('storm-nimbus') }

end