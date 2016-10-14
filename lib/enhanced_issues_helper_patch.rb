# encoding: utf-8
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
            issue_list(issue.descendants.visible.sort_by(&:lft)) do |child, level|
                css = "issue issue-#{child.id} hascontextmenu"
                css << " idnt idnt-#{level}" if level > 0
                s << content_tag('tr',
                     content_tag('td', check_box_tag("ids[]", child.id, false, :id => nil), :class => 'checkbox') +
                     content_tag('td', link_to_issue(child, :truncate => 60, :project => (issue.project_id != child.project_id)), :class => 'subject') +
                     content_tag('td', h(child.status)) +
                     content_tag('td', link_to_user(child.assigned_to)) +
                     content_tag('td', "~ "+sprintf('%.2f', child.estimated_hours).to_s+"h") +
                     content_tag('td', "= "+sprintf('%.2f', child.spent_hours).to_s+"h") +
                     content_tag('td', progress_bar(child.done_ratio, :width => '80px')),
                     :class => css)
            end
            s << '</table></form>'
            s.html_safe
        end

    end

end

IssuesHelper.send(:include, EnhancedIssuesHelperPatch)

