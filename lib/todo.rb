module Todo
  class << self
    attr_accessor :store_path

    def configure
      yeild self
      true
    end
  end
end
