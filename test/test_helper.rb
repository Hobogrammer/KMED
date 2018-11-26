require 'simplecov'
require 'minitest/autorun'
require 'minitest/spec'

SimpleCov.start if ENV["COVERAGE"] do
  add_filter 'test/test_'
  add_filter '.jbundler'
end

