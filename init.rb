require 'redmine'
require 'enhanced_issues_helper_patch'

Redmine::Plugin.register :redmine_subtask_overview_enhanced do

    name 'Redmine Subtask Overview Enhanced'
    author 'Savoir-faire Linux'
    description 'Show time spent and estimated time of each tasks into the subtasks overview of a task page.'
    version '0.1.0'
    url 'https://github.com/savoirfairelinux/redmine-subtask-overview-enhanced'
    author_url 'https://www.savoirfairelinux.com/'

    settings :default => {
        'show_header' => false,
    },  :partial => 'sfl_subtask_overview_enhanced_settings'

end
