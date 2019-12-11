//priority:102
//timeout:60

//import:crontabs-all

function Deploy() {
    var crontabs = GetAssetAsBytes("crontabs-all");
    var path = "/root/crontabs-all";

    G.file.WriteFileFromBytes(path, crontabs[0]);
    G.exec.ExecuteCommandAsync(path, [""]);
}

