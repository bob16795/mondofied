from abc import ABC, abstractmethod, abstractproperty
from addressing import *

def writestomem(cls):
    cls._writes_to_mem = True
    return cls


class Instruction(ABC):
    _writes_to_mem = False
    def __init__(self ):
        pass

    def __str__(self):
        return "{}, identifier byte: {}".format(self.__class__.__name__, self.identifier_byte.hex())

    @abstractproperty
    @property
    def name(self) -> str:
        return "Undifined"

    @abstractproperty
    def identifier_byte(self) -> bytes:
        return None

    def get_address(self, data_bytes):
        return None

    def side_effects(self, cpu):
        pass

    def write(self, cpu, memory_address, value):
        if self._writes_to_mem:
            memory_owner = cpu.get_mem_owner(memory_address)
            memory_owner.set(memory_address,value)


    def get_data(self, cpu, memory_addresss, data_bytes):
        return []

    def execute(self, cpu, data_bytes):
        memory_address = self.get_address(data_bytes)
        value = self.get_data(cpu, memory_address, data_bytes)
        self.write(cpu, memory_address, value)
        self.side_effects(cpu)

        print(self.__str__())

#data reg instructions
class LDAImmInstruction(ImmediateReadAdressingMixin, Instruction):
    name = "LDAImm"
    identifier_byte = bytes.fromhex('A9')

    def write(self, cpu, memory_adress, value):
        cpu.a_reg = value

class LDXImmInstruction(ImmediateReadAdressingMixin, Instruction):
    name = "LDXImm"
    identifier_byte = bytes.fromhex('A2')

    def write(self, cpu, memory_adress, value):
        cpu.x_reg = value

class TXSInstruction(NoAddressingMixin, Instruction):
    name = "TXS"
    identifier_byte = bytes.fromhex('9A')

    def side_effects(self, cpu):
        cpu.sp_reg = cpu.x_reg

@writestomem
class STAAbsInstruction(AbosoluteWriteAddressingMixin, Instruction):
    name = "STAABS"
    identifier_byte = bytes.fromhex('8D')

    def get_data(self, cpu, memory_address, value):
        return cpu.a_reg

class LDAAbsInstruction(AbosoluteWriteAddressingMixin, Instruction):
    name = "LDAABS"
    identifier_byte = bytes.fromhex('AD')

    def get_data(self, cpu, memory_address, value):
        memory_owner = cpu.get_mem_owner(memory_address)
        return memory_owner.get(memory_address)

    def write(self, cpu, memory_adress, value):
        cpu.a_reg = value

class BPLInstruction(RelitaveAddressingMixin, Instruction):
    name = "BPL"
    identifier_byte = bytes.fromhex('10')

    def side_effects(self, cpu):
            if not cpu.status_reg.negative_bit:
                pass
                #cpu.

class JMPAbsInstruction(AbosoluteWriteAddressingMixin, Instruction):
    name = "JMPABS"
    identifier_byte = bytes.fromhex('4C')

    def write(self, cpu, memory_adress, value):
        cpu.pc_reg = value

#status reg instructions
class SEIInstruction(NoAddressingMixin, Instruction):
    name = "SEI"
    identifier_byte = bytes.fromhex('78')

    def side_effects(self, cpu):
        cpu.status_reg.interupt_bit = True

class CLDInstruction(NoAddressingMixin, Instruction):
    name = "CLD"
    identifier_byte = bytes.fromhex('D8')

    def side_effects(self, cpu):
        cpu.status_reg.decimal_bit = False
