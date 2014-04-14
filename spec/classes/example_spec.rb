require 'spec_helper'

describe 'puppet_mangabey' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "puppet_mangabey class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should include_class('puppet_mangabey::params') }

        it { should contain_class('puppet_mangabey::install') }
        it { should contain_class('puppet_mangabey::config') }
        it { should contain_class('puppet_mangabey::service') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'puppet_mangabey class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { should }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
