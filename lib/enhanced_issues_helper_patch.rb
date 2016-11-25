#
# Redmine - project management software
# Copyright (C) 2006-2014  Jean-Philippe Lang
# Contributor : David Coté-Tremblay <david.cote-tremblay@savoirfairelinux.com>
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
require_dependency 'issues_helper'

module EnhancedIssuesHelperPatch

    def self.included(base)
        base.send(:include, InstanceMethods)
        base.class_eval do
            unloadable
            alias_method_chain :render_descendants_tree, :enhanced_info
        end
    end

      module InstanceMethods

        def render_descendants_tree_with_enhanced_info(issue)
            s = '<form><table class="list issues">'
            permissions = [:estimated_hours, :remaining_hours, :spent_hours]
            if Redmine::Plugin.registered_plugins.keys.include? :sfl_backlogs_permissions then
                permissions.delete_if {|perm| not SFL_Permissions.is_user_allowed_to?(User.current, :read, perm.to_s, issue.project)}
            end
            s << content_tag('thead', content_tag('tr', 
                content_tag('th', l(:field_issue)) +
                content_tag('th', l(:field_status)) +
                content_tag('th', l(:field_assigned_to)) +
                (content_tag('th', l(:field_estimated_hours)) if permissions.include? :estimated_hours) +
                (content_tag('th', l(:label_spent_time)) if issue.project.module_enabled? 'time_tracking' and permissions.include? :spent_hours) +
                (content_tag('th', l(:field_remaining_hours)) if issue.project.module_enabled? 'backlogs' and permissions.include? :remaining_hours) +
                content_tag('th', l(:field_done_ratio))
            )) if Setting.plugin_redmine_subtask_overview_enhanced['show_header']

            issue_list(issue.descendants.visible.sort_by(&:lft)) do |child, level|
                css = "issue issue-#{child.id} hascontextmenu"
                css << " idnt idnt-#{level}" if level > 0
                s << content_tag('tr',
                     content_tag('td', check_box_tag("ids[]", child.id, false, :id => nil), :class => 'checkbox') +
                     content_tag('td', link_to_issue(child, :truncate => 60, :project => (issue.project_id != child.project_id)), :class => 'subject') +
                     content_tag('td', h(child.status)) +
                     content_tag('td', link_to_user(child.assigned_to)) +
                     (content_tag('td', (if child.estimated_hours then "~ "+child.estimated_hours.to_f.round(2).to_s+"h" end)) if permissions.include? :estimated_hours) +
                     (content_tag('td', (if child.spent_hours then "= "+child.spent_hours.to_f.round(2).to_s+"h" end)) if issue.project.module_enabled? 'time_tracking' and permissions.include? :spent_hours) +
                     (content_tag('td', (if child.remaining_hours then "+ "+child.remaining_hours.to_f.round(2).to_s+"h" end)) if issue.project.module_enabled? 'backlogs' and permissions.include? :remaining_hours) +
                     content_tag('td', progress_bar(child.done_ratio, :width => '80px')),
                     :class => css)
            end
            s << '</table></form>'
            s.html_safe
        end

    end

end

IssuesHelper.send(:include, EnhancedIssuesHelperPatch)
