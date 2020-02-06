#!/bin/bash
echo "Script by 410"
echo "Written in NANO"
if [[ "$EUID" -ne 0 ]]; then
	echo "권한이 부족합니다. 권한 상승을 위해 비밀번호를 입력해 주세요."
	echo "비밀번호는 외부로 전송되지 않습니다."
	sudo echo "정상적으로 권한이 상승되었습니다."
else
	echo "Superuser 권한이 부여되어있습니다."
fi
echo "라이브 이미지이시면 live 를 입력해 주세요. 아닐경우 엔터를 눌러주세요."
read isLive
if [[ "$isLive" == "live" ]]; then
	echo "라이브모드로 셋팅되었습니다."
fi
DESKT=""
if [[ "$isLive" == "live" ]]; then
	DESKT="/home/ubuntu/Desktop"
else
	echo "/home 에 있는 사용자 이름:"
	ls /home
	while [[ true ]]; do
		echo "사용자 이름을 정확하게 작성해 주세요."
		echo -n "사용자 이름: "
		read UN
		if [[ -d "/home/$UN/바탕화면" ]]; then
			DESKT="$HOME/바탕화면"
			break
		elif [[ -d "/home/$UN/바탕화면" ]]; then
			DESKT="/home/$UN/Desktop"
			break
		else
			echo "사용자가 탐지되지 않았습니다. 다시 입력해 주세요."
		fi
	done
fi
echo "[1/6] 명령 아웃풋을 지정중입니다..."
OUTPUTD="$HOME/CheckRa1nEasyInstLog.txt"
touch "$OUTPUTD"
echo "[2/6] APT 저장소에 CheckRa1n 의 저장소를 추가중입니다..."
repoPresent="$(cat /etc/apt/sources.list | grep "assets.checkra.in/debian")"
if [[ -z "$repoPresent" ]]; then
	echo "deb https://assets.checkra.in/debian /" | sudo tee -a /etc/apt/sources.list
fi
echo "[3/6] GPG 키를 받아오는중입니다..."
sudo apt-key adv --fetch-keys https://assets.checkra.in/debian/archive.key 2>> "$OUTPUTD"
echo "[4/6] APT 저장소 정보들을 업데이트하는 중입니다..."
sudo apt update 2>> "$OUTPUTD"
echo "[5/6] CheckRa1n 과 의존 패키지를 내려받는 중입니다..."
sudo apt-get install checkra1n -y 2>> "$OUTPUTD"
echo "[6/6] 바로가기를 바탕화면에 생성중입니다..."
echo "sudo checkra1n" > "$DESKT/CheckRa1n.sh"
chmod +x "$DESKT/CheckRa1n.sh"
sudo chown root:root "$DESK/CheckRa1n.sh"
echo "설치 과정이 완료되었습니다. 지금 바로 CheckRa1n을 실행하시겠습니까? (y/n)"
read booleand
if [[ "$booleand" == "Y" ]] || [[ "$booleand" == "y" ]]; then
	echo "CheckRa1n 을 실행합니다."
	clear
	sudo checkra1n
	exit $?
else
	echo "설치 도우미를 종료합니다."
	exit 0
fi
