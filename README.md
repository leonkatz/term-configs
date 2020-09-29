#term-configs

Configurations for unix system settings.

## Run

to run first use the setup command below, then use the run command below that and put in your git info

### Setup

#### Linux

`cd;wget -P ~/ https://github.com/leonkatz/term-configs/archive/master.zip;unzip master.zip;rm master.zip;mv term-configs-master/ term-configs/;cd term-configs;`

#### Mac

`cd;curl -L -O https://github.com/leonkatz/term-configs/archive/master.zip;unzip master.zip;rm master.zip;mv term-configs-master/ term-configs/;cd term-configs;`

### Run

#### Standard Install
`bash build.sh --do-not-set-ssh`

#### Install with git config
`bash build.sh -g --git-email <Email for Git profile> --git-username <Username for Git profile>`

#### Git and ssh setup only
`bash build.sh -g --git-email <Email for Git profile> --git-username <Username for Git profile> --do-not-install --do-not-build`

## Platform Specific Fixes

### Raspberry-Pi Fixes

z.sh does not work on raspberry pi. To remove it you must run the following
commands after install. 

`sudo rm -f /etc/profile.d/z.sh`

`sed -i '75d' ~/.zshrc`

### Ubuntu Platform Specific fixes

Sometimes on ubuntu openjdk<C-F5> 8 does not get added as a valid alternative, If this is the case run the following command.

`sudo update-alternatives --install "/usr/bin/java" "java"
"/usr/lib/jvm/java-8-openjdk-amd64/bin/java" 1082`
