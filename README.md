#term-configs

Configurations for unix system settings.

## Run

to run first use the setup command below, then use the run command below that and put in your git info

### Setup

#### Linux

`cd;wget -P ~/ https://github.com/ColdFerrin/term-configs/archive/master.zip;unzip master.zip;rm master.zip;mv term-configs-master/ term-configs/;cd term-configs;`

#### Mac

`cd;curl -L -O https://github.com/ColdFerrin/term-configs/archive/master.zip;unzip master.zip;rm master.zip;mv term-configs-master/ term-configs/;cd term-configs;`

### Run

#### Full install
`bash build.sh -g --git-email <Email for Git profile> --git-username <Username for Git profile>`

#### No Install
`bash build.sh -g --git-email <Email for Git profile> --git-username <Userna    me for Git profile> --do-not-install --do-not-build`

### Raspberry-Pi Specifics

z.sh does not work on raspberry pi. To remove it you must run the following
commands after install. 

`sudo rm -f /etc/profile.d/z.sh`

`sed -i '75d' ~/.zshrc`

