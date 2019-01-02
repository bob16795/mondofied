from memoryowner import MemoryOwnerMixin

class PPU(MemoryOwnerMixin, object):
    mem_start = 0x2000
    mem_end = 0x2007
    def __init__(self):
        self.registers = [0]*8

    def get_memory(self):
        return self.registers


