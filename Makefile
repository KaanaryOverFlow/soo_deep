altmisdokuz-ip_finder: altmisdokuz-ip_finder.asm
	alti altmisdokuz-ip_finder.asm q

dp: dp.asm
	alti dp.asm q

hex_generator: hex_generator.asm
	alti hex_generator.asm q



hile2: hile2.asm
	alti hile2.asm q



hile3: hile3.asm
	alti hile3.asm q



hile: hile.asm
	alti hile.asm q



inject: inject.asm
	alti inject.asm q



integer-string: integer-string.asm
	alti integer-string.asm q



kırk: kırk.asm
	alti kırk.asm q



led-yazi: led-yazi.asm
	alti led-yazi.asm q



mrb-gg.bin: mrb-gg.asm
	nasm -f bin -o mrg-gg.bin mrb-gg.asm



otuzsekiz: otuzsekiz.asm
	alti otuzsekiz.asm q



raw: raw.asm
	alti raw.asm q



repeater: repeater.asm
	alti repeater.asm q



reverse_tcp_shell: reverse_tcp_shell.asm
	alti reverse_tcp_shell.asm q



scan_string_in_string: scan_string_in_string.asm
	alti scan_string_in_string.asm q



server: server.asm
	alti server.asm q



sezar: sezar.asm
	alti sezar.asm q



yetmisiki: yetmisiki.asm
	alti yetmisiki.asm q



yetmissekiz: yetmissekiz.asm
	alti yetmissekiz.asm q



yetmisyedi: yetmisyedi.asm
	alti yetmisyedi.asm q



yirmialti: yirmialti.asm
	alti yirmialti.asm q



yirmi: yirmi.asm
	alti yirmi.asm q



yirmibir: yirmibir.asm
	alti yirmibir.asm q



yirmisekiz: yirmisekiz.asm
	alti yirmisekiz.asm q

install: altmisdokuz-ip_finder dp hex_generator hile2 hile3 hile inject integer-string kırk led-yazi mrb-gg.bin otuzsekiz raw repeater reverse_tcp_shell scan_string_in_string server sezar yetmisiki yetmissekiz yetmisyedi yirmialti yirmi yirmibir yirmisekiz 
	echo "Done"


clean:
	find . | xargs file | grep "executable," | awk -F ":"  '{print $$1}' | xargs rm
	rm *.o
	rm mrg-gg.bin

