# encoding: UTF-8

# Copyright 2011-2013 innoQ Deutschland GmbH
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

if ENV['COVERAGE'] == '1'
  require 'simplecov'
  SimpleCov.start 'rails'
end

ENV['RAILS_ENV'] ||= 'test'

unless defined?(Iqvoc) && Iqvoc.const_defined?(:Engine)
  require File.expand_path('../../config/environment', __FILE__)
end

require 'rails/test_help'

# drop after rails 4.2 support
require "#{File.dirname(__FILE__)}/ruby_2_6_rails4_2_test_monkey_patch"
