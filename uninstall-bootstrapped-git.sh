# Installing brew requires git, so we have a bootstrap problem if we want to
# maintain git with brew. For now we bootstrap a git installation via the
# Git OSX Installer at https://github.com/timcharper/git_osx_installer/, then
# later uninstall and re-install using brew.
#
# This script is taken verbatim from the Git OSX Installer, at version 1.9.0.
#
if [ ! -r "/usr/local/git" ]; then
  echo "Git doesn't appear to be installed via this installer.  Aborting"
  exit 1
fi
echo "This will uninstall git by removing /usr/local/git/**/*, /etc/paths.d/git, /etc/manpaths.d/git"
printf "Type 'yes' if you sure you wish to continue: "
read response
if [ "$response" == "yes" ]; then
  sudo rm -rf /usr/local/git/
  sudo rm /etc/paths.d/git
  sudo rm /etc/manpaths.d/git
  pkgutil --packages | grep GitOSX.Installer | xargs -I {} sudo pkgutil --forget {}
  echo "Uninstalled"
else
  echo "Aborted"
  exit 1
fi

exit 0
