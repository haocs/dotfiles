#!/usr/bin/env python

import os
import platform
from subprocess import call

# Check OS info
def get_os():
  print(platform.platform())
  x = platform.platform().lower()
  if 'ubuntu' in x:
    _os = 'ubuntu'
  elif 'darwin' in x:
    _os = 'osx'
  elif 'suse' in x:
    _os = 'suse'
  elif 'fedora' in x:
    _os = 'fedora'
  else:
    _os = None
  return _os

def pre_install(os_info):
  _path = os.path.dirname(os.path.realpath(__file__))

  if os_info == 'ubuntu' :
    # execute basic_install script.
    call(["/bin/sh", _path + "/../ubuntu/basic_install"])
    # install can config vim
    call(["/bin/sh", _path + "/../vim/auto_install"])

  if os_info == 'fedora' :
    call(["/bin/sh", _path + "/../fedora/basic_install"])
  if os_info == 'darwin' :
    #basic for osx
    call(["/bin/sh", _path + "/../osx/basic_install"])

pre_install(get_os())
