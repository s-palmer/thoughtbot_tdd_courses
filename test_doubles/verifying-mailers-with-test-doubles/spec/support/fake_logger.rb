class FakeLogger
  def initialize
    @messages = {
      debug: [],
      info: [],
      error: [],
      fatal: [],
    }
  end

  attr_reader :messages

  def debug(message)
    @messages[:debug] << message
  end

  def info(message)
    @messages[:info] << message
  end

  def error(message)
    @messages[:error] << message
  end

  def fatal(message)
    @messages[:fatal] << message
  end
     
end
