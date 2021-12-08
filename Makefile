src_dir = assembly_files/64-bit
obj_dir = output
src_files = $(wildcard $(src_dir)/*.asm)
obj_files = $(src_files:.asm=)
#obj_files = $(patsubst $(src_dir)/%.asm,$(obj_dir)/%,$(src_files))

#$(info obj : $(obj_files))

all: $(obj_files)
	cp $(obj_files) $(obj_dir)


%: %.asm
	./alti $< q

clean: 
	rm -f $(obj_dir)/*
	rm -f $(obj_files)
