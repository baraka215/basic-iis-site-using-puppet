	# = Class: makeiissite
# Author:Minkah Baraka baraka215@gmail.com


class makeiissite::basewebsite (
	
	    $apppool = hiera("your_apppool"),
		$appname = hiera("your_name"),
		$appdirname = hiera("your_appdirname"),
		$website = hiera("your_website"),
		$ipbinding = hiera("your_ipbinding"),
		$path = hiera("your_path"),
		$siteid = hiera("your_siteid"),
		$sitename = hiera("your_sitename"),
		$physicalpath = hiera("your_webdir"),
        $logfiledirectory = hiera("your_logdir"),
		$thumb  = hiera("your_thumb"),
		$managedpipelinemode = hiera("your_managedpipelinemode"),
		$managedruntimeversion = hiera("your_managedruntimeversion"),
		$failure_rapidfailprotection = hiera("your_rapidfailprotection"),
	
	)
		
{	
	file {'D:/BaseDirectory':
		ensure => directory,
        source_permissions=> ignore,
        	
      }
	  
	file {'D:/BaseDirectory/Websites':
		ensure => directory,
        source_permissions=> ignore,
		require => File['D:/BaseDirectory']
		      	
      }
	  
	 file {'D:/BaseDirectory/Websites/Sitename':
		ensure => directory,
        source_permissions=> ignore,
		source  => 'D:/IISCodeFromExistingWebServer',
        recurse => true,
		purge => true,
		require => File['D:/BaseDirectory/Websites']
		      	
      } 
	  
	 file {'D:/Logs':
		ensure => directory,
        source_permissions=> ignore,
        
      }
	  
	  file {'D:/Logs/Websites':
		ensure => directory,
        source_permissions=> ignore,
        require => File['D:/Logs']
      } ->
	  
	  
	    
	
	iis_apppool { $apppool: 
	  ensure => present,
   	  managedpipelinemode	=> $yourpipelinemode,
	  managedruntimeversion => $yourruntimeversion,
      failure_rapidfailprotection => $your_rapidfailprotection,
	} ->
	
	iis_site { $website: 	
	ensure => present,
    bindings  => $ipbinding,
   	id => $siteid,
   	logfile_directory => $logfiledirectory,
	serverautostart => true,
				
	} ->
	
	
	 iis_app { "$website/":,
	 ensure => present,
	 applicationpool => "$apppool",
	 
	}
	

	iis_vdir { "$website/":, 
	ensure => present,
	iis_app => "$website/", 
	physicalpath => $physicalpath,
	
	}
	
    
}