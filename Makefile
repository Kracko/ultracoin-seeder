CXXFLAGS = -g0 -march=native
LDFLAGS = $(CXXFLAGS) -static-libgcc -static-libstdc++ -lboost_system -lboost_thread

dnsseed: dns.o bitcoin.o netbase.o protocol.o db.o main.o util.o
	g++ -pthread $(LDFLAGS) -o dnsseed dns.o bitcoin.o netbase.o protocol.o db.o main.o util.o -lcrypto

%.o: %.cpp bitcoin.h netbase.h protocol.h db.h serialize.h uint256.h util.h
	g++ -DUSE_IPV6 -pthread $(CXXFLAGS) -Wno-invalid-offsetof -c -o $@ $<

dns.o: dns.c
	gcc -pthread -std=c99 $(CXXFLAGS) dns.c -c -o dns.o

%.o: %.cpp

clean:
	rm -f ./*.o
	rm -f ./dnsseed

