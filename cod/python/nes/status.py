class Status(object):
    def __init__(self):
        self.negative_bit  = False
        self.overflow_bit  = False
        self.decimal_bit   = False
        self.interrupt_bit = True
        self.zero_bit      = False
        self.carry_bit     = False
