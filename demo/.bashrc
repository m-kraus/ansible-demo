# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
alias ll='ls -l --color=none'
alias tree='tree -L 2'

alias ansible_nagios='ANSIBLE_CONFIG=~/.ansible_nagios.cfg ansible-playbook'
