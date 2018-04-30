module Meis::Cli
  def opt_val(opt, default = nil)
    ARGV[ARGV.find_index(opt) + 1] rescue default
  end
end
