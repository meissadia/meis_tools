module Meis::Output
  module Text
    # Mutable debug statement printer
    #  Motivation:
    #   When tracking down a bug, being able to turn my debug print statements
    #   on/off is very helpful.  Additionally, debug printing with a different
    #   method helps during cleanup, when trying to differentiate debug code
    #   from normal program output.
    #
    # - Use the mute! and unmute! operations to control output.
    #
    # @param obj [Any] An object to be output as a string
    # @return [String] The string value printed, or nil when muted.
    def dputs(obj)
      return if @dputs_mute
      puts (res = "#{obj}")
      res
    end

    # Silence the output of ::dputs
    #
    # @param v [Boolean] Boolean to enable/disable mute.
    # @return [void] The input value.
    def mute!(v=true)
      @dputs_mute = v
    end

    # Enable output with ::dputs
    #
    # @return [void] The input value.
    def unmute!
      return mute!(false)
    end

    # Pad a string
    #
    # @param value [object] Object to be output as String
    # @param width [String, Integer] Target length
    # @param postfix [Boolean] Pad back of string?
    # @return [String] Padded string value
    # @note 1) Will use @width as the targeted length, if it's an Integer, else 2) Will match the length of @width as String, otherwise
    def pad_str(value, width = nil, postfix = false)
      width  = prep_str_width(width)
      value  = prep_str_value(value)
      return pad_str_back(value, width) if postfix
      pad_str_front(value, width)
    end

    # Pad Front of String
    # @param str [String] Input string
    # @param width [Integer] Target length of result string
    # @return [String] Front padded string
    def pad_str_front(str, width)
      (str = ' ' + str) while (str.length < width)
      str
    end

    # Pad Back of String
    # @param str [String] Input string
    # @param width [Integer] Target length of result string
    # @return [String] Back padded string
    def pad_str_back(str, width)
      (str += ' ') while (str.length < width)
      str
    end

    private

    # Preprocessor for ::pad_str(width)
    def prep_str_width(w)
      return w        if w.is_a?(Integer)
      w.to_s.length
    end

    # Preprocessor for ::pad_str(value)
    def prep_str_value(v)
      v.to_s
    end
  end
end
