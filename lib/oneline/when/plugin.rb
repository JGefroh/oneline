module When
  # Not called "Time" to prevent conflicts.
  class Plugin
    include Core::Plugin

    def initialize(tasks = {})
      load(self)
    end

    def process(text, params = {})
      return {messages: ["It is #{Time.current.strftime('%b %e, %Y - %l:%M%P %Z')}. \n\nYou can change your timezone by entering: \n\n`my timezone is EST`"]}
    end

    def process?(text, params = {})
      return text.downcase === 'time' if text.present?
    end
  end
  ::When::Plugin.new
end
