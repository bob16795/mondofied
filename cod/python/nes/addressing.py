class addressingMixin(object):
    data_length = 0

    @property
    def instruction_length(self):
        return self.data_length + 1

    def get_address(self, data_bytes: bytes):
        return None

    def get_data(self, cpu, address, data_bytes):
        return None

class NoAddressingMixin(addressingMixin):
    '''
    instructions that have no data passed
    example: cld
    example: D8
    '''
    data_length = 0


class ImmediateReadAdressingMixin(addressingMixin):
    '''
    takes a value form inst data
    ex: sta #7
    ex: 8d 07
    '''
    data_length = 1

    def get_data(self, cpu, memory_address, data_bytes: bytes):
        return data_bytes[0]

class AbosoluteWriteAddressingMixin(addressingMixin):
    '''
    takes a value form inst data

    ex: sta #7
    ex: 8d 07
    '''
    data_length = 2

    def get_address(self, data_bytes: bytes):
        return int.from_bytes(data_bytes, byteorder='little')
#TODO
#class AbosoluteWriteAddressingWithXMixin(addressingMixin):
#    '''
#    takes a value form inst data and add x to address
#
#    ex: sta #7
#    ex: 8d 07
#    '''
#    data_length = 2
#
#    def get_address(self, data_bytes: bytes):
#        return int.from_bytes(data_bytes, byteorder='little')
#
class RelitaveAddressingMixin(addressingMixin):
    data_length = 1
    def get_address(self, data_bytes: bytes):
        bytes_from_int = int.from_bytes(data_bytes, byteorder='little')
        new = bytes_from_int + 1 << 2
        print(new)
