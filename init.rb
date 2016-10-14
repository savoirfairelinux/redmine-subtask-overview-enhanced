require 'redmine'

require 'enhanced_issues_helper_patch'

if Rails::VERSION::MAJOR < 3
    require 'dispatcher'
    object_to_prepare = Dispatcher
else
    object_to_prepare = Rails.configuration
end

Redmine::Plugin.register :sfl_subtank_overview_enhanced do

    name 'SFL Subtask Overview Enhanced'
    author 'David Côté-Tremblay'
    description 'Show time spent and estimated time of each tasks into the subtasks overview of a task page.'
    version '0.0.1'
    url 'https://gitlab.savoirfairelinux.com/redmine/SFL-Subtask-Overview-Enhanced'
    author_url 'http://savoirfairelinux.com'

end
