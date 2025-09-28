# frozen_string_literal: true

require 'test_plugin_helper'

module ForemanFogProxmox
  class ProxmoxComputeSelectorsHelperTest < ActiveSupport::TestCase
    include ProxmoxComputeSelectorsHelper

    test 'container ostypes include devuan and nixos' do
      ostypes = proxmox_ostypes_map.map(&:id)
      assert_includes ostypes, 'devuan'
      assert_includes ostypes, 'nixos'
    end

    test 'operating systems include windows 11 with updated label' do
      win11 = proxmox_operating_systems_map.find { |os| os.id == 'win11' }
      assert_not_nil win11
      assert_equal 'Microsoft Windows 11/2022/2025', win11.name
    end

    test 'cpu types include new proxmox ve 9 models' do
      cpu_types = proxmox_cpus_map.map(&:id)
      %w[EPYC-Genoa EPYC-Milan-v2 EPYC-Rome-v4 GraniteRapids SapphireRapids-v2].each do |cpu|
        assert_includes cpu_types, cpu
      end
    end
  end
end
