run: test.xex
	start $<

test.xex: test.asx unupkr.asx conan.gfx.upk
	xasm -q -o $@ $< -l

%.ref: %.upk reference
	./reference $< $@ && cmp $* $@

reference: reference.c
	gcc -s -O2 -Wall -o $@ $<

%.upk: %
	upkr -9 -b --invert-new-offset-bit --invert-continue-value-bit --simplified-prob-update $< $@

.PRECIOUS: %.upk
