SETTING_FILE=~/Library/Application\ Support/Code/User/settings.json
KEYBINDINGS_FILE=~/Library/Application\ Support/Code/User/keybindings.json
VIMRC_FILE=~/.vsvimrc

CUR_DIR=$(shell pwd)

link:
	@mkdir -p ~/Library/Application\ Support/Code/User
	ln -sf $(CUR_DIR)/settings.json $(SETTING_FILE)
	ln -sf $(CUR_DIR)/keybindings.json $(KEYBINDINGS_FILE)
	ln -sf $(CUR_DIR)/vsvimrc $(VIMRC_FILE)

clean:
	-unlink $(SETTING_FILE) 2>/dev/null || true
	-unlink $(KEYBINDINGS_FILE) 2>/dev/null || true
	-unlink $(VIMRC_FILE) 2>/dev/null || true
