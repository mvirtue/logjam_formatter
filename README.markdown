This gem provides syslog-compatible logging for rails applications.

Standard rails log:

    Completed in 775ms (View: 158, DB: 79) | 200 OK ...
  
With logjam_logger, including optional user_id:

    Dec 18 17:36:17 elk rails[13902] user[10]: Completed in 775ms (View: 158, DB: 79) | 200 OK ...
  
## Installation

Gemfile:

    gem 'logjam_logger'
    

    
## User ids

User ids can be logged via a global hash, $user_ids. You can use a before_filter in your application_controller to set it, eg:

    before_filter { |controller| ($user_ids ||= {})[Thread.current] = controller.session[:user_id] || 0 }
    
This is optional -- if $user_ids is undefined, that part of the log line will be left out.
   
## Log file analysis

logjam_logger was written to work well with [Logjam](http://github.com/alpinegizmo/logjam).