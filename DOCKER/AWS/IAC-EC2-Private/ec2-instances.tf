# ---------------------------------------------------------------------------------------------------------------------
# CREATE ALL INSTANCES FOR MANAGERS, DTR AND WORKERS
# ---------------------------------------------------------------------------------------------------------------------

# UCP Manager Instances:
#
resource "aws_instance" "ucp_manager_linux" {
  count = "${var.linux_ucp_manager_count}"

  ami                  = "${var.ami}"
  instance_type        = "${var.linux_manager_instance_type}"
  key_name             = "${var.key_name}"

  associate_public_ip_address = "${var.scheme_ec2}"

  iam_instance_profile = "${aws_iam_instance_profile.dtr_instance_profile.id}"
  subnet_id            = "${element(aws_subnet.SubnetSwarm.*.id, count.index)}"
  ebs_optimized = "${var.ebs_optimized}"

  root_block_device {
    volume_type = "gp2"
    volume_size = "${var.linux_manager_volume_system_size}"
    delete_on_termination = "${var.delete_root_ebs}"
  }
  ebs_block_device {
    device_name = "/dev/xvdf"
    volume_type = "gp2"
    volume_size = "${var.linux_manager_volume_data_size}"
    delete_on_termination = "${var.delete_data_ebs}"
  }
  user_data = "${file("${var.bootstrap_path}")}"

  vpc_security_group_ids = ["${aws_security_group.ddc.id}"]

  tags {
    Name = "${format("%s-Manager-Linux-%s", var.deployment, "${count.index + 1}")}"
  }
}

# UCP Worker Instances:
#
# Linux Workers:
#
resource "aws_instance" "ucp_worker_linux" {
  count = "${var.linux_ucp_worker_count}"

  ami                  = "${var.ami}"
  instance_type        = "${var.linux_worker_instance_type}"
  key_name             = "${var.key_name}"

  associate_public_ip_address = "${var.scheme_ec2}"

  iam_instance_profile = "${aws_iam_instance_profile.dtr_instance_profile.id}"
  subnet_id            = "${element(aws_subnet.SubnetSwarm.*.id, count.index)}"
  ebs_optimized = "${var.ebs_optimized}"

  root_block_device {
    volume_type = "gp2"
    volume_size = "${var.linux_worker_volume_system_size}"
    delete_on_termination = "${var.delete_root_ebs}"
  }
  ebs_block_device {
    device_name = "/dev/xvdf"
    volume_type = "gp2"
    volume_size = "${var.linux_worker_volume_data_size}"
    delete_on_termination = "${var.delete_data_ebs}"
  }
  user_data = "${file("${var.bootstrap_path}")}"

  vpc_security_group_ids = ["${aws_security_group.ddc.id}"]

  tags {
    Name = "${format("%s-Worker-Linux-%s", var.deployment, "${count.index + 1}")}"
  }
}

# Windows Workers:
#
resource "aws_instance" "ucp_worker_windows" {
  count = "${var.windows_ucp_worker_count}"

  ami                  = "${var.ami}"
  instance_type        = "${var.windows_worker_instance_type}"
  key_name             = "${var.key_name}"

  associate_public_ip_address = "${var.scheme_ec2}"

  iam_instance_profile = "${aws_iam_instance_profile.dtr_instance_profile.id}"
  subnet_id            = "${element(aws_subnet.SubnetSwarm.*.id, count.index)}"
  ebs_optimized = "${var.ebs_optimized}"

  root_block_device {
    volume_type = "gp2"
    volume_size = "${var.windows_worker_volume_system_size}"
    delete_on_termination = "${var.delete_root_ebs}"
  }
  ebs_block_device {
    device_name = "/dev/xvdf"
    volume_type = "gp2"
    volume_size = "${var.windows_worker_volume_data_size}"
    delete_on_termination = "${var.delete_data_ebs}"
  }

  vpc_security_group_ids = ["${aws_security_group.ddc.id}"]

  tags {
    Name = "${format("%s-Worker-Windows-%s", var.deployment, "${count.index + 1}")}"
  }
  get_password_data = "true"
  connection {
    type     = "winrm"
    user     = "${var.windows_user}"
    password = "${rsadecrypt(self.password_data, file(var.private_key_path))}"
    timeout  = "15m"
  }
  provisioner "file" {
    source      = "setup-windows.ps1"
    destination = "C:/WINDOWS/TEMP/setup-windows.ps1"
  }
  provisioner "remote-exec" {
    inline = ["powershell C:/WINDOWS/TEMP/setup-windows.ps1"]
  }
  user_data = <<EOF
<powershell>
  $VerbosePreference="Continue"
  winrm quickconfig -q
  winrm set winrm/config/service/Auth '@{Basic="true"}'
  winrm set winrm/config/client/auth '@{Basic="true"}'
  winrm set winrm/config/service '@{AllowUnencrypted="true"}'
  winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="1024"}'

  # Configure firewall to allow WinRM. Terraform will be able to connect after this (so do it last).
  netsh advfirewall firewall add rule name="WinRM in" protocol=TCP dir=in profile=any localport=5985 remoteip=any localip=any action=allow
  $ansibleConfigurationScript = ((New-Object System.Net.Webclient).DownloadString('https://download.docker.com/winrm/scripts/ConfigureRemotingForAnsible.ps1'))
  Invoke-Command -ScriptBlock ([scriptblock]::Create($ansibleConfigurationScript)) -ArgumentList $env:COMPUTERNAME, 1095, $true, $false, $true, $false, $false
</powershell>
EOF
  timeouts {
    create = "1h"
  }
}

# DTR Instances:
#
resource "aws_instance" "ucp_worker_dtr" {
  count = "${var.linux_dtr_count}"

  ami                  = "${var.ami}"
  instance_type        = "${var.linux_manager_instance_type}"
  key_name             = "${var.key_name}"

  associate_public_ip_address = "${var.scheme_ec2}"

  iam_instance_profile = "${aws_iam_instance_profile.dtr_instance_profile.id}"
  subnet_id            = "${element(aws_subnet.SubnetSwarm.*.id, count.index)}"
  ebs_optimized = "${var.ebs_optimized}"

  root_block_device {
    volume_type = "gp2"
    volume_size = "${var.linux_dtr_worker_volume_system_size}"
    delete_on_termination = "${var.delete_root_ebs}"
  }
  ebs_block_device {
    device_name = "/dev/xvdf"
    volume_type = "gp2"
    volume_size = "${var.linux_dtr_worker_volume_data_size}"
    delete_on_termination = "${var.delete_data_ebs}"
  }
  user_data = "${file("${var.bootstrap_path}")}"

  vpc_security_group_ids = ["${aws_security_group.ddc.id}"]

  # availability_zone = "${element(split(",", var.availability_zones), count.index) }"

  tags {
    Name = "${format("%s-Worker-DTR-%s", var.deployment, "${count.index + 1}")}"
  }
}
