#!/usr/bin/python

class VersionControl:

  self._repos = None

  def __init__(self, repos=[]):
    self.init_repos()
    if len(repos) > 0:
      self.set_repos(repos)
  
  def init_repos(self):
    self._repos = []

  def set_repos(self, repos)
    if len(repos) > 0:
      if len(self._repos) > 0:
        self._repos.extend(repos)
      else:
        self._repos = repos

  def add_repo(self, repo):
    if not repo is None:
      self._repos.append(repo)
  
  def repos_count(self):
    return len(self._repos)

  def Repos(self):
    return self._repos

  def delete_repo(self, repo):
    if len(self._repo) > 0:
      self._repo.remove(repo)
