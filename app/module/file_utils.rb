require File.expand_path('../../../app/class/send_message', __FILE__)

module FileUtils
	def FileUtils.MonitorFile(filename,topic)
		sleep_time=15
		file=File.open(filename) 
		send_pos=0
		sm=SendMessage.new(topic)
		pre_output=""
		now_output=""

		while 1 do 
			now_pos=file.stat.size
			if send_pos==0
				now_output="file[#{filename}] start!! send ALL"
				p now_output if now_output!=pre_output
				pre_output=now_output
			elsif send_pos<now_pos
				now_output="file[#{filename}] change!! send from #{send_pos}"
				p now_output if now_output!=pre_output
				pre_output=now_output
				file.seek(send_pos)
			elsif send_pos>now_pos
				#全部重新发送
				now_output="file[#{filename}] reload!! send ALL"
				p now_output if now_output!=pre_output
				pre_output=now_output
				file.seek(0)
			else
				now_output="file[#{filename}] no change!!"
				p now_output if now_output!=pre_output
				pre_output=now_output
				sleep(sleep_time)
				next
			end

			file.each  do |line| #标准输入流  
				sm.send(line.chomp)
				# p line.chomp
				send_pos=file.pos
			end

			sleep(sleep_time)
		end
	end
end