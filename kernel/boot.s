/* Bootstrap program */
.section .text.init,"ax"
.global _start
_start:
	# Mask all interrupts
	csrw mie, zero
	csrw mip, zero

	# Load the global pointer
.option push
.option norelax
	la gp, __global_pointer$
.option pop

	# Make sure only one hart (ID=0) runs boot sequence
	csrr a2, mhartid
	bnez a2, secondary_start

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

	# Set machine trap vector
	la t0, int_vec
	csrw mtvec, t0

	jal main
	ebreak
	j wait_for_cpu

int_vec:
	jal handle_interrupt
	mret

secondary_start:
	# Set trap vector to spin forever for debugging
	la a3, secondary_start
	csrw mtvec, a3
wait_for_cpu:
	wfi
	j wait_for_cpu
