from abc import abstractproperty, abstractmethod,ABC

class MemoryOwnerMixin(ABC):
    @abstractproperty
    @property
    def mem_start(self):
        pass

    @abstractproperty
    @property
    def mem_end(self):
        pass

    @abstractmethod
    def get_memory(self):
        pass

    def get(self, position, size=1):
        return self.get_memory()[position-self.mem_start:position-self.mem_start + size][0]

    def set(self, position, value):
        self.get_memory()[position - self.mem_start] = value
        print("stored {} in {}" .format(value, self.__class__.__name__))
        print(self.get_memory())
