# frozen_string_literal: true

require 'test_plugin_helper'

module ForemanFogProxmox
  class ProxmoxOperatingSystemsTest < ActiveSupport::TestCase
    include ForemanFogProxmox::ProxmoxOperatingSystems

    test 'includes new linux ostypes' do
      assert_includes available_linux_operating_systems, 'devuan'
      assert_includes available_linux_operating_systems, 'nixos'
    end

    test 'includes windows 11 ostype' do
      assert_includes available_windows_operating_systems, 'win11'
    end
  end
end
