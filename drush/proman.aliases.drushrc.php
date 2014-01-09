<?php
/**
 * @file
 * Site aliases for Proman website
 */
/**
 * Local site alias (http://proman.localhost)
 */
$aliases['local'] = array(
  'root' => '/Users/eechris/dev/proman.dev/public', 
  'uri' => 'proman.localhost',
);
/**
 * Development site (http://proman.dev)
 */
$aliases['dev'] = array(
  'uri' => 'proman.dev',
  'root' => '/vagrant/public',
  'remote-user' => 'vagrant',
  'remote-host' => 'proman.dev',
);
/**
 * Production site (http://proman.swan.ac.uk)
 */
$aliases['prod'] = array(
  'uri' => 'proman.swan.ac.uk',
  'root' => '/home/proman/public_html/proman.swan.ac.uk',
  'remote-user' => 'proman',
  'remote-host' => 'eng-hope.swan.ac.uk',
);
