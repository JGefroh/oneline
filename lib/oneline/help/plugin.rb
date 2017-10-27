class Plugin
  include Core::Plugin

  def initialize
    load(self)
  end

  def load(plugin)
    super(plugin)
  end

  def process(text, params = {})
    return {messages: render_help()}
  end

  def process?(text, params = {})
    return text === 'help' || text === 'help me'
  end
end
