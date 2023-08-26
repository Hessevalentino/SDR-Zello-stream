import socket
from threading import Thread
import subprocess
import pyaudio
import sys

frames = []

def udpStream():
    udp = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

    while True:
        if len(frames) > 0:
            udp.sendto(frames.pop(0), ("127.0.0.1", 9123)) #
            print("Sending audio...")
    udp.close()

def record(CHUNK):
    while True:
        data = sys.stdin.buffer.read(CHUNK)
        if not data:
            break
        frames.append(data)

if __name__ == "__main__":
    CHUNK = 1024
    FORMAT = pyaudio.paInt16 #Audio Codec
    CHANNELS = 1 #Stereo or Mono
    RATE = 48000 #Sampling Rate

    Audio = pyaudio.PyAudio()

    #Initialize Threads
    AudioThread = Thread(target=record, args=(CHUNK,))
    udpThread = Thread(target=udpStream)
    AudioThread.setDaemon(True)
    udpThread.setDaemon(True)
    AudioThread.start()
    udpThread.start()
    AudioThread.join()
    udpThread.join()
