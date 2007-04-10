#
# Position Sever Makefile
#

CXX=/geek-gadgets/sparc-sun-solaris2.8/gcc-3.4/bin/g++

LIB=libhudson.a
BIN=eom eow jan eom_matrix jan_matrix

SRC=\
	YahooDriver.cpp \
	ReturnFactors.cpp \
	Position.cpp \
	Report.cpp \
	Execution.cpp \
	ExecutionSet.cpp \
	LongPosition.cpp \
	ShortPosition.cpp \
	PositionSet.cpp \
	Trader.cpp \
	BnHTrader.cpp 

HDR=\
	FileDriver.hpp \
	DayPrice.hpp \
	DaySeries.hpp \
	YahooDriver.hpp \
	ReturnFactors.hpp \
	Position.hpp \
	Report.hpp \
	Execution.hpp \
	ExecutionSet.hpp \
	LongPosition.hpp \
	ShortPosition.hpp \
	PositionSet.hpp \
	Trader.hpp \
	BnHTrader.hpp


LIBS=-lhudson -lboost_date_time-gcc -lboost_program_options -lgsl -lgslcblas

LIBPATH= \
	-L. \
	-L/home/users/agiannetti/lib \
	-L/mkv/extlib/sparc-sun-solaris2.8-gcc-3.4/boost-1_33_1/lib

RPATH= \
	-R. \
	-R/home/users/agiannetti/lib \
	-R/mkv/extlib/sparc-sun-solaris2.8-gcc-3.4/boost-1_33_1/lib

INCLUDES= \
	-I. \
	-I/home/users/agiannetti/include \
	-I/mkv/extlib/sparc-sun-solaris2.8-gcc-3.4/boost-1_33_1/include

CFLAGS=-g
CPPFLASG=
LDFLAGS=
DEPFLAGS=-M


all: $(LIB) $(BIN)

lib: $(LIB)

bin: $(BIN)

%.d: %.cpp
	@$(CXX) $(INCLUDES) $(DEPFLAGS) $< > $@

%.o: %.cpp
	$(CXX) -c $(INCLUDES) $(DEFS) $(CPPFLAGS) $(CFLAGS) $< -o $@

libhudson.a: $(SRC:.cpp=.o)
	ar r $@ $^
	ranlib $@

eow: $(LIB) eow.o EOWTrader.o
	$(CXX) -o $@ $(LDFLAGS) eow.o EOWTrader.o $(LIBPATH) $(LIBS)

bow: $(LIB) bow.o BOWTrader.o
	$(CXX) -o $@ $(LDFLAGS) bow.o BOWTrader.o $(LIBPATH) $(LIBS)

eom: $(LIB) eom.o EOMTrader.o
	$(CXX) -o $@ $(LDFLAGS) eom.o EOMTrader.o $(LIBPATH) $(LIBS)

eom_matrix: $(LIB) eom_matrix.o EOMTrader.o
	$(CXX) -o $@ $(LDFLAGS) eom_matrix.o EOMTrader.o $(LIBPATH) $(LIBS)

jan: $(LIB) jan.o JanTrader.o
	$(CXX) -o $@ $(LDFLAGS) jan.o JanTrader.o $(LIBPATH) $(LIBS)

jan_matrix: $(LIB) jan_matrix.o JanTrader.o
	$(CXX) -o $@ $(LDFLAGS) jan_matrix.o JanTrader.o $(LIBPATH) $(LIBS)

clean:
	\rm -f *.o *.d core

clobber:
	\rm -f *.o *.d core $(BIN)

-include dep/$(SRC:.cpp=.d)