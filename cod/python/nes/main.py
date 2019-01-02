import argparse

from cpu import CPU
from rom import ROM
from ram import RAM
from ppu import PPU

HEADER_SIZE = 16
KB_SIZE = 1024

def main():
    # set up the arg parser
    parser = argparse.ArgumentParser(description='process some ints.')
    parser.add_argument('rom_path', metavar='R', type=str,
            help='path to rom')

    args = parser.parse_args()

    #TODO: validate if correct
    print(args.rom_path)

    with open(args.rom_path, 'rb') as file:
        rom_bytes = file.read()

    ppu = PPU()
    rom = ROM(rom_bytes)
    ram = RAM()

    #create cpu
    cpu = CPU(ram, ppu)
    cpu.run_rom(rom)

    cpu.process_instructions(list(instructions))

if __name__ == '__main__':
    main()
