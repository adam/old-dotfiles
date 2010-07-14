
unless self.class.const_defined? "IRB_RC_LOADED"

  require 'pp'
  require 'yaml'

  begin # ANSI Codes
    ANSI_BLACK    = "\033[0;30m"
    ANSI_GRAY     = "\033[1;30m"
    ANSI_LGRAY    = "\033[0;37m"
    ANSI_WHITE    = "\033[1;37m"
    ANSI_RED      = "\033[0;31m"
    ANSI_LRED     = "\033[1;31m"
    ANSI_GREEN    = "\033[0;32m"
    ANSI_LGREEN   = "\033[1;32m"
    ANSI_BROWN    = "\033[0;33m"
    ANSI_YELLOW   = "\033[1;33m"
    ANSI_BLUE     = "\033[0;34m"
    ANSI_LBLUE    = "\033[1;34m"
    ANSI_PURPLE   = "\033[0;35m"
    ANSI_LPURPLE  = "\033[1;35m"
    ANSI_CYAN     = "\033[0;36m"
    ANSI_LCYAN    = "\033[1;36m"

    ANSI_BACKBLACK  = "\033[40m"
    ANSI_BACKRED    = "\033[41m"
    ANSI_BACKGREEN  = "\033[42m"
    ANSI_BACKYELLOW = "\033[43m"
    ANSI_BACKBLUE   = "\033[44m"
    ANSI_BACKPURPLE = "\033[45m"
    ANSI_BACKCYAN   = "\033[46m"
    ANSI_BACKGRAY   = "\033[47m"

    ANSI_RESET      = "\033[0m"
    ANSI_BOLD       = "\033[1m"
    ANSI_UNDERSCORE = "\033[4m"
    ANSI_BLINK      = "\033[5m"
    ANSI_REVERSE    = "\033[7m"
    ANSI_CONCEALED  = "\033[8m"

    XTERM_SET_TITLE   = "\033]2;"
    XTERM_END         = "\007"
    ITERM_SET_TAB     = "\033]1;"
    ITERM_END         = "\007"
    SCREEN_SET_STATUS = "\033]0;"
    SCREEN_END        = "\007"
  end

  begin # Prompt
    if false # TODO: Detect harbor console
    else
      name = "ruby"
      #colors = ANSI_BACKGRAY + ANSI_YELLOW
      colors = ANSI_YELLOW
    end

    if IRB and IRB.conf[:PROMPT]
      IRB.conf[:PROMPT][:SD] = {
        # Normal prompt
        :PROMPT_I => "#{colors}#{name}: %m #{ANSI_RESET}\n>> ",
        # String continuation
        :PROMPT_S => "%l> ",
        # Code continuation
        :PROMPT_C => " > ",
        :PROMPT_N => " > ",
        :RETURN => "#{ANSI_BOLD}# => %s #{ANSI_RESET}\n\n",
        :AUTO_INDENT => true
      }
      IRB.conf[:PROMPT_MODE] = :SD
    end
  end

  begin # History

    IRB.conf[:SAVE_HISTORY] = 1000
    IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"

    def get_line_from_history(line_number)
      Readline::HISTORY[line_number]
    end

    def get_lines_from_history(lines = [])
      return [get_line_from_history(lines)] if lines.is_a? Fixnum

      out = []

      lines = lines.to_a if lines.is_a? Range

      lines.each do |l|
        out << Readline::HISTORY[l]
      end

      out
    end

    def history(n = 50)
      history_size = Readline::HISTORY.size

      puts "No history" and return if history_size == 0

      start_index = 0

      if history_size <= n
        n = history_size - 1
        end_index = n
      else
        end_index = history_size - 1
        start_index = end_index - n
      end

      start_index.upto(end_index) { |i| print_line_from_history i }
      nil
    end
    alias :h :history

    def history_do(lines = (Readline::HISTORY.size - 2))
      irb_eval_history lines
      nil
    end
    alias :h! :history_do

    def irb_eval_history(lines)
      to_eval = get_lines_from_history(lines)
      eval to_eval.join("\n")
      to_eval.each { |l| Readline::HISTORY << l }
    end

    def print_line_from_history(line_number, show_line_numbers = true)
      print "[%04d] " % line_number if show_line_numbers
      puts get_line_from_history(line_number)
    end

  end

  begin # Colorize results
    require 'rubygems'
    require 'wirble'
    Wirble.init
    Wirble.colorize
  rescue
  end

  begin # Tab completion
    require 'irb/completion'
  end

  begin # Utility methods

    def ls(*args)
      opt = (PLATFORM =~ /darwin/) ? '-G' : '--color=always'
      system 'ls', opt, *args
    end

    # Print methods
    def pm(obj, *options)
      methods = obj.methods
      methods -= Object.methods unless options.include? :more
      filter = options.select { |opt| opt.kind_of? Regexp }.first
      methods = methods.select { |name| name =~ filter } if filter

      data = methods.sort.collect do |name|
        method = obj.method(name)
        if method.arity == 0
          args = "()"
        elsif method.arity > 0
          n = method.arity
          args = "(#{(1..n).collect { |i| "arg#{i}"}.join(", ")})"
        elsif method.arity < 0
          n = -method.arity
          args = "(#{(1..n).collect { |i| "arg#{i}"}.join(", ")}, ...)"
        end
        klass = $1 if method.inspect =~ /Method: (.*?)#/
        [name, args, klass]
      end
      max_name = data.collect { |item| item[0].size }.max
      max_args = data.collect { |item| item[1].size }.max
      data.each do |item|
        print " #{ANSI_BOLD}#{item[0].rjust(max_name)}#{ANSI_RESET}"
        print "#{ANSI_GRAY}#{item[1].ljust(max_args)}#{ANSI_RESET}"
        print "   #{ANSI_LGRAY}#{item[2]}#{ANSI_RESET}\n"
      end
      data.size
    end

    def quick(repetitions = 100, &block)
      require 'benchmark'
      Benchmark.bmbm do |b|
        b.report { repetitions.times &block }
      end
      nil
    end

  end

  ARGV.concat [ "--readline", "--prompt-mode", "simple" ]

  IRB_RC_LOADED = true
end
