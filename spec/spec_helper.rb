$LOAD_PATH.unshift './lib'
require 'breadboard'

def define_const(const, value)
  Object.send(:remove_const, const.to_sym) if Object.send(:const_defined?, const.to_sym)
  Object.send :const_set, const, value
end

def undefine_const(const)
  Object.send :remove_const, const.to_sym if Object.send(:const_defined?, const.to_sym)
end