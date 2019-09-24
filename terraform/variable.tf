# variable.tf
variable "resource_group_name" {
  default = "hardening"
}

# Version No
variable "current_version" {
  default = "0.1"
}

variable "BuildBy" {
  default = "Azure-Terraform"
}

variable "location" {
  #  default = "southeastasia"
  default = "japaneast"
}

# You have to make two ssh-key
#ssh-keygen -q -f red_rsa -t rsa -N ""
#ssh-keygen -q -f blue_rsa -t rsa -N ""
variable "ssh-staff-sec-key" {
  default = "~/.ssh/red_rsa"
}
variable "ssh-staff-pub-key" {
  default = "~/.ssh/red_rsa.pub"
}
variable "ssh-team-sec-key" {
  default = "~/.ssh/blue_rsa"
}
variable "ssh-team-pub-key" {
  default = "~/.ssh/blue_rsa.pub"
}

#private-network prefix
variable "network-prefix-name" {
  default = "hardening"
}

#private-network prefix
variable "network-prefix-ip" {
  #TODO 
  default = "10.0."
}

#staff-ip-3octet (with dot)
variable "staff-ip-3octet" {
  default = "200."
}

#team-ip-3octet-base(without dot,because I need to add the number of teams. )
variable "team-ip-3octet" {
  default = "100"
}

# You shuld change the team count if you can.(default one)
variable "team-count" {
  default = "1"
}

# team name list (Max 26 team)
variable "team-name" {
  default = {
    "1"  = "a"
    "2"  = "b"
    "3"  = "c"
    "4"  = "d"
    "5"  = "e"
    "6"  = "f"
    "7"  = "g"
    "8"  = "h"
    "9"  = "i"
    "10" = "j"
    "11" = "k"
    "12" = "l"
    "13" = "m"
    "14" = "n"
    "15" = "o"
    "16" = "p"
    "17" = "q"
    "18" = "r"
    "19" = "s"
    "20" = "t"
    "21" = "u"
    "22" = "v"
    "23" = "w"
    "24" = "x"
    "25" = "y"
    "26" = "z"
  }
}

# Windows administrator password 
variable "password" {
  type = "map"
  default = {
    default  = "p@ssword1!"
    centos   = "p@ssword1!"
    ubuntu   = "p@ssword1!"
    kali     = "p@ssword1!"
    windows  = "p@ssword1!"
    windows7 = "p@ssword7!"
  }
}

variable "default_user" {
  type = "map"
  default = {
    default = "centos"
    centos  = "centos"
    ubuntu  = "ubuntu"
    kali    = "kali"
    win1    = "hardening01"
    win2    = "hardening02"
  }
}

# azure virtual machine size
variable "vm_size" {
  type = "map"

  default = {
    vm_4GB = "Standard_DS1_v2"
    vm_7GB = "Standard_DS2_v2"
  }
}

# azure standard os list
variable "standard_os" {
  default = {
    "UbuntuServer"        = "Canonical,UbuntuServer,16.04-LTS"
    "UbuntuServer14"      = "Canonical,UbuntuServer,14.04.1-LTS"
    "WindowsServer"       = "MicrosoftWindowsServer,WindowsServer,2016-Datacenter"
    "WindowsServer2008r2" = "MicrosoftWindowsServer,WindowsServer,2008-R2-SP1"
    "Win7"                = "microsoftvisualstudio,Windows,Win7-SP1-Ent-N-x64"
    "Win10"               = "microsoftvisualstudio,Windows,Windows-10-N-x64"
    "RHEL"                = "RedHat,RHEL,7.3"
    "openSUSE-Leap"       = "SUSE,openSUSE-Leap,42.2"
    "CentOS"              = "OpenLogic,CentOS,7.5"
    "Debian"              = "credativ,Debian,8"
    "CoreOS"              = "CoreOS,CoreOS,Stable"
    "SLES"                = "SUSE,SLES,12-SP2"
    "Kali"                = "kali-linux,kali-linux,kali"
  }
}
