<?php

/**
 * @file
 * block - Configure or disable a block.
 *
 * Copyright (C) 2010 by the original authors
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 */

/**
 * Implementation of block_drush_command().
 */
function block_drush_command() {
  $items = array();

  // the key in the $items array is the name of the command.
  $items['block-configure'] = array(
    // the name of the function implementing your command.
    'callback' => 'drush_block_configure_save',
    // a short description of your command
    'description' => "Saves single block configuration (ie move block to a region)",
    'bootstrap' => DRUSH_BOOTSTRAP_DRUPAL_FULL,
    'drupal dependencies' => array('block',),
    'options' => array(
      '--theme'  => '(optional) Which theme this block is being configured for (defaults to default site theme)',
      '--module' => 'Module that defines the block',
      '--delta'  => 'Block delta',
      '--region' => '(optional) Region where to place block ( defaults to BLOCK_REGION_NONE which means disabled )',
      '--weight' => '(optional) Block weight (defaults to 0)',
    ),
  );
  $items['block-disable'] = array(
    'description' => 'Quickly disable a single block',
    'bootstrap'   => DRUSH_BOOTSTRAP_DRUPAL_FULL,
    'drupal dependencies' => array('block', ),
    'options' => array(
      '--theme'  => '(optional) Which theme this block is being configured for (defaults to default site theme)',
      '--module' => 'Module that defines the block',
      '--delta'  => 'Block delta',
    ),
  );
  $items['block-show'] = array(
    'description' => 'Show the configuration options for one or more blocks',
    'bootstrap'   => DRUSH_BOOTSTRAP_DRUPAL_FULL,
    'drupal dependencies' => array('block', ),
    'options' => array(
      '--theme'  => '(optional) Which theme to select blocks from',
      '--module' => 'Only show blocks defined by the specified module',
      '--delta'  => 'Only show blocks with the specified delta',
      '--region' => 'Only show blocks in a particular region',
      '--configured' => 'Only show blocks that have been configured to appear in some region',
      '--disabled' => 'Only show blocks that have not been configured to appear in any region',
      '--weight' => 'Filter by weight',
    ),
  );

  return $items;
}

/**
 * Implementation of block_drush_help().
 *
 * @param
 *   A string with the help section (prepend with 'drush:')
 *
 * @return
 *   A string with the help text for your command.
 */
function block_drush_help($section) {
  switch ($section) {
    case 'drush:block-configure':
      return dt("Saves single block configuration.");
    case 'drush:block-show':
      return dt("Show all blocks.");
    case 'drush:block-disable':
      return dt("Disable a single block.");
  }
}

/**
 * Example drush command callback.
 *
 * This is where the action takes place.
 *
 * In this function, all of Drupals API is (usually) available, including
 * any functions you have added in your own modules/themes.
 *
 * To print something to the terminal window, use drush_print().
 *
 */
function drush_block_configure_save() {
  init_theme();
  global $theme_key;

  $module = drush_get_option('module', NULL);
  $delta  = drush_get_option('delta', NULL);
  $region = drush_get_option('region', BLOCK_REGION_NONE);
  $theme  = drush_get_option('theme', $theme_key);
  $weight = drush_get_option('weight', 0);
  
  if ( !isset($module) || !isset($delta) ) {
    return drush_set_error("BLOCK_MODULE_MISMATCH", "You must set module and delta");
  }

  module_load_include('inc', 'block', 'block.admin');
  $blocks = _block_rehash($theme);

  if ( !count( $blocks ) ) {
    return drush_set_error("BLOCK_NOT_FOUND", "Specified theme blocks were not found");
  }

  $form_state['values'][$module .'_'. $delta] = array(
    'region' => $region,
    'theme'  => $theme,
    'weight' => $weight,
  );

  drupal_execute('block_admin_display_form', $form_state, $blocks, $theme);

}

function drush_block_show() {
  $theme  = drush_get_option($option, $theme_key);
  
  $filters['module'] = drush_get_option('module', NULL);
  $filters['delta']  = drush_get_option('delta', NULL);
  $filters['region'] = drush_get_option('region', NULL);
  $filters['weight'] = drush_get_option('weight', NULL);
  $configured = drush_get_option('configured', FALSE);
  $disabled = drush_get_option('disabled', FALSE);

  module_load_include('inc', 'block', 'block.admin');
  $blocks = _block_rehash($theme);
  
  $table[] = array('Module', 'Delta', 'Region', 'Weight');

  foreach ($blocks as $block) {
     $include_block = TRUE;
     foreach ($filters as $key => $filter) {
       if (isset($filter)) {
         if ($block[$key] != $filter) {
	   $include_block = FALSE;
	 }
       }
       if ($configured && ($block['region'] == -1)) {
	 $include_block = FALSE;
       }
       if ($disabled && ($block['region'] != -1)) {
	 $include_block = FALSE;
       }
     }
     
     if ($include_block) {
       $table[] = array($block['module'], $block['delta'], $block['region'], $block['weight']);
     }
  }
  
  drush_print_table($table, TRUE);
}

/**
 * Implement block_disable()
 *
 * Disables single block
 */
function drush_block_disable() {
  drush_set_option('region', BLOCK_REGION_NONE);
  drush_block_configure_save();
}
