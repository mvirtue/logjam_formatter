module Logjam
  class Formatter < ::Logger::Formatter
    def call(severity, time, progname, msg)
      msg = msg.gsub(/\n/, '').lstrip if msg.kind_of?(String)
      "#{time.strftime("%b %d %H:%M:%S")} #{hostname} rails[#{$PID}]: #{severity}#{user_id}: #{msg}\n"
    end

    private

    # Logging user_ids via a global hash, $user_ids.
    # You can use a before_filter in your application_controller to set it, eg:
    #
    #    before_filter { |controller| ($user_ids ||= {})[Thread.current] = controller.session[:user_id] || 0 }
    def user_id
      defined?($user_ids) ? " user[#{$user_ids[Thread.current] || 0}]" : ''
    end

    # Note: If you are using FastCGI you may need to hard-code the hostname here instead of using Socket.gethostname
    def hostname
      @parsed_hostname ||= Socket.gethostname.split('.').first
    end
  end
end
