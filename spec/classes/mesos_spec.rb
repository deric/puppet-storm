require 'spec_helper'

describe 'storm::mesos' do

  let(:params) {{
    :master_url => 'zk://localhost:2181',
  }}

  it { should compile.with_all_deps }
  it { should contain_class('storm::mesos') }
  it { should contain_service('storm-mesos') }


  it { should contain_service('storm-mesos').with({
      :enable     => false,
      :hasstatus  => true,
  })}

  it { should contain_concat__fragment(
    'mesos'
    ).with_content(/mesos.master.url: "zk:\/\/localhost:2181"/)
  }

  context 'change executor uri' do
    let(:params){{
      :master_url => 'zk://localhost:2181',
      :executor_uri => '/tmp/storm.zip'
    }}

    it { should contain_concat__fragment(
      'mesos'
      ).with_content(/mesos.executor.uri: "\/tmp\/storm.zip"/)
    }
  end

  context 'enable service' do
    let(:params){{
      :master_url => 'zk://localhost:2181',
      :enable     => true,
    }}

    it { should contain_service(
      'storm-mesos'
      ).with({
      :enable     => true,
      :hasstatus  => true,
    })}
  end
end