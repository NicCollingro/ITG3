COMPUTER    = $(wildcard *.v)

build:
	iverilog -o top_level_tb -Wall \
		$(COMPUTER) 

clean:
	rm -rf top_level_tb

test:
	../Tests/test_all.run
	
.PHONY: build clean
