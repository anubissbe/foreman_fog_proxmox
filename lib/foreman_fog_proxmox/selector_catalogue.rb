# frozen_string_literal: true

require 'json'

module ForemanFogProxmox
  module SelectorCatalogue
    Option = Struct.new(:id, :name, :family, :hidden, keyword_init: true) do
      def to_s
        id
      end

      def hidden?
        hidden
      end
    end

    class << self
      def options_for(key, include_hidden: false)
        cache_key = [key.to_sym, include_hidden]
        options_cache[cache_key] ||= build_options_for(key, include_hidden: include_hidden).freeze
      end

      def values_for(key, filters = {})
        entries = filtered_entries_for(key, filters)
        entries.map { |entry| entry[:value] }.freeze
      end

      def entries_for(key, filters = {})
        filtered_entries_for(key, filters).map(&:dup)
      end

      private

      def build_options_for(key, include_hidden:)
        entries = filtered_entries_for(key)
        entries = entries.reject { |entry| entry[:hidden] } unless include_hidden

        entries.map do |entry|
          Option.new(id: entry[:value], name: entry[:label], family: entry[:family], hidden: entry[:hidden])
        end
      end

      def filtered_entries_for(key, filters = {})
        data = raw_catalogue.fetch(key.to_sym) do
          raise ArgumentError, "Unknown selector catalogue: #{key}"
        end
        return data if filters.empty?

        data.select do |entry|
          filters.all? { |filter_key, expected| entry[filter_key.to_sym] == expected }
        end
      end

      def options_cache
        @options_cache ||= {}
      end

      def raw_catalogue
        @raw_catalogue ||= load_catalogue.freeze
      end

      def load_catalogue
        catalogue_path = ForemanFogProxmox::Engine.root.join('config', 'proxmox_selectors.json')
        JSON.parse(File.read(catalogue_path), symbolize_names: true).transform_values do |entries|
          entries.map { |entry| entry.transform_keys(&:to_sym).freeze }.freeze
        end
      end
    end
  end
end
