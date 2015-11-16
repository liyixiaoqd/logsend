require File.expand_path('../../../app/module/file_utils', __FILE__)

if ARGV.length<2
	p "please input logfile and topic!!"
	exit
end

filename=ARGV[0]
topic=ARGV[1]
p "start monitor file[#{filename} and send to [#{topic}]"

FileUtils.MonitorFile(filename,topic)