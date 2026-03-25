# Makefile for Haiku Tracker Add-on
CXX = g++
CXXFLAGS = -Wall -O2
LDFLAGS = -shared
LIBS = -lbe -ltracker
TARGET = "Open Konsole"

all:
	$(CXX) $(CXXFLAGS) $(LDFLAGS) OpenKonsole.cpp -o $(TARGET) $(LIBS)

clean:
	rm -f $(TARGET)
