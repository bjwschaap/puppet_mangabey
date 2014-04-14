require 'spec_helper'

shared_context "centos 6.3" do
  let(:facts) {{ :kernel => 'Linux',
                 :operatingsystem => 'CentOS',
                 :operatingsystemrelease => '6.3',
                 :lsbmajdistrelease => '6',
                 :osfamily => 'RedHat',
                 :architecture => 'x86_64' }}
end
