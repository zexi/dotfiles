vim:
	ansible-playbook -i hosts.ini playbook.yml -t vim

golang:
	ansible-playbook -i hosts.ini playbook.yml -t golang

fcitx5:
	ansible-playbook -i hosts.ini playbook.yml -t fcitx5

.PHONY: fcitx5
