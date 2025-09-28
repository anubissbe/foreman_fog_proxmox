# frozen_string_literal: true

require 'test_plugin_helper'

module ForemanFogProxmox
  class ProxmoxComputeSelectorsHelperTest < ActiveSupport::TestCase
    include ProxmoxComputeSelectorsHelper

    test 'container ostypes mirror proxmox ve 9 api list' do
      expected = %w[alpine archlinux centos debian devuan fedora gentoo nixos opensuse ubuntu unmanaged]
      assert_equal expected, proxmox_ostypes_map.map(&:id)
    end

    test 'operating systems include updated proxmox ve 9 labels' do
      win11 = proxmox_operating_systems_map.find { |os| os.id == 'win11' }
      win8 = proxmox_operating_systems_map.find { |os| os.id == 'win8' }
      w2k8 = proxmox_operating_systems_map.find { |os| os.id == 'w2k8' }
      wxp = proxmox_operating_systems_map.find { |os| os.id == 'wxp' }
      l26 = proxmox_operating_systems_map.find { |os| os.id == 'l26' }

      assert_not_nil win11
      assert_equal 'Microsoft Windows 11/2022/2025', win11.name

      assert_not_nil win8
      assert_equal 'Microsoft Windows 8.x/2012/2012r2', win8.name

      assert_not_nil w2k8
      assert_equal 'Microsoft Windows Vista/2008', w2k8.name

      assert_not_nil wxp
      assert_equal 'Microsoft Windows XP/2003', wxp.name

      assert_not_nil l26
      assert_equal 'Linux 6.x - 2.6 Kernel', l26.name

      refute proxmox_operating_systems_map.any? { |os| os.id == 'w2k3' }
      refute proxmox_operating_systems_map.any? { |os| os.id == 'wvista' }
    end

    test 'cpu types mirror proxmox ve 9 api list' do
      expected = %w[
        486
        athlon
        Broadwell
        Broadwell-IBRS
        Broadwell-noTSX
        Broadwell-noTSX-IBRS
        Cascadelake-Server
        Cascadelake-Server-noTSX
        Cascadelake-Server-v2
        Cascadelake-Server-v4
        Cascadelake-Server-v5
        Conroe
        Cooperlake
        Cooperlake-v2
        core2duo
        coreduo
        EPYC
        EPYC-Genoa
        EPYC-IBPB
        EPYC-Milan
        EPYC-Milan-v2
        EPYC-Rome
        EPYC-Rome-v2
        EPYC-Rome-v3
        EPYC-Rome-v4
        EPYC-v3
        EPYC-v4
        GraniteRapids
        Haswell
        Haswell-IBRS
        Haswell-noTSX
        Haswell-noTSX-IBRS
        host
        Icelake-Client
        Icelake-Client-noTSX
        Icelake-Server
        Icelake-Server-noTSX
        Icelake-Server-v3
        Icelake-Server-v4
        Icelake-Server-v5
        Icelake-Server-v6
        IvyBridge
        IvyBridge-IBRS
        KnightsMill
        kvm32
        kvm64
        max
        Nehalem
        Nehalem-IBRS
        Opteron_G1
        Opteron_G2
        Opteron_G3
        Opteron_G4
        Opteron_G5
        Penryn
        pentium
        pentium2
        pentium3
        phenom
        qemu32
        qemu64
        SandyBridge
        SandyBridge-IBRS
        SapphireRapids
        SapphireRapids-v2
        Skylake-Client
        Skylake-Client-IBRS
        Skylake-Client-noTSX-IBRS
        Skylake-Client-v4
        Skylake-Server
        Skylake-Server-IBRS
        Skylake-Server-noTSX-IBRS
        Skylake-Server-v4
        Skylake-Server-v5
        Westmere
        Westmere-IBRS
        x86-64-v2
        x86-64-v2-AES
        x86-64-v3
        x86-64-v4
      ]

      assert_equal expected, proxmox_cpus_map.map(&:id)
    end
  end
end
