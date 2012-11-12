module CopathParser
  class CLI
    Doc = <<DOC
Copath Parser

Usage:
  copath_parser <type> <input-file> <output-file>
  copath_parser -v | --version

Options:
  <type>  Type of data, e.g. "prostrate"
DOC

    def initialize(argv)
      require "pp"
      begin
        options = Docopt::docopt(Doc)
        puts "You passed in:"; pp options
        if options["-v"] || options["--version"]
          puts "Copath Parser #{CopathParser::VERSION}"
          exit 0
        end

        type = options["<type>"]
        case type
        when /prostrate/i
          parser = Parsers::Prostrate
        else
          raise "Invalid type."
        end

        puts "Parsing..."
        csv = parser.parse_to_csv(File.read(options["<input-file>"]))
        puts "Parsed!"
        puts "Writing csv to #{options["<output-file>"]}..."
        File.write(options["<output-file>"], csv)
        puts "Done!"
      end
    end
  end
end
