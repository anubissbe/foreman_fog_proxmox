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

module ForemanFogProxmox
  module Controller
    module Parameters
      module ComputeResource
        extend ActiveSupport::Concern

        class_methods do
          def compute_resource_params_filter
            super.tap do |filter|
              filter.permit :ssl_verify_peer,
                :ssl_certs, :disable_proxy, :auth_method, :token_id, :token,
                :provider_params => %i[ssl_verify_peer ssl_certs disable_proxy auth_method token_id token]
            end
          end

          def compute_resource_params
            super.tap do |filtered_params|
              provider_params = filtered_params.delete(:provider_params)
              next if provider_params.blank?

              provider_params = provider_params.respond_to?(:to_unsafe_h) ? provider_params.to_unsafe_h : provider_params
              proxmox_params = provider_params.each_with_object({}) do |(key, value), memo|
                symbolized_key = key.to_sym
                next unless %i[ssl_verify_peer ssl_certs disable_proxy auth_method token_id token].include?(symbolized_key)

                memo[symbolized_key] = value unless value.blank?
              end
              filtered_params.merge!(proxmox_params)
            end
          end
        end
      end
    end
  end
end
