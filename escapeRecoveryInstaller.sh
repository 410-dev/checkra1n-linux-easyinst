#!/bin/bash
echo "Script by 410"
echo "Written in Nano."
echo "스크립트 버전: 20.27-20.2.7"
if [[ "$EUID" -ne 0 ]]; then
	echo "권한이 부족합니다. 권한 상승을 위해 비밀번호를 입력해 주세요."
	echo "비밀번호는 외부로 전송되지 않습니다."
	sudo echo "정상적으로 권한이 상승되었습니다."
else
	echo "Superuser 권한이 부여되어있습니다."
fi
echo "[1/6] APT 를 업데이트 하는중입니다..."
sudo apt update
sudo apt upgrade -y
echo "[2/6] 필요한 패키지를 설치하는중입니다.."
sudo apt install git make automake autoconf libtool pkg-config gcc libusb-1.0 -y
echo "[3/6] libirecovery 를 GitHub 에서 복사하는중입니다..."
cd /opt
sudo git clone https://github.com/libimobiledevice/libirecovery.git libirecovery
echo "[4/6] make 를 준비중입니다..."
cd libirecovery
sudo chown -R $(whoami) "$PWD"
echo "[5/6] make 를 실행중입니다..."
make
make install
echo "[6/6] 설치가 완료되었습니다."
echo "Recovery 모드에 있는 iDevice 를 연결하신 후 irecovery -n 을 입력하시면 Recovery 모드 종료 신호를 전송합니다."
