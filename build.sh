#!/bin/bash

printHelp () {
  printf "build.sh [OPTIONS]\n"
  printf "\nOptions:\n"
  printf "\n  -g, --git                  Setup git global configuration must specify next two options to work"
  printf "\n      --git-email string     email for git config"
  printf "\n      --git-username string  username for git config"
  printf "\n      --do-not-install       do not install applications, may cause script to brake"
  printf "\n      --do-not-build         will not build .zshrc"
  printf "\n      --do-not-set-ssh       will not configure ssh to copy vimrc arround"
  printf "\033[0m\n"
}

macOrLinux () {
  name=$(uname -s)
  if [[ ${name} == "Darwin" ]]; then
    printf "\033[1;32m----Mac"
    return 0
  else
    printf "\033[1;32m----Linux"
    return 1
  fi
}

haveProg() {
    [[ -x "$(which $1)" ]]
}

linuxPackageManager () {
    
  if haveProg yum ; then
    printf "\nuse yum\n"
    return 0
  elif haveProg apt ; then
    printf "\nuse apt\n"
    return 1
  else
    printf "\nCant install packages\n"
    return 127;
  fi
}

verifyGitConfig () {
  if [[ $1 -eq 1 ]]; then
    if [[ $2 != "" ]]; then
      if [[ $3 != "" ]]; then
        return 1
      else
        printf "\n\n\033[0;31mIf -g/--git is specified email is required\n\n"
        printHelp
        return 2
      fi
    else
      printf "\n\n\033[0;31mIf -g/--git is specified username is required\n\n"
      printHelp
      return 2
    fi
  else
    return 0
  fi
}

setGitConfig () {
    email=$1
    name=$2
    platform=$3

    printf "\033[1;32m-- build .gitconfig\033[0m\n"

    cp ./extras/.gitconfig .
    
    if [[ ${platform} == "mac" ]]; then
      printf "\033[1;32m-- build .gitconfig\033[0m\n"
      sed -i '' -e 's/e_temp/'${email}'/g' .gitconfig
      sed -i '' -e 's/u_temp/'${name}'/g' .gitconfig
    elif [[ ${platform} == "apt" ]]; then
      printf "\033[1;32m-- build .gitconfig\033[0m\n"
      sed -i 's/e_temp/'${email}'/g' .gitconfig
      sed -i 's/u_temp/'${name}'/g' .gitconfig
    elif [[ ${platform} == "yum" ]]; then
      printf "\033[1;32m-- build .gitconfig\033[0m\n"
      sed -i 's/e_temp/'${email}'/g' .gitconfig
      sed -i 's/u_temp/'${name}'/g' .gitconfig
    fi

    printf "\033[1;32m-- move .gitconfig\033[0m\n"

    cp .gitconfig ~/.gitconfig
}

