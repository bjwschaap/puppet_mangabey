require 'spec_helper'

describe 'mangabey' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "mangabey class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}
        it { should contain_anchor('mangabey::begin') }
        it { should contain_class('mangabey::params') }
        it { should contain_class('mangabey::install') }
        it { should contain_class('mangabey::config') }
        it { should contain_class('mangabey::service') }
        it { should contain_anchor('mangabey::end') }
      end
    end
  end

end
