'''
Title: addongit
Version: 1.0
Author: Robert Jackson (rmjackson 'at' gmail 'dot' com)
Date: 01.16.2011
Summary:
  Handles setting up my addons repo and cloning/updating to the local wow install.
'''

import os
import sys
import ConfigParser
import shutil
import tempfile
import unicodedata

wow_reg = {
            'wow_key_path': 'SOFTWARE\\Wow6432Node\\Blizzard Entertainment\\World of Warcraft',
            'key': None,
            'wow_registry_keys': 0
          }
          
app_settings = {
               'os': os.name,
               'config_name': './addongit.cfg',
               'launcher_path': None,
               'wow_base': None,
               'remote_repo': None,
               'addon_base': 'Interface/AddOns',
               'config_base_name': None,
               'launch_wow': False,
               'addon_path': None,
               'config_path': None
             }

cfg_wow_base = None
cfg_addon_base = None
cfg_launch_wow = None

def get_config_base_name():
  return raw_input('\nEnter the name of the config directory specific to your repo. \
                    \nThis identifies the repo as yours when the updater runs. \
                    \n\n(EX: .nzeer): ')
  
def get_wow_base():
  return raw_input('\nEnter the full path to your WoW directory: ')

def get_remote_repo():
  return raw_input('\nEnter the full address to the remote repo. \
                    \n\n(EX: git://github.com/nzeer/Addons.git): ')

def rebase_local_addons(addon_path):
  print 'Existing AddOns directory located.\nRebasing addons.'
  unique_path = '%s.%s' % (addon_path, os.path.basename(tempfile.mktemp()))
  shutil.move(addon_path, unique_path)
  print 'Previous directory now located at (%s).' % unique_path
  os.makedirs(addon_path)
  print 'New AddOns directory configured.\nDone.'
  
def init_git(addon_path, remote_repo, config_path):
  print 'Initializing git repo'
  os.chdir(addon_path)
  os.system('git clone %s .' % remote_repo)
  os.system('attrib +h %s' % config_path)
  print 'Done.'
  
def get_reg_handle(key_path):
  return wreg.OpenKey(wreg.HKEY_LOCAL_MACHINE, key_path)
  
def is_initial_run(config_path, addon_path, git_path):
  git_exists = os.path.exists(git_path)
  config_exists = os.path.exists(config_path)
  # Cleaner, though unorthodox, method or reading this.
  if git_exists and config_exists: return False
  return True
  
def init_wow(launcher_path):
  assert os.path.exists(launcher_path)
  print 'Launching WoW'
  os.system('start %s' % (launcher_path))

if app_settings['os'] == 'nt':
  import _winreg as wreg
  
  # Grabs the WoW install path and launcher path from the registry, and sets defaults.
  # Sets up default for addon directory.
  try:
    wow_reg['key'] = get_reg_handle(wow_reg['wow_key_path'])
    if wow_reg['key']: 
      '''tuple: ( An integer giving the number of sub keys this key has., 
          An integer giving the number of values this key has.
          A long integer giving when the key was last modified (if available) as 100's of nanoseconds since Jan 1, 1600. )
      '''
      try:
        wow_reg['wow_registry_keys'] = wreg.QueryInfoKey(wow_reg['key'])[1]
      
        if wow_reg['wow_registry_keys'] > 0:
          app_settings['wow_base'] = wreg.QueryValueEx(wow_reg['key'], 'InstallPath')[0].encode('utf-8')
          app_settings['launcher_path'] = wreg.QueryValueEx(wow_reg['key'], 'GamePath')[0].encode('utf-8')
      except Exception, err:
        print str(e)
      else:
        wow_reg['key'].Close()
  except Exception, e:
    print str(e)
elif app_settings['os'] == 'posix':
  # TODO: determine how to handle looking up OSX/linux default install paths'
  pass
else:
  pass
  
config = ConfigParser.ConfigParser()
config.optionxform = str
  
try:
  config.read(app_settings['config_name'])
  app_settings['remote_repo'] = config.get('remote', 'repo')
except Exception, e:
  print str(e)
  # Config not found or cannot be read, grabbing information the hard way.
  app_settings['remote_repo'] = get_remote_repo()
  
try:
  app_settings['config_base_name'] = config.get('local', 'config_base_name')
except Exception, e:
  print str(e)
  # Config not found or cannot be read, grabbing information the hard way.
  app_settings['config_base_name'] = get_config_base_name()

try:
  cfg_wow_base = config.get('local', 'wow_directory')
except Exception, err:
  pass
  
try:
  cfg_addon_base = config.get('local', 'addon_path')
except Exception, err:
  pass

try:
  cfg_launch_wow = config.getboolean('local', 'launch_wow')
except Exception, err:
  pass

# TODO: test if continue works here unstead of duplicate code.
app_settings['wow_base'] = cfg_wow_base if cfg_wow_base is not None else app_settings['wow_base']
app_settings['addon_base'] = cfg_addon_base if cfg_addon_base is not None else app_settings['addon_base']
app_settings['launch_wow'] = cfg_launch_wow if cfg_launch_wow is not None else app_settings['launch_wow']

# make sure our path is correctly formed with no trailing slashes incase
# we need to perform some voodoo  
app_settings['addon_path'] = os.path.normpath(os.path.join(app_settings['wow_base'], app_settings['addon_base']))
app_settings['config_path'] = os.path.join(app_settings['addon_path'], app_settings['config_base_name'])
app_settings['git_path'] = os.path.join(app_settings['addon_path'], '.git/')

# make sure there's a valid repo to talk to.
assert app_settings['remote_repo'] is not None

# is the proposed addon path valid
# if not, create it.
if not os.path.exists(app_settings['addon_path']):
  # is wow installed
  assert os.path.exists(app_settings['wow_base'])
  print 'AddOns directory not found.'
  print 'Creating'
  os.makedirs(app_settings['addon_path'])
  init_git(app_settings['addon_path'], app_settings['remote_repo'], app_settings['config_path'])

# if its not our repo rebase addons and init
if is_initial_run(app_settings['config_path'], app_settings['addon_path'], app_settings['git_path']):
  # Either the path didnt exist and we've created it
  # or it was the initial run and we've rebased previous addon collection
  rebase_local_addons(app_settings['addon_path'])
  
  # Verify that our AddOn path is where it should be before continuing.
  assert os.path.exists(app_settings['addon_path'])
  init_git(app_settings['addon_path'], app_settings['remote_repo'], app_settings['config_path'])
else:
  os.chdir(app_settings['addon_path'])
  print 'Updating addons'
  os.system('git pull')
  print 'Done.'
  
if app_settings['launch_wow']: init_wow(app_settings['launcher_path'])
sys.exit('Finished.')