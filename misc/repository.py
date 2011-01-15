#!/usr/bin/python

class Repository:

  self._repo = None

  def __init__(self, name=None, local_base=None, remote_base=None, vcs_type=None):
    self.init_repo()
    self.set_name(name)
    self.set_local_base(local_base)
    self.set_remote_base(remote_base)
    self.set_vcs_type(vcs_type)
  
  def init_repo(self):
    self._repo = {'vcs_type':    None, 
                 'local_base':  None, 
                 'remote_base': None, 
                 'name':        None}

  def vcs_type(self):
    return self._repo['vcs_type']

  def name(self):
    return self._repo['name']

  def local_base(self):
    return self._repo['local_base']

  def remote_base(self):
    return self._repo['remote_base']

  def set_remote_base(self, remote_base):
    self._repo['remote_base'] = remote_base

  def set_local_base(self, local_base):
    self._repo['local_base'] = local_base

  def set_name(self, name):
    self._repo['name'] = name

  def set_vcs_type(self, vcs_type):
    self._repo['vcs_type'] = vcs_type

  def add_item(self, key, item):
    self._repo[key] = item

  def export(self):
    return dict(self._repo)
