import socket
from threading import Thread
import subprocess
import sys

if __name__ == "__main__":
    CHUNK = 1024

    udp = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    while True:
        data = sys.stdin.buffer.read(CHUNK)
        if not data:
            break
        udp.sendto(data, ("127.0.0.1", 9123))
        print("Sending audio...")
    udp.close()
