KB_SIZE = 1024

class ROM(object):
    def mem_start(self):
        return 0x4020
    def mem_end(self):
        return 0xFFFF
    def __init__(self, rom_bytes:bytes):
        self.header_size = 16
        #TODO: un hardcode
        self.num_prog_blocks = 2

        # program data
        # last for a set amnt of 16KB blocks
        self.rom_bytes = rom_bytes
        self.prg_bytes = rom_bytes[self.header_size:self.header_size+16*KB_SIZE*self.num_prog_blocks]

    def get_memory(self):
        return self.rom_bytes

    def get(self, position, size=1):
        return self.get_memory()[position:position + size]
