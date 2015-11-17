require File.expand_path('../../../app/module/file_utils', __FILE__)

if ARGV.length<2
	p "please input logfile and topic!!"
	exit
end

filename=ARGV[0]
topic=ARGV[1]
seek=0
if ARGV.length>2
        seek=ARGV[2].to_i
end

p "start monitor file[#{filename} and send to [#{topic}] from size:[#{seek}]"

FileUtils.MonitorFile(filename,topic,seek)