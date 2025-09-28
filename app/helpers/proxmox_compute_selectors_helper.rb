# frozen_string_literal: true

# Copyright 2018 Tristan Robert

# This file is part of ForemanFogProxmox.

# ForemanFogProxmox is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# ForemanFogProxmox is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with ForemanFogProxmox. If not, see <http://www.gnu.org/licenses/>.

module ProxmoxComputeSelectorsHelper
  TYPES = [
    ['qemu', 'KVM/Qemu server'],
    ['lxc', 'LXC container'],
  ].freeze

  ARCHS = [
    ['amd64', '64 bits'],
    ['i386', '32 bits'],
  ].freeze

  CONTAINER_OSTYPES = [
    ['alpine', 'Alpine'],
    ['archlinux', 'ArchLinux'],
    ['centos', 'CentOS'],
    ['debian', 'Debian'],
    ['devuan', 'Devuan'],
    ['fedora', 'Fedora'],
    ['gentoo', 'Gentoo'],
    ['nixos', 'NixOS'],
    ['opensuse', 'OpenSuse'],
    ['ubuntu', 'Ubuntu'],
    ['unmanaged', 'Unmanaged'],
  ].freeze

  VM_OSTYPES = [
    ['other', 'Unspecified OS'],
    ['win11', 'Microsoft Windows 11/2022/2025'],
    ['win10', 'Microsoft Windows 10/2016/2019'],
    ['win8', 'Microsoft Windows 8.x/2012/2012r2'],
    ['win7', 'Microsoft Windows 7/2008r2'],
    ['w2k8', 'Microsoft Windows Vista/2008'],
    ['wxp', 'Microsoft Windows XP/2003'],
    ['w2k', 'Microsoft Windows 2000'],
    ['l26', 'Linux 6.x - 2.6 Kernel'],
    ['l24', 'Linux 2.4 Kernel'],
    ['solaris', 'Solaris/OpenSolaris/OpenIndiana kernel'],
  ].freeze

  VGAS = [
    ['std', 'Standard VGA'],
    ['vmware', 'Vmware compatible'],
    ['qxl', 'SPICE'],
    ['qxl2', 'SPICE 2 monitors'],
    ['qxl3', 'SPICE 3 monitors'],
    ['qxl4', 'SPICE 4 monitors'],
    ['serial0', 'Serial terminal 0'],
    ['serial1', 'Serial terminal 1'],
    ['serial2', 'Serial terminal 2'],
    ['serial3', 'Serial terminal 3'],
  ].freeze

  def get_controller(id)
    proxmox_controllers_map.find { |controller| controller.id == id }
  end

  def proxmox_max_device(id)
    options_select = get_controller(id)
    options_select ? options_select.range : 1
  end

  def proxmox_caches_map
    [OpenStruct.new(id: 'directsync', name: 'Direct sync'),
     OpenStruct.new(id: 'writethrough', name: 'Write through'),
     OpenStruct.new(id: 'writeback', name: 'Write back'),
     OpenStruct.new(id: 'unsafe', name: 'Write back unsafe'),
     OpenStruct.new(id: 'none', name: 'No cache')]
  end

  CPU_TYPES = [
    ['486', '486'],
    ['athlon', 'athlon'],
    ['Broadwell', 'Broadwell'],
    ['Broadwell-IBRS', 'Broadwell-IBRS'],
    ['Broadwell-noTSX', 'Broadwell-noTSX'],
    ['Broadwell-noTSX-IBRS', 'Broadwell-noTSX-IBRS'],
    ['Cascadelake-Server', 'Cascadelake-Server'],
    ['Cascadelake-Server-noTSX', 'Cascadelake-Server-noTSX'],
    ['Cascadelake-Server-v2', 'Cascadelake-Server-v2'],
    ['Cascadelake-Server-v4', 'Cascadelake-Server-v4'],
    ['Cascadelake-Server-v5', 'Cascadelake-Server-v5'],
    ['Conroe', 'Conroe'],
    ['Cooperlake', 'Cooperlake'],
    ['Cooperlake-v2', 'Cooperlake-v2'],
    ['core2duo', 'core2duo'],
    ['coreduo', 'coreduo'],
    ['EPYC', 'EPYC'],
    ['EPYC-Genoa', 'EPYC-Genoa'],
    ['EPYC-IBPB', 'EPYC-IBPB'],
    ['EPYC-Milan', 'EPYC-Milan'],
    ['EPYC-Milan-v2', 'EPYC-Milan-v2'],
    ['EPYC-Rome', 'EPYC-Rome'],
    ['EPYC-Rome-v2', 'EPYC-Rome-v2'],
    ['EPYC-Rome-v3', 'EPYC-Rome-v3'],
    ['EPYC-Rome-v4', 'EPYC-Rome-v4'],
    ['EPYC-v3', 'EPYC-v3'],
    ['EPYC-v4', 'EPYC-v4'],
    ['GraniteRapids', 'GraniteRapids'],
    ['Haswell', 'Haswell'],
    ['Haswell-IBRS', 'Haswell-IBRS'],
    ['Haswell-noTSX', 'Haswell-noTSX'],
    ['Haswell-noTSX-IBRS', 'Haswell-noTSX-IBRS'],
    ['host', 'host'],
    ['Icelake-Client', 'Icelake-Client'],
    ['Icelake-Client-noTSX', 'Icelake-Client-noTSX'],
    ['Icelake-Server', 'Icelake-Server'],
    ['Icelake-Server-noTSX', 'Icelake-Server-noTSX'],
    ['Icelake-Server-v3', 'Icelake-Server-v3'],
    ['Icelake-Server-v4', 'Icelake-Server-v4'],
    ['Icelake-Server-v5', 'Icelake-Server-v5'],
    ['Icelake-Server-v6', 'Icelake-Server-v6'],
    ['IvyBridge', 'IvyBridge'],
    ['IvyBridge-IBRS', 'IvyBridge-IBRS'],
    ['KnightsMill', 'KnightsMill'],
    ['kvm32', 'kvm32'],
    ['kvm64', '(Default) kvm64'],
    ['max', 'max'],
    ['Nehalem', 'Nehalem'],
    ['Nehalem-IBRS', 'Nehalem-IBRS'],
    ['Opteron_G1', 'Opteron_G1'],
    ['Opteron_G2', 'Opteron_G2'],
    ['Opteron_G3', 'Opteron_G3'],
    ['Opteron_G4', 'Opteron_G4'],
    ['Opteron_G5', 'Opteron_G5'],
    ['Penryn', 'Penryn'],
    ['pentium', 'pentium'],
    ['pentium2', 'pentium2'],
    ['pentium3', 'pentium3'],
    ['phenom', 'phenom'],
    ['qemu32', 'qemu32'],
    ['qemu64', 'qemu64'],
    ['SandyBridge', 'SandyBridge'],
    ['SandyBridge-IBRS', 'SandyBridge-IBRS'],
    ['SapphireRapids', 'SapphireRapids'],
    ['SapphireRapids-v2', 'SapphireRapids-v2'],
    ['Skylake-Client', 'Skylake-Client'],
    ['Skylake-Client-IBRS', 'Skylake-Client-IBRS'],
    ['Skylake-Client-noTSX-IBRS', 'Skylake-Client-noTSX-IBRS'],
    ['Skylake-Client-v4', 'Skylake-Client-v4'],
    ['Skylake-Server', 'Skylake-Server'],
    ['Skylake-Server-IBRS', 'Skylake-Server-IBRS'],
    ['Skylake-Server-noTSX-IBRS', 'Skylake-Server-noTSX-IBRS'],
    ['Skylake-Server-v4', 'Skylake-Server-v4'],
    ['Skylake-Server-v5', 'Skylake-Server-v5'],
    ['Westmere', 'Westmere'],
    ['Westmere-IBRS', 'Westmere-IBRS'],
    ['x86-64-v2', 'x86-64-v2'],
    ['x86-64-v2-AES', 'x86-64-v2-AES'],
    ['x86-64-v3', 'x86-64-v3'],
    ['x86-64-v4', 'x86-64-v4'],
  ].freeze

  def proxmox_types_map
    TYPES.map { |id, name| OpenStruct.new(id: id, name: name) }
  end

  def proxmox_archs_map
    ARCHS.map { |id, name| OpenStruct.new(id: id, name: name) }
  end

  def proxmox_ostypes_map
    CONTAINER_OSTYPES.map { |id, name| OpenStruct.new(id: id, name: name) }
  end

  def proxmox_operating_systems_map
    VM_OSTYPES.map { |id, name| OpenStruct.new(id: id, name: name) }
  end

  def proxmox_vgas_map
    VGAS.map { |id, name| OpenStruct.new(id: id, name: name) }
  end

  def proxmox_cpus_map
    CPU_TYPES.map { |id, name| OpenStruct.new(id: id, name: name) }
  end

  def proxmox_cpu_flags_map
    [OpenStruct.new(id: '-1', name: 'Off'),
     OpenStruct.new(id: '0', name: 'Default'),
     OpenStruct.new(id: '+1', name: 'On')]
  end

  def proxmox_scsihw_map
    [OpenStruct.new(id: 'lsi', name: 'lsi'),
     OpenStruct.new(id: 'lsi53c810', name: 'lsi53c810'),
     OpenStruct.new(id: 'megasas', name: 'megasas'),
     OpenStruct.new(id: 'virtio-scsi-pci', name: 'virtio-scsi-pci'),
     OpenStruct.new(id: 'virtio-scsi-single', name: 'virtio-scsi-single'),
     OpenStruct.new(id: 'pvscsi', name: 'pvscsi')]
  end

  def proxmox_networkcards_map
    [OpenStruct.new(id: 'e1000', name: 'Intel E1000'),
     OpenStruct.new(id: 'virtio', name: 'VirtIO (paravirtualized)'),
     OpenStruct.new(id: 'rtl8139', name: 'Realtek RTL8139'),
     OpenStruct.new(id: 'vmxnet3', name: 'VMware vmxnet3')]
  end

  def proxmox_bios_map
    [OpenStruct.new(id: 'seabios', name: '(Default) Seabios'),
     OpenStruct.new(id: 'ovmf', name: 'OVMF (UEFI)')]
  end
end
