ANSIBLE_PLAYBOOK = ansible-playbook -i hosts.ini playbook.yml -t $@

tmux:
	$(ANSIBLE_PLAYBOOK)

vim:
	$(ANSIBLE_PLAYBOOK)

golang:
	$(ANSIBLE_PLAYBOOK)

fcitx5:
	$(ANSIBLE_PLAYBOOK)

wm:
	$(ANSIBLE_PLAYBOOK)

.PHONY: fcitx5
