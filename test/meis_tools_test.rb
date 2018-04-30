require "test_helper"

class MeisToolsTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Meis::VERSION
  end

  def test_dputs
    oc = OutputClass.new
    oc.mute!               # Validate mute!
    tstr = "Ehyo!"
    refute oc.dputs(tstr)
    oc.unmute!             # Validate unmute!
    assert_equal tstr, oc.dputs(tstr)
    oc.mute!
    refute oc.dputs(tstr)
  end

  def test_pad_str
    oc = OutputClass.new
    assert_equal '     3', oc.pad_str( 3,  '  1000')
    assert_equal '3     ', oc.pad_str( 3,  '  1000', true)
    assert_equal '     3', oc.pad_str('3', '  1000')
    assert_equal '3     ', oc.pad_str('3', '  1000', true)
  end

  def test_yaml
    file1 = 'test_yaml_store.yml'
    `rm #{file1}` if File.exist?(file1)
    refute File.exist?(file1)
    sc = StorageClass.new
    today = 'humpday'
    storage = sc.open_store(file1)
    sc.store(:what_day_is_it, today , storage)
    assert_equal today, sc.restore(:what_day_is_it, storage)
    sc.store('what_day_is_tomorrow', today , storage)
    assert_equal today, sc.restore(:what_day_is_tomorrow, storage)
    `rm #{file1}` if File.exist?(file1)
  end

  def test_cli
    cc = CliClass.new("these args -r yammo --slip")
    # ::opt_val
    assert_equal 'yammo', cc.opt_val('-r', 'safe')
    assert_equal 'safe' , cc.opt_val('-y', 'safe')
  end

  def test_files
    fc = FilesClass.new
    # ::ensure_dir
    path = 'tdir/new/'
    FileUtils.rm_rf(path)
    refute Dir.exist?(path)

    fc.ensure_dir(path)
    assert Dir.exist?(path)

    FileUtils.rm_rf(path.split('/').first)

    # Should fail without root access
    path = '/tdir/new'
    refute fc.ensure_dir(path)

    # ::home_path
    assert_equal File.expand_path('~/'), fc.home_path
    assert_equal File.expand_path('~/fname.txt'), fc.home_path('fname.txt')
  end
end
