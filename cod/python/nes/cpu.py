from instruction import *
from collections import defaultdict
from status import Status
from rom import ROM
from ppu import PPU

class CPU(object):
    def __init__(self, ram, ppu):
        self.ram = ram
        self.ppu = ppu

        self.pc_reg = None #p counter
        self.sp_reg = None #stck pointer
        self.p_reg = None  #status reg

        #data regs: store single byte
        self.x_reg = None
        self.y_reg = None
        self.a_reg = None

        self.start_up()

        self.instructions = [
                SEIInstruction,
                CLDInstruction,
                LDAImmInstruction,
                STAAbsInstruction,
                JMPAbsInstruction,
                LDXImmInstruction,
                TXSInstruction,
                LDAAbsInstruction,
                BPLInstruction
                ]

        self.memory_owners = [
                self.ram,
                self.ppu
                ]

        self.instruction_mapping = defaultdict()
        for instruction in self.instructions:
            self.instruction_mapping[instruction.identifier_byte] = instruction

        self.rom = None

    def start_up(self):
        """
        set initial reg
        status: NVDIZC
        status: 000100
        stack : FD
        a     : 00
        x     : 00
        y     : 00
        $4017 : 00
        $4015 : 00(snd)
        $4000-
        $400f : 00(snd)
        """
        self.status_reg = Status()
        self.x_reg      = 0
        self.y_reg      = 0
        self.a_reg      = 0

        self.sp_reg     = 0xFD
        self.pc_reg     = 0
        #TODO: implement mem
    def get_mem_owner(self, location: int):
        if self.rom.mem_start() <= location <= self.rom.mem_end():
            return self.rom
        for memory_owner in self.memory_owners:
            if memory_owner.mem_start <= location <= memory_owner.mem_end:
                return memory_owner
        raise Exception('nomemowner')

    def run_rom(self, rom: ROM):
        self.rom = rom

        self.pc_reg = 16
        #run program
        self.running = True
        while self.running:
            #get instruction
            #print(self.pc_reg)
            identifier_byte = self.rom.get(self.pc_reg)
            instruction = self.instruction_mapping.get(identifier_byte, None)
            if instruction is None:
                raise Exception("LOL Instruction {} at {}".format(identifier_byte.hex(), self.pc_reg))

            #get data bytes
            inst = instruction()
            num_data = inst.instruction_length - 1

            data_bytes = self.rom.get(self.pc_reg + 1, num_data)

            #have valid instruction
            self.pc_reg += inst.instruction_length
            inst.execute( self, data_bytes)

