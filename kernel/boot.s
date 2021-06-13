/* Bootstrap program */
.section .text.init,"ax"
.global _start
_start:
	# Load the global pointer
.option push
.option norelax
	la gp, __global_pointer$
.option pop
	# Make sure only one hart (ID=0) runs boot sequence
	csrr a2, mhartid
	bnez a2, wait_for_cpu

	# Clear BSS
	la a3, __bss_start
	la a4, __bss_end
	ble a4, a3, clear_bss_done
clear_bss:
	sd zero, (a3)
	addi a3, a3, 8
	blt a3, a4, clear_bss
clear_bss_done:
	# Load stack and frame pointers
	la sp, __stack_bottom
	add s0, sp, zero
	jal main
	ebreak
	j wait_for_cpu

wait_for_cpu:
	wfi
	j wait_for_cpu
