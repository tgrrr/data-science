class Calculator(object):
    def __init__(self):
        self._last_answer = 0.0

    @property
    def last_answer(self):
        return self._last_answer

    def add(self, a, b):
        """Adds two numbers.
        >>> calc = Calculator()
        >>> calc.add(3, 2)
        5
        """
        self._last_answer = a + b
        return self.last_answer

# import doctest
# # import pdb
# def add(a, b):
#     """Return the sum of a and b.
#     >>> add(2, 3)
#     6
#     """
#     sum = a + b
#     return sum
# 
# # if __name__ == '__main__':
# # doctest.testmod(verbose=True)