from godot import exposed, export
from godot import *
import socket
import threading
import pyaudio

@exposed
class MusicRegion(Area2D):

	# member variables here, example:

	def _ready(self):
		print("ready")
		"""
		Called every time the node is added to the scene.
		Initialization here.
		"""
		pass

	def join_voice_chat(self):
		self.sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
		self.sock.connect(("127.0.0.1", 3333))
		chunk_size = 1024 # 512
		audio_format = pyaudio.paInt16
		channels = 1
		rate = 20000
		self.p = pyaudio.PyAudio()
		self.playing_stream = self.p.open(format=audio_format, channels=channels, rate=rate, output=True, frames_per_buffer=chunk_size)
		self.recording_stream = self.p.open(format=audio_format, channels=channels, rate=rate, input=True, frames_per_buffer=chunk_size)
##		print("Connected to Server")
		self.running = True
		self.receive_thread = threading.Thread(target=self.receive_server_data)
		self.receive_thread.start()
		self.send_thread = threading.Thread(target=self.send_data_to_server)
		self.send_thread.start()

	def stop_all(self):
		self.running = False
		self.playing_stream.close()
		self.recording_stream.close()
		
	def receive_server_data(self):
		while True:
			try:
				if not self.running:
					break
				data = self.sock.recv(1024)
				self.playing_stream.write(data)
			except:
				pass

	def send_data_to_server(self):
		while True:
			try:
				if not self.running:
					break
				data = self.recording_stream.read(1024)
				self.sock.sendall(data)
			except:
				pass
