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

module ProxmoxComputeSelectorsHelper
  OPTION_FILTERS_WITHOUT_BLANK = %i[caches vgas].freeze

  def get_controller(id)
    proxmox_controllers_map.find { |controller| controller.id == id }
  end

  def proxmox_max_device(id)
    options_select = get_controller(id)
    options_select ? options_select.range : 1
  end

  def proxmox_types_map
    selector_options(:types)
  end

  def proxmox_archs_map
    selector_options(:archs)
  end

  def proxmox_ostypes_map
    selector_options(:container_operating_systems)
  end

  def proxmox_operating_systems_map
    selector_options(:vm_operating_systems)
  end

  def proxmox_vgas_map
    selector_options(:vgas, reject_blank: true)
  end

  def proxmox_caches_map
    selector_options(:caches, reject_blank: true)
  end

  def proxmox_cpus_map
    selector_options(:cpu_types)
  end

  def proxmox_cpu_flags_map
    selector_options(:cpu_flags)
  end

  def proxmox_scsihw_map
    selector_options(:scsi_controllers)
  end

  def proxmox_networkcards_map
    selector_options(:network_cards)
  end

  def proxmox_bios_map
    selector_options(:bios)
  end

  private

  def selector_options(key, reject_blank: OPTION_FILTERS_WITHOUT_BLANK.include?(key))
    options = ForemanFogProxmox::SelectorCatalogue.options_for(key)
    return options unless reject_blank

    options.reject { |option| option.id.blank? }
  end
end
