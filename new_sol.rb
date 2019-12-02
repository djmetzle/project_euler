#!/usr/bin/ruby 

require 'scriptster'
include Scriptster

args = parse_args <<DOCOPT
Usage:
  #{File.basename __FILE__} <prob_n>

Options:
  -h, --help          Show this message.
DOCOPT

prob_n = args['<prob_n>']

log :info, "Creating new directory for '#{prob_n}'"
new_dir = cmd "mkdir -p #{prob_n}", {show_out: true, out_level: :info, expect: 0, raise: true}

log :info, "creating new problem for '#{prob_n}'"
cmd "touch #{prob_n}/solve.rb", {show_out: true, out_level: :info, expect: 0, raise: true}

log :info, "Add template to problem for '#{prob_n}'"
File.open("#{prob_n}/solve.rb", 'w') do |file|
	template = <<~EOT
		#!/usr/bin/ruby
		puts "Problem \##{prob_n}"
		
	
	EOT
	puts template
	file.write(template)
end

log :info, "Change modding problem for '#{prob_n}'"
cmd "chmod +x #{prob_n}/solve.rb", {show_out: true, out_level: :info, expect: 0, raise: true}

cmd "ls -l #{prob_n}/solve.rb", {show_out: true, out_level: :info, expect: 0, raise: true}
