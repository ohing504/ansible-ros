#
# The .bash_profile for ROS
#

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

if [ -d "${HOME}/dotfiles/shell" ] ; then
  for f in "${HOME}"/dotfiles/shell/*.sh ; do
    source "$f"
  done
  unset f
fi
