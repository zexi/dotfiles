ANSIBLE_PLAYBOOK = ansible-playbook -i hosts.ini playbook.yml

ANSIBLE_PLAYBOOK_TAG = $(ANSIBLE_PLAYBOOK) -t

ANSIBLE_PLAYBOOK_TAG_T = ansible-playbook -i hosts.ini playbook.yml -t $@

tmux:
	$(ANSIBLE_PLAYBOOK_TAG_T)

vim:
	$(ANSIBLE_PLAYBOOK_TAG_T)

golang:
	$(ANSIBLE_PLAYBOOK_TAG_T)

fcitx5:
	$(ANSIBLE_PLAYBOOK_TAG_T)

wm:
	$(ANSIBLE_PLAYBOOK_TAG_T)

terminal:
	$(ANSIBLE_PLAYBOOK_TAG_T)


.PHONY: fcitx5
