# Path to your oh-my-zsh installation.
export ANDROID_HOME=$HOME/Android/Sdk
export ANDROID_SDK_ROOT=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

export ZSH="/home/$USER/.oh-my-zsh"
ZSH_THEME="aktheme"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# Arduino aliases
alias arduino="arduino-cli"
alias Arduino="clear ; sudo arduino-cli"
alias ino-port="arduino-cli"

ino-lib() {
	type=$1
	name=$2
	if [[ $type == "" || $name == "" ]]; then
		echo "Error: es necesario especificar la acción y el nombre de la librería"
	elif [[ $type == "search" ]]; then
		arduino lib search $name
	elif [[ $type == "uninstall" ]]; then
		arduino lib uninstall $name
	elif [[ $type == "update" ]]; then
		arduino lib update-index
	elif [[ $type == "install" ]]; then
		arduino lib install $name
	elif [[ $type == "installed" ]]; then
		arduino lib list
	elif [[ $type == "git" ]]; then
		arduino lib install --git-url $name
	else
		echo "Error: tipo no registrado"
	fi
}

ino-compile() {
	board=$1
	sketch=$2
	if [[ $board == "" || $sketch == "" ]]; then
		echo "Error: es necesario especificar la placa y el sketch"
	elif [[ $board == "esp8266" ]]; then
		arduino compile --fqbn esp8266:esp8266:nodemcuv2 $sketch
	elif [[ $board == "esp32" ]]; then
		arduino compile --fqbn esp32:esp32:esp32 $sketch
	elif [[ $board == "wrover" ]]; then
		arduino compile --fqbn esp32:esp32:esp32wrover $sketch
	elif [[ $board == "cam" ]]; then
		arduino compile --fqbn esp32:esp32:esp32cam $sketch
	elif [[ $board == "mega" ]]; then
		arduino compile --fqbn arduino:avr:mega $sketch
	elif [[ $board == "uno" ]]; then
		arduino compile --fqbn arduino:avr:uno $sketch
	elif [[ $board == "nano" ]]; then
		arduino compile --fqbn arduino:avr:nano $sketch
	elif [[ $board == "due" ]]; then
		arudino compile --fqbn arduino:sam:arduino_due_x_dbg $sketch
	elif [[ $board == "leonardo" ]]; then
		arduino compile --fqbn arduino:avr:leonardo $sketch
	elif [[ $board == "micro" ]]; then
		arduino compile --fqbn arduino:avr:micro $sketch
	elif [[ $board == "pro" ]]; then
		arduino compile --fqbn arduino:avr:pro $sketch
	else
		echo "Error: placa no registrada"
	fi
}
ino-update() {
	bord=$1
	port=$2
	sketch=$3
	if [[ $board == "" || $port == "" || $sketch == "" ]]; then
		echo "Error: es necesario especificar la placa, el puerto y el sketch"
	elif [[ $board == "esp8266" ]]; then
		arduino upload --fqbn esp8266:esp8266:nodemcuv2 -p $port $sketch
	elif [[ $board == "esp32" ]]; then
		arduino upload --fqbn esp32:esp32:esp32 -p $port $sketch
	elif [[ $board == "wrover" ]]; then
		arduino upload --fqbn esp32:esp32:esp32wrover -p $port $sketch
	elif [[ $board == "cam" ]]; then
		arduino upload --fqbn esp32:esp32:esp32cam -p $port $sketch
	elif [[ $board == "mega" ]]; then
		arduino upload --fqbn arduino:avr:mega -p $port $sketch
	elif [[ $board == "uno" ]]; then
		arduino upload --fqbn arduino:avr:uno -p $port $sketch
	elif [[ $board == "nano" ]]; then
		arduino upload --fqbn arduino:avr:nano -p $port $sketch
	elif [[ $board == "due" ]]; then
		arudino upload --fqbn arduino:sam:arduino_due_x_dbg -p $port $sketch
	elif [[ $board == "leonardo" ]]; then
		arduino upload --fqbn arduino:avr:leonardo -p $port $sketch
	elif [[ $board == "micro" ]]; then
		arduino upload --fqbn arduino:avr:micro -p $port $sketch
	elif [[ $board == "pro" ]]; then
		arduino upload --fqbn arduino:avr:pro -p $port $sketch
	else
		echo "Error: placa no registrada"
	fi
}

ino-upgrade() {
	board=$1
	port=$2
	sketch=$3
	echo "Actualizando $board en $port"
	clear ; ino-compile $board $sketch ; ino-update $board $port $sketch
}

# scripts
alias bspwm="startx"
alias desktop="kioclient exec "

# app installer
alias All="paru -Q"
alias Info="paru -Qi"
alias Install="paru -S --noconfirm"
alias Installed="paru -Q | grep"
alias Search="yay -s"
alias Uninstall="paru -R"
alias Update="paru -Syyu"
alias Purge="sudo paru -Scc"
alias Npm="sudo npm"

# apps
alias Apache-on="sudo systemctl start httpd.service"
alias Apache-off="sudo systemctl stop httpd.service"
alias Mongo-on="sudo systemctl start mongodb.service ; systemctl status mongodb.service"
alias Mongo-off="sudo systemctl stop mongodb.service"
alias Mongos="Mongo-off ; Mongo-on"
alias files="ranger"
alias Files="sudo ranger"
alias ll="exa -l"
alias ff="fastfetch | lolcat"
alias clean="clear ; ff"
alias math-run="matlab nodisplay -nosplash -nodesktop -r"
alias math-exe="matlab -r"
alias math-cli="clear ; matlab nodisplay -nosplash -nodesktop"
alias play="mpg123"
alias sci-cli="echo exec \(\'~/...\', -1\) ; scilab-cli"
alias sci-exe="scilab-cli -f"
alias virtual="VirtualBoxVM --startvm"

# editor
alias edit="nvim"
alias Edit="sudo nvim"
alias vim="nano"
alias Vim="sudo nano"

# tools
alias ccat="clear ; cat"
alias Df="df -h | grep -E 'S.|/dev/nvme|/dev/sd'"
alias disk="lsblk"
alias screens="xrandr | grep ' connected'"
alias System="sudo systemctl"
alias xev="xev | grep 'state 0x0'"
alias ttys="ls /dev/tty* | grep -E 'USB|ACM|AMA'"
alias usbs="lsusb"
alias utar="tar -xf"

# GRUB
alias Edit-grub="sudo nvim /etc/default/grub"
alias Update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"

# extras
alias logout="pkill -u"

if [ $(tty | grep /dev/tty) ];
then
	clear ; neofetch
elif [ $(pgrep alacritty | wc -l) -le 1 ];
then
	fastfetch
fi
