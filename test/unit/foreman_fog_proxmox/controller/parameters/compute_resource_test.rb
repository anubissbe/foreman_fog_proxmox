# frozen_string_literal: true

require 'test_plugin_helper'

module ForemanFogProxmox
  module Controller
    module Parameters
      class FilterDouble
        attr_reader :permitted_args, :permitted_kwargs

        def permit(*args, **kwargs)
          @permitted_args = args
          @permitted_kwargs = kwargs
          self
        end
      end

      class BaseController
        def self.compute_resource_params_filter
          FilterDouble.new
        end
      end

      class DummyController < BaseController
        include ForemanFogProxmox::Controller::Parameters::ComputeResource
      end
    end
  end
end

class ForemanFogProxmoxComputeResourceParametersTest < ActiveSupport::TestCase
  def test_permits_nested_proxmox_credentials
    filter = ForemanFogProxmox::Controller::Parameters::ComputeResource::DummyController.compute_resource_params_filter

    expected_keys = %i[auth_method token_id token]
    assert_equal expected_keys, filter.permitted_kwargs[:provider_params]
    assert_equal expected_keys, filter.permitted_kwargs[:attrs]
  end


  def test_permits_top_level_arguments
    filter = ForemanFogProxmox::Controller::Parameters::ComputeResource::DummyController.compute_resource_params_filter

    top_level_args = %i[ssl_verify_peer ssl_certs disable_proxy auth_method token_id token]
    top_level_args.each do |arg|
      assert_includes filter.permitted_args, arg, "Expected #{arg} to be permitted as a top-level argument"
    end
  end

end
