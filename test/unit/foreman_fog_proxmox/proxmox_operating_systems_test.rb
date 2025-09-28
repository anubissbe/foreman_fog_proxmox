# frozen_string_literal: true

require 'test_plugin_helper'

module ForemanFogProxmox
  class ProxmoxOperatingSystemsTest < ActiveSupport::TestCase
    include ForemanFogProxmox::ProxmoxOperatingSystems

    test 'exposes proxmox ve 9 linux ostypes' do
      expected = %w[l24 l26 debian ubuntu centos fedora opensuse archlinux gentoo alpine devuan nixos]
      assert_equal expected, available_linux_operating_systems
    end

    test 'exposes proxmox ve 9 windows ostypes' do
      expected = %w[wxp w2k w2k3 w2k8 wvista win7 win8 win10 win11]
      assert_equal expected, available_windows_operating_systems
    end
  end
end