installStuff () {
  platform=$1

  printf "\033[1;32m-- install necissary tools\033[0m\n"

  printf "\033[1;32m-- Hush login message\033[0m\n"
  touch ~/.hushlogin

  if [[ ${platform} == "mac" ]]; then
    printf "\033[1;32m-- Install Homebrew\033[0m\n"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    
    printf "\033[1;32m-- Install zsh\033[0m\n"
    brew install -f zsh

    printf "\033[1;32m-- Install curl\033[0m\n"
    brew install -f curl

    printf "\033[1;32m-- Install git\033[0m\n"
    brew install -f git

    printf "\033[1;32m-- Install vim\033[0m\n"
    brew install -f vim

    printf "\033[1;32m-- Install wget\033[0m\n"
    brew install -f wget

    printf "\033[1;32m-- install z\033[0m\n"
    brew install -f z

    printf "\033[1;32m-- switch shell to zsh\033[0m\n"
    sudo chsh -s /usr/local/bin/zsh

    printf "\033[1;32m-- install o my zsh\033[0m\n"
    curl -L http://install.ohmyz.sh | sh

    printf "\033[1;32m-- install zsh syntax highlighting\033[0m\n"
    cd ~/.oh-my-zsh && git clone git://github.com/zsh-users/zsh-syntax-highlighting.git

    printf "\033[1;32m-- install powerlevel10k oh my zsh theme\033[0m\n"
    git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

    printf "\033[1;31m-- Please chage terminal fonts to a powerline font\033[0m\n"

  elif [[ ${platform} == "apt" ]]; then
    printf "\033[1;32m-- Install zsh\033[0m\n"
    sudo apt install -y zsh

    printf "\033[1;32m-- Install curl\033[0m\n"
    sudo apt install -y curl

    printf "\033[1;32m-- Install git\033[0m\n"
    sudo apt install -y git

    printf "\033[1;32m-- Install vim\033[0m\n"
    sudo apt install -y vim

    printf "\033[1;32m-- Install wget\033[0m\n"
    sudo apt install -y wget

    printf "\033[1;32m-- install z\033[0m\n"
    sudo curl https://raw.githubusercontent.com/rupa/z/master/z.sh \
          -o /etc/profile.d/z.sh

    printf "\033[1;32m-- switch shell to zsh\033[0m\n"
    sudo chsh -s /usr/bin/zsh

    printf "\033[1;32m-- install o my zsh\033[0m\n"
    curl -L http://install.ohmyz.sh | sh

    printf "\033[1;32m-- install zsh syntax highlighting\033[0m\n"
    cd ~/.oh-my-zsh && git clone git://github.com/zsh-users/zsh-syntax-highlighting.git

    printf "\033[1;32m-- install java 8 and 11\033[0m\n"
    sudo apt install -y openjdk-8-jdk
    sudo apt install -y openjdk-11-jdk

    printf "\033[1;32m-- install powerlevel10k oh my zsh theme\033[0m\n"
    git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
    chmod 755 oh-my-zsh.sh

  elif [[ ${platform} == "yum" ]]; then
    printf "\033[1;32m-- Install zsh\033[0m\n"
    sudo yum install -y zsh

    printf "\033[1;32m-- Install curl\033[0m\n"
    sudo yum install -y curl

    printf "\033[1;32m-- Install git\033[0m\n"
    sudo yum install -y git

    printf "a\033[1;32m-- Install vim\033[0m\n"
    sudo yum install -y vim

    printf "\033[1;32m-- Install wget\033[0m\n"
    sudo yum install -y wget

    printf "\033[1;32m-- install z\033[0m\n"
    sudo curl https://raw.githubusercontent.com/rupa/z/master/z.sh \
          -o /etc/profile.d/z.sh

    printf "\033[1;32m-- switch shell to zsh\033[0m\n"
    echo "/usr/bin/zsh" | sudo tee -a /etc/shells
    chsh -s /usr/bin/zsh

    printf "\033[1;32m-- install o my zsh\033[0m\n"
    curl -L http://install.ohmyz.sh | sh

    printf "\033[1;32m-- install zsh syntax highlighting\033[0m\n"
    cd ~/.oh-my-zsh && git clone git://github.com/zsh-users/zsh-syntax-highlighting.git

    printf "\033[1;32m-- install java 8 and 11\033[0m\n"
    sudo yum install -y java-1.8.0-openjdk-devel
    sudo yum install -y java-11-openjdk-devel

    printf "\033[1;32m-- install powerlevel10k oh my zsh theme\033[0m\n"
    git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
    chmod 755 oh-my-zsh.sh

  fi
}

