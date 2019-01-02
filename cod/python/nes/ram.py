from memoryowner import MemoryOwnerMixin

KB = 1024

class RAM(MemoryOwnerMixin, object):
    mem_start = 0x0000
    mem_end   = 0x1FFF
    def __init__(self):
        self.memory = [0]*KB*2

    def get_memory(self):
        return self.memory
