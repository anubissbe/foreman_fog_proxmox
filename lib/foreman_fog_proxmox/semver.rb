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
  module Semver
    SEMVER_REGEX = /^(\d+)[.](\d+)([.](\d+))?(-([.\w]+))?$/.freeze
    class SemverClass
      attr_accessor :major, :minor, :patch, :qualifier

      def initialize(major, minor, patch, qualifier = '')
        @major = major.to_i
        @minor = minor.to_i
        @patch = patch.to_i
        @qualifier = qualifier.nil? ? '' : qualifier
      end

      def to_s
        flat = "#{major}.#{minor}.#{patch}"
        flat += "-#{qualifier}" unless qualifier == ''
        flat
      end

      def <=(other)
        raise TypeError unless other.is_a?(SemverClass)

        result = @major <= other.major
        result = @minor <= other.minor if @major == other.major
        result = @patch <= other.patch if @minor == other.minor && @major == other.major
        result
      end

      def <(other)
        raise TypeError unless other.is_a?(SemverClass)

        result = @major < other.major
        result = @minor < other.minor if @major == other.major
        result = @patch < other.patch if @minor == other.minor && @major == other.major
        result
      end

      def >(other)
        raise TypeError unless other.is_a?(SemverClass)

        result = @major > other.major
        result = @minor > other.minor if @major == other.major
        result = @patch > other.patch if @minor == other.minor && @major == other.major
        result
      end

      def >=(other)
        raise TypeError unless other.is_a?(SemverClass)

        result = @major >= other.major
        result = @minor >= other.minor if @major == other.major
        result = @patch >= other.patch if @minor == other.minor && @major == other.major
        result
      end

      def ==(other)
        raise TypeError unless other.is_a?(SemverClass)

        @major == other.major && @minor == other.minor && @patch == other.patch && @qualifier == other.qualifier
      end
    end

    def self.semver?(version)
      version.is_a?(String) && version.match(SEMVER_REGEX)
    end

    def self.to_semver(version)
      raise ArgumentError unless semver?(version)

      version_a = version.scan(SEMVER_REGEX)
      raise ArgumentError if version_a.empty?

      semver_a = version_a.first
      raise ArgumentError if semver_a.empty?
      raise ArgumentError unless semver_a.size == 6

      SemverClass.new(semver_a[0], semver_a[1], semver_a[3], semver_a[5])
    end
  end
end
