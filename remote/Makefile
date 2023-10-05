acpi-handler:
	sudo cp ./acpi/handler.sh /etc/acpi/handler.sh

toggle-service:
	sudo cp ./toggle-lid-dpms.service /etc/systemd/system
	sudo systemctl disable --now toggle-lid-dpms.service
	sudo systemctl daemon-reload
	sudo systemctl enable --now toggle-lid-dpms.service
