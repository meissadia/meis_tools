require 'test_helper'

class ReadmeTest < Minitest::Test
  def test_defaults
    rm = Meis::Output::Readme.new
    # Verify default values
    assert_equal 'readme/template.md', rm.template_path
    assert_equal 'CHANGELOG.md',       rm.change_log_path
    assert_equal 'README.md',          rm.output_file
    assert rm.contents.empty?
  end

  def test_args
    # Test with args
    params = {file: '', out_file: '', change_log: ''}
    rm = Meis::Output::Readme.new(params)
    assert rm.template_path.empty?
    assert rm.change_log_path.empty?
    assert rm.output_file.empty?
  end

  def test_inject
    params = {file: TEST_TEMPLATE}
    rm = Meis::Output::Readme.new(params)

    assert rm.contents
    assert /{{TOC}}/.match(rm.contents)
    refute /I_AM_INJECTED/.match(rm.contents)

    rm.replace!(/{{TOC}}/,  "I_AM_INJECTED")

    refute /{{TOC}}/.match(rm.contents)
    assert /I_AM_INJECTED/.match(rm.contents)
  end

  def test_save
    FileUtils.rm([TEST_OUTFILE]) if File.exist?(TEST_OUTFILE)
    rm = Meis::Output::Readme.new(out_file: TEST_OUTFILE)
    rm.contents = 'frugal'
    rm.save

    assert File.exist?(TEST_OUTFILE)
    assert_equal 'frugal',  rm.read_file(TEST_OUTFILE)

    FileUtils.rm [TEST_OUTFILE] # Cleanup

  end
end
