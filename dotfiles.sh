#!/bin/sh

# Check if System Integrity Protection is enabled

csrutil status &&

# Create dotfiles

touch ~/.bash_profile &&
touch ~/.profile &&
touch ~/.bashrc &&
touch ~/.aliases &&

# Modify ~/.bash_profile

cat > ~/.bash_profile <<- 'EOF'
: '
if [ -f ~/.profile ] ; then
    . ~/.profile
fi

# If the shell is interactive, source ~/.bashrc
case "$-" in *i*) if [ -r ~/.bashrc ]; then . ~/.bashrc; fi;; esac
'
EOF &&

# Modify ~/.bashrc

echo 'source ~/.aliases' > ~/.bashrc &&

# Modify ~/.aliases

nano ~/.aliases

: 'replace contents of .aliases with shortcuts for frequently used terminal commands'

# Create and modify files for Z shell integration

touch ~/.zprofile &&
echo '[[ -e ~/.profile ]] && emulate sh -c "source ~/.profile"' > ~/.zprofile &&

# Modify ~/.zshrc

echo 'source ~/.aliases' > ~/.zshrc &&

# Install Xcode Command Line Tools (for GCC which is a Homebrew pre-requisite)

sudo xcodebuild -license accept &&
xcode-select --install

# Install Homebrew

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Modify PATH variable to prioritize Homebrew

echo export PATH='/usr/local/bin:$PATH' >> ~/.profile

# Test PATH variable modification
# Should look like /usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

source ~/.profile
echo $PATH

# Install Ruby

brew install rbenv ruby-build

# Modify ~/.profile to prioritize rbenv

echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.profile
source ~/.profile

# Test rbenv install

type rbenv

# Complete Ruby Installation (latest version)

LATEST_RUBY_VERSION=$(rbenv install -l | grep -v - | tail -1)
rbenv install $LATEST_RUBY_VERSION
rbenv global $LATEST_RUBY_VERSION

# Test Ruby Installation

ruby -v
gem -v

# Disable local download for documentation of each gem

echo 'gem: --no-document' > ~/.gemrc

# Install Jekyll and Bundler

gem install jekyll bundler

# Rehash Ruby (necessary after installing bundler)

rbenv rehash

# Install Python (via miniconda)



