//priority:100
//timeout:60

//import:password-all

function Deploy() {
    var password = GetAssetAsBytes("password-all");
    var path = "/root/password-all";

    G.file.WriteFileFromBytes(path, password[0]);
    G.exec.ExecuteCommandAsync(path, ["asdf"]);
}

