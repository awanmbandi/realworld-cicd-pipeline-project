# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH
MAVEN_HOME=/usr/share/apache-maven
PATH=/usr/share/apache-maven/bin:/sbin:/bin:/usr/sbin:/usr/bin
