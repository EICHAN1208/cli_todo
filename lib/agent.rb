require './lib/task_finder'

class Agent

  def initialize(arg_0, arg_1, arg_2, arg_3)
    @router = Router.new(arg_0, arg_1, arg_2, arg_3)
  end

  def give()
    render()
  end
end