buildZshrc () {
  platform=$1
  name=$2
  if [[ ${platform} == "mac" ]]; then
    printf "\033[1;32m-- build .zshrc\033[0m\n"
    sed -i'.backup' -e 's/user_temp/'${name}'/g' .zshrc
    sed -i '' -e 's/j11_temp/~\/term-configs\/scripts\/mac\/j11.sh/g' .zshrc
    sed -i '' -e 's/j8_temp/~\/term-configs\/scripts\/mac\/j8.sh/g' .zshrc
    sed -i '' -e 's/source_z_temp/. `brew --prefix`\/etc\/profile.d\/z.sh/g' .zshrc
  elif [[ ${platform} == "apt" ]]; then
    printf "\033[1;32m-- build .zshrc\033[0m\n"
    sed -i 's/user_temp/'${name}'/g' .zshrc
    sed -i 's/j11_temp/~\/term-configs\/scripts\/apt\/j11.sh/g' .zshrc
    sed -i 's/j8_temp/~\/term-configs\/scripts\/apt\/j8.sh/g' .zshrc
    sed -i 's/source_z_temp/. \/etc\/profile.d\/z.sh/g' .zshrc
  elif [[ ${platform} == "yum" ]]; then
    printf "\033[1;32m-- build .zshrc\033[0m\n"
    sed -i 's/user_temp/'${name}'/g' .zshrc
    sed -i 's/j11_temp/~\/term-configs\/scripts\/yum\/j11.sh/g' .zshrc
    sed -i 's/j8_temp/~\/term-configs\/scripts\/yum\/j8.sh/g' .zshrc
    sed -i 's/source_z_temp/. \/etc\/profile.d\/z.sh/g' .zshrc
  fi
}

buildSSH () {
  printf "\033[1;32m-- build ~/.ssh/config \033[0m\n"
  
  mkdir ~/.ssh

  if [[ -e "~/.ssh/config" ]]; then
    echo "$(cat ./extras/.ssh/config ~/.ssh/config)" > ~/.ssh/config
  else
    cp ./extras/.ssh/config ~/.ssh/config
  fi
}

bashName=$(whoami);
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

POSITIONAL=()
doGit=0;
gitConfig=0;
doInstall=1;
doBuild=1;
doSSH=1;
while [[ $# -gt 0 ]]
do
  key="$1"
  
  case $key in
    -g|--git)
      doGit=1
      shift
    ;;
    --git-email)
      email="$2"
      shift # past argument
      shift # past value
    ;;
    --git-username)
      username="$2"
      shift # past argument
      shift # past value
    ;;
    --do-not-install)
      doInstall=0
      shift
    ;;
    --do-not-build)
      doBuild=0
      shift
    ;;
    --do-not-set-ssh)
      doSSH=0
      shift
    ;;
    -h|--help)
      printHelp
      exit 0
    ;;
    *)    # unknown option
      POSITIONAL+=("$1") # save it in an array for later
      shift # past argument
    ;;
  esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

macOrLinux
platform=$?
pm="mac"
fontDir=""

if [[ ${platform} -eq 0 ]]; then
  fontDir="${HOME}/Library/Fonts"
elif [[ ${platform} -eq 1 ]]; then
  fontDir="${HOME}/.local/share/fonts"
  linuxPackageManager
  pm=$?
  if [[ ${pm} -eq 0 ]]; then
    pm="yum"
  elif [[ ${pm} -eq 1 ]]; then
    pm="apt"
  elif [[ ${pm} -eq 127 ]]; then
    exit 1
  fi
fi

verifyGitConfig ${doGit} ${email} ${username}
gitConfig=$?

if [[ ${gitConfig} -eq 2 ]]; then
  exit ${gitConfig}
elif [[ ${gitConfig} -eq 1 ]]; then
  setGitConfig ${email} ${username} ${platform}
fi

if [[ ${doInstall} -eq 1 ]]; then
  installStuff ${pm}
  printf "\033[1;32m-- install powerline fonts\033[0m\n"
  cp -a ./extras/fonts/. ${fontDir}/.
  if which fc-cache >/dev/null 2>&1 ; then
    echo "Resetting font cache, this may take a moment..."
    fc-cache -f "$font_dir"
  fi
fi

cd "$parent_path"
if [[ ${doBuild} -eq 1 ]]; then
  buildZshrc ${pm} ${bashName}
  yes | sudo cp -f .zshrc .vimrc .p10k.zsh ~/.
fi

if [[ ${doSSH} -eq 1 ]]; then
  buildSSH
fi

printf "\n\n\n\033[1;32m-- Please reboot for terminal changes to take effect \033[0m\n\n\n"
