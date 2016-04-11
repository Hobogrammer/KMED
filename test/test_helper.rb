require 'simplecov'
SimpleCov.start do
  add_filter 'test/test_'
  add_filter '.jbundler'
  refuse_coverage_drop
end

require 'minitest/autorun'
require 'minitest/spec'
