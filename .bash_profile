MAVEN_HOME=/usr/share/apache-maven" >> .bash_profile
echo "PATH=$MAVEN_HOME/bin:$PATH" >> .bash_profile

# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/bin

export PATH
MAVEN_HOME=/usr/share/apache-maven
PATH=/usr/share/apache-maven/bin:/sbin:/bin:/usr/sbin:/usr/bin
