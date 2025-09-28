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

require 'foreman_fog_proxmox/selector_catalogue'

module ProxmoxComputeControllersHelper
  CONTROLLER_VIRTIO = 'virtio'

  def proxmox_controllers_map
    controller_entries.map { |entry| build_controller_option(entry) }
  end

  def proxmox_controllers_cloudinit_map
    controller_entries.reject { |entry| entry[:value] == CONTROLLER_VIRTIO }
                     .map { |entry| build_controller_option(entry) }
  end

  def proxmox_scsi_controllers_map
    ForemanFogProxmox::SelectorCatalogue.options_for(:scsi_controllers)
  end

  private

  def controller_entries
    ForemanFogProxmox::SelectorCatalogue.entries_for(:controllers)
  end

  def build_controller_option(entry)
    ForemanFogProxmox::OptionsSelect.new(id: entry[:value], name: entry[:label], range: entry[:range])
  end
end
