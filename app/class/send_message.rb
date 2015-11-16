require 'poseidon'

class SendMessage
	MAX_FAIL_NUM=10

	attr_accessor :zkconn,:client_id,:topic,:kafkaconn,:failnum,:producer
	
	def initialize(zkconn="",client_id="ruby_kafka",kafkaconn=["namenode:9092"],topic)
		self.zkconn=zkconn
		self.client_id=client_id
		self.topic=topic
		self.kafkaconn=kafkaconn	#array
		self.failnum=0

		self.producer = Poseidon::Producer.new(kafkaconn, client_id)
	end


	def send(message)
		if @failnum>MAX_FAIL_NUM
			raise "repeat send fail over maxnum!!"
		end

		messages = []
		messages << Poseidon::MessageToSend.new(topic, message)
		begin
			@producer.send_messages(messages)
			@failnum=0
		rescue=>e
			p "send_message failure: #{e.message}"
			@failnum+=1
		end
	end
end