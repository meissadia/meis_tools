module Meis::Output
  # Utilities for injecting dynamically generated content into my README files.
  class Readme
    include Meis::Files
    attr_accessor :template_path, :change_log_path, :output_file, :contents

    def initialize(args = {})
      @template_path   = args[:file]       || 'readme/template.md'
      @change_log_path = args[:change_log] || 'CHANGELOG.md'
      @output_file     = args[:out_file]   || 'README.md'
      reset
    end

    def run!
      inject
      save
    end

    # Generate and Add README Sections
    def inject
      replace!(/{{TOC}}/,  generate_toc)    # Table of Contents
      replace!(/{{CLOG}}/, generate_clog)   # Change Log
    end

    # Save README to file
    def save
      save_to_file(@output_file, @contents)
    end

    # Replace a text target
    def replace!(target, replacement)
      @contents.gsub!(target, replacement)
    end

    # Undo all text target replacements in @contents
    def reset
      @contents = read_file(@template_path) || ""
    end

    # Build a table of contents from a Markdown file
    # @param filename [String] Path to a Markdown file
    # @return [String] Table of Contents in Markdown
    def generate_toc(filename =  nil)
      filename ||= @template_path
      data = read_file(filename)
      base   = 2    # Minimum indentation depth
      indent = [0]  # Indentation Level tracker
      last   = base
      result = ''
      data.each_line do |line|
        next if line.include?('## Table of Contents')
        next unless (hash_count = count_hashes(line))

        indent.push(indent.last + 1) if hash_count > last  # Add a level
        indent.pop                   if hash_count < last  # Remove a level
        indent = [0]                 if hash_count == base # Reset
        last   = hash_count # Level check
        text   = line.delete('#').delete('+').strip
        link   = text.downcase.tr(' ', '-').delete(',')

        # Format table entry with indentation and hyperlink
        result += "\t" * indent.last + "+ [#{text}](##{link})\n"
      end
      result
    end

    # @param line [String] Search target
    # @return [Integer, nil] No. of leading '#', if 1 or more, else nil
    def count_hashes(line)
      begin
        /^\+*\s*(?<hashes>\#{#{base},})/.match(line)[:hashes].length
      rescue
        nil # when the line isn't a Heading (no leading #)
      end
    end

    # Inject Change information for latest version using CHANGELOG.md
    # (see #generate_toc)
    # @return [String] Markdown list of changes for the latest version of @filename
    def generate_clog(filename = nil,
      ver_pattern = /(Version\s(?:\d\.?)*\n(?:.\n?)*)/ )
      filename ||= @change_log_path
      data = read_file(filename)
      ver_pattern.match(data)[0] # Identify and extract the first version in @filename
    end
  end
end
