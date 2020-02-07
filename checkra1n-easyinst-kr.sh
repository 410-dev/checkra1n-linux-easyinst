#!/bin/bash
echo "Script by 410"
echo "Written in Nano."
echo "스크립트 버전: 18.02-20.2.7"
if [[ "$EUID" -ne 0 ]]; then
	echo "권한이 부족합니다. 권한 상승을 위해 비밀번호를 입력해 주세요."
	echo "비밀번호는 외부로 전송되지 않습니다."
	sudo echo "정상적으로 권한이 상승되었습니다."
else
	echo "Superuser 권한이 부여되어있습니다."
fi
echo "[1/5] 명령 아웃풋을 지정중입니다..."
OUTPUTD="$HOME/CheckRa1nEasyInstLog.txt"
touch "$OUTPUTD"
echo "[2/5] APT 저장소에 CheckRa1n 의 저장소를 추가중입니다..."
repoPresent="$(cat /etc/apt/sources.list | grep "assets.checkra.in/debian")"
if [[ -z "$repoPresent" ]]; then
	sudo sh -c 'echo "deb https://assets.checkra.in/debian /" >> /etc/apt/sources.list'
	#echo "deb https://assets.checkra.in/debian /" | sudo tee -a /etc/apt/sources.list
fi
echo "[3/5] GPG 키를 받아오는중입니다..."
sudo apt-key adv --fetch-keys https://assets.checkra.in/debian/archive.key 2>> "/dev/null"
echo "[4/5] APT 저장소 정보들을 업데이트하는 중입니다..."
sudo apt update -q=4  2>> "/dev/null"
echo "[5/5] CheckRa1n 과 의존 패키지를 내려받는 중입니다..."
sudo apt install -q=4 checkra1n -y 2>> "/dev/null"
echo "설치 과정이 완료되었습니다."

