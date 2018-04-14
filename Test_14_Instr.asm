# Test File for  Instruction, include:
# ADD/ADDU/SUB/SUBU/AND/OR/NOR/SLT/LW/SW/ORI/BEQ/JAL/J
################################################################
### Make sure following Settings :
# Settings -> Memory Configuration -> Compact, Data at address 0

.text
	ori $29, $0, 12
	ori $2, $0, 0x1234
	ori $3, $0, 0x3456
	and $8, $2, $3
	or $9, $2, $3
	addu $4, $2, $3
	add $4, $4, $9
	subu $6, $3, $4
	sub $6, $6, $9
	nor $9, $8, $9
	slt $7, $9, $8
	sw $2, 0($0)
	sw $3, 4($0)
	sw $4, 4($29)
	lw $5, 0($0)
	beq $2, $5, _lb2
	_lb1:
	lw $3, 4($29)
	_lb2:
	lw $5, 4($0)
	beq $3, $5, _lb1
	j _target
	
	_target:
	and $8, $9, $8
	jal F_Test_JAL		# $31 change
	# Never return
	
F_Test_JAL:
	subu $6, $6, $2
	sw $6, -4($29)
	_loop:
	beq $3, $4, _loop
	# Never return back
	
