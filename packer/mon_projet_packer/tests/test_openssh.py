def test_openssh_is_installed(host):
    openssh = host.package("openssh-server")
    assert openssh.is_installed, "Le paquet openssh-server devrait être installé"
    
def test_sshd_config(host):
    sshd_config = host.file('/etc/ssh/sshd_config')
    assert sshd_config.exists
    assert sshd_config.contains('PermitRootLogin no')
    assert sshd_config.contains('Port 22')
