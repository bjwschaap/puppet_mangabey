require 'rake'
require 'rake/tasklib'
require 'find'
require 'fileutils'

class PuppetSkeleton
  class RakeTask < ::Rake::TaskLib
    def initialize(*args)
     
      kvk_git_server = 'se94alm001.k94.kvk.nl'
      repo_path = '/var/git/modules'
      
 	
      desc 'get the manifest, template files and lib files from another source module'
      
      task :clone_from_module, :path do |t, args|
        module_path = args[:path]
	dirs = [ 'manifests', 'lib' , 'files', 'templates', 'spec' ] 
	dirs.each do |d|
	   sp = File.join(module_path, d) 
	   Find.find(sp) do |path|
		from = path
		la = path.gsub(module_path, '')
		to = File.join(Dir.pwd, la)
		puts "copiing #{from} to #{to} "
	 	FileUtils.cp(from, to)	if File.ftype(from) == "file"
	 	FileUtils.mkdir(to) if File.ftype(from) == "directory" and File.exists?(to) == false
	       
	   end if File.exists? sp
	end
		
	 	  		
      end 

      desc 'create remote repo and force initial commit'

      task :create_repo do
	# ssh to kvk git repo and create the git repo
        result  = %x{#{sshCmd(kvk_git_server)} #{kvk_git_server} "sudo su - git -c \'git init #{repo_path}/#{getModuleName}.git --bare \'  "}
	puts result	
      end

      desc 'initialize the created module into the git repo'
      task :init_local do
	result = %x{/usr/bin/git init}  
	puts result
	result = %x{/usr/bin/git add .} 
	puts result
	result = %x{/usr/bin/git commit -m 'initial commit'} 
	puts result
	result = %x{/usr/bin/git remote add origin git@#{kvk_git_server}:#{repo_path}/#{getModuleName}.git} 
	puts result
	result = %x{/usr/bin/git push -u origin master}
	puts result
      end

      desc 'add a tag to the repo requires two arguments versionnr and message'

      task :add_tag, :version, :message do |t, args|
	puts "add_tag invoked with:  #{args} "
	result = %x{/usr/bin/git tag -a "v#{args[:version]}" -m "#{args[:message]}"}
	puts result
	result = %x{/usr/bin/git push origin "v#{args[:version]}"} 
	puts result	
      end      
      task :tester do
	p getModuleName
      end

      def getModuleName 
	 File.readlines('./Modulefile').select { |line| line =~ /name/ }.first.split[1].gsub(/'/,"") 
      end

      def sshCmd(node)


  	if node =~ /se94alms/
    	  "#{SSH} se94alm001 ssh -t -A -l admlim"
  	else
    	  'ssh -oUserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no  -t -A -l admlim'
  	end

       end

    end
  end
end

PuppetSkeleton::RakeTask.new
