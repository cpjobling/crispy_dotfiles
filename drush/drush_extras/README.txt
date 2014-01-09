
Drush extras
------------
Drush extras is a place where auxiliary drush commands may be found. 
Typically, these "extra" commands are not be suitable for drush core 
due to limitations; for example, some may only support certain platforms, 
and others might require customization before use.

Drush extras welcomes contributions.


Installation Instructions
-------------------------
Use with drush-4.x or later.

    $ drush dl drush_extras

This will download drush_extras and place it in your $HOME/.drush
folder.  You may also download the release manually from:

    http://drupal.org/project/drush_extras

You may place drush_extras wherever you want, but if it is not
in a standard location for drush commands, you will need to add
it to your drush include file search path.  See examples/example.drushrc.php
in the drush project for more information.


Drush extras commands
---------------------
Here is a brief overview of the commands available in drush_extras.
Please see the help text for more information.

    drush pushkey user@host.domain.com

	Creates an ssh public/private key pair in $HOME/.ssh, if
	one does not already exist, and then pushes the public
	key to the specified remote account.  The password for the
	destination account must be entered once to push the
	key over; after the key has been stored on the remote
	system, subsequent ssh and remote drush commands may be
	executed using the public/private key pair for authentication.
	
	IN DRUSH EXTRAS because is is Linux / openssl-specific.
	

    drush grep '#regex#' --content-types=node

	Grep through a site's content using PCREs.

	IN DRUSH EXTRAS because it is only applicable to small sites
	(greping through enormous databases is impractically slow).


    drush block-configure --module=block --delta=0 --region=right --wieght=10
    drush block-disable --module=block --delta=0
    drush block-show

	Configure, disable or show settings for particular blocks.
	
	IN DRUSH EXTRAS because only Drupal 6 is supported.


    drush give-node 27 bob
    drush give-comment 7 bob

	Change the ownership of a node or a comment.
	
	IN DRUSH EXTRAS because contributor deemed it to niche for drush core.


    drush sql-hash
    drush sql-compare @site1 @site2
    
    	Output hash values for each table in the database, or compare two
        Drupal sites to determine which tables have different content.  Run 
        before and after an operation on a Drupal site to track table usage.

	IN DRUSH EXTRAS because table usage often overlaps between different
        operations (e.g. variables table).
