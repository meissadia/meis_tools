$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "meis_tools"
require "minitest/autorun"

TEST_TEMPLATE = 'lib/meis_tools/classes/readme/template.md'
TEST_OUTFILE  = 'xyz_test-file.not_a_file'

class OutputClass
  include Meis::Output::Text
end

class StorageClass
  include Meis::Storage::Yaml
end

class CliClass
  def initialize(args)
    ARGV.replace args.split(' ')
  end
  include Meis::Cli
end

class FilesClass
  include Meis::Files
end
