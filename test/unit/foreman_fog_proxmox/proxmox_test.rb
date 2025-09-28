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

require 'test_plugin_helper'
require 'models/compute_resources/compute_resource_test_helpers'
require 'factories/foreman_fog_proxmox/proxmox_node_mock_factory'
require 'factories/foreman_fog_proxmox/proxmox_server_mock_factory'
require 'factories/foreman_fog_proxmox/proxmox_container_mock_factory'
require 'active_support/core_ext/hash/indifferent_access'

module ForemanFogProxmox
  class ProxmoxTest < ActiveSupport::TestCase
    include ComputeResourceTestHelpers
    include ProxmoxNodeMockFactory
    include ProxmoxServerMockFactory
    include ProxmoxContainerMockFactory
    include ProxmoxVMHelper

    should validate_presence_of(:url)
    should validate_presence_of(:user)
    should validate_presence_of(:password)
    should allow_value('root@pam').for(:user)
    should_not allow_value('root').for(:user)
    should_not allow_value('a').for(:url)
    should allow_values('http://foo.com', 'http://bar.com/baz').for(:url)

    test '#associated_host matches any NIC' do
      mac = 'ca:d0:e6:32:16:97'
      host = FactoryBot.create(:host, :mac => mac)
      cr = FactoryBot.build_stubbed(:proxmox_cr)
      vm = mock('vm', :mac => mac)
      assert_equal host, (as_admin { cr.associated_host(vm) })
    end

    test '#node' do
      node = mock('node')
      cr = FactoryBot.build_stubbed(:proxmox_cr)
      cr.stubs(:node).returns(node)
      assert_equal node, (as_admin { cr.node })
    end

    test 'error message falls back to exception message when no response is available' do
      cr = FactoryBot.build_stubbed(:proxmox_cr)
      socket_error = Excon::Error::Socket.new('Permission denied - connect(2) for 192.168.1.1:8006')

      message = cr.send(:error_message, socket_error)

      assert_includes message, 'Permission denied - connect(2) for 192.168.1.1:8006'
    end

    test 'error message prefers response reason phrase when available' do
      cr = FactoryBot.build_stubbed(:proxmox_cr)

      error_class = Class.new(StandardError) do
        attr_reader :response

        def initialize(reason)
          @response = Struct.new(:reason_phrase).new(reason)
        end
      end

      message = cr.send(:error_message, error_class.new('token expired'))

      assert_includes message, 'token expired'
    end

    test 'token expired check handles errors without a response' do
      cr = FactoryBot.build_stubbed(:proxmox_cr)
      socket_error = Excon::Error::Socket.new('Permission denied - connect(2) for 192.168.1.1:8006')

      refute cr.send(:token_expired?, socket_error)
    end
  end
end
