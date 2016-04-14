node default {

	package { 'ruby':	  
	  ensure => installed,
	}
	
	package { 'ruby-devel':	  
	  ensure => installed,
	  require => Package['ruby'],
	}
		
	package { 'rubygems':	  
	  ensure => installed,
	  require => Package['ruby-devel'],
	}
	
	package { 'chronic':
		ensure   => 'installed',
		provider => 'gem',
		require => Package['rubygems'],
	}
	
	package { 'sinatra':
		ensure   => 'installed',
		provider => 'gem',
		require => Package['rubygems'],
	}
	
	package { 'activesupport':
		ensure   => '2.3.18',
		provider => 'gem',
		require => Package['rubygems'],
	}
	
	package { 'json':
		ensure   => 'installed',
		provider => 'gem',
		require => Package['rubygems'],
	}
	
	exec { 'timewebservice run':
		path      	=> '/usr/local/bin/:/bin:/usr/bin:/usr/sbin/',
		cwd 		=> '/opt/timewebservice',
		command   	=> 'ruby /opt/timewebservice/local.rb &',
		#onlyif  	=> "netstat -pnlt | grep ':80 ' | wc -l | xargs test 0 -eq", 
		require 	=> [ Package['chronic'], Package['sinatra'], Package['activesupport'], Package['json'] ],
		logoutput => 'true',
	} 
	
	#-> exec { 'timewebservice test':
	#	path      => '/usr/local/bin/:/bin:/usr/bin/:/usr/sbin',
	#	command   => '/usr/bin/wget localhost/utc -o /tmp/utc.test',
	#	logoutput => 'true',
	#	creates   => '/tmp/utc.test',
	#}
	


}