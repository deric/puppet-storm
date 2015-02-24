require 'spec_helper'

describe 'storm::config' do

  it { should contain_file(
    '/etc/default/storm'
    ).with({
    'owner'   => 'root',
    'group'   => 'root',
    'mode'    => '0644',
    })
  }

  context 'setting storm JAR' do
    let(:params){{
      :lib        => '/var/lib/storm',
      :version    => '0.9.3',
      :jar_prefix => 'my-storm',
    }}
    it { should contain_file(
      '/etc/default/storm'
      ).with_content(/STORM_JAR=\"\/var\/lib\/storm\/my-storm-0.9.3.jar"/)
    }
  end

end