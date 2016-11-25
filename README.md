Redmine Subtask Overview Enhanced
=================================

Savoir-faire Linux
------------------

Show time spent and estimated time of each tasks into the subtasks overview of a task page.

Compatible with Redmine Backlogs.


![Plugin screenshot](https://github.com/savoirfairelinux/redmine-subtask-overview-enhanced/raw/master/screenshots/overview.jpg)

___


Minimum system requirements
---------------------------

* GNU/Linux operating system
* Redmine >= 3.2
* Ruby on Rails >= 4.2
* Ruby >= 1.9.3
* Git >= 2.1.4


Installation procedure
----------------------

We will show you how to install it on Debian family Linux distributions (such as Ubuntu), and Redmine installed with aptitude, but it can works on many other distros with similar procedure.

You may need to do those commands as root, depending on your particular case.

Feel free to replace the variable $REDMINE_PATH to your own Redmine instance path.

```bash
$REDMINE_PATH=/usr/share/redmine/

cd $REDMINE_PATH/plugins/
git clone git@github.com:savoirfairelinux/redmine-subtask-overview-enhanced.git
mv redmine-subtask-overview-enhanced redmine_subtask_overview_enhanced
rake redmine:plugins:migrate RAILS_ENV=production
service apache2 reload  # or depending on which HTTP server you use

```

Configuration procedure
-----------------------

There's no special configuration to do, but you can customise a little.

For instance, you can choose to show the subtask overview header or hide it, it is disabled by default.

If you want to enable the header : `Administration -> Plugins -> Redmine Subtask Overview Enhanced -> Configuration`

When you're there, you have a single input to configure the plugin : A checkbox to whether disable or enable the table header.

This is what it does looks like with the header enabled :

![Plugin with header screenshot](https://github.com/savoirfairelinux/redmine-subtask-overview-enhanced/raw/master/screenshots/with-thead.jpg)


Contributing to this plugin
---------------------------

We absolutely appreciate patches, feel free to contribute directly on the GitHub project.

Repositories / Development website / Bug Tracker:
- https://github.com/savoirfairelinux/redmine-subtask-overview-enhanced

Do not hesitate to join us and post comments, suggestions, questions and general feedback directly on the issues tracker.

**Author :** David Côté-Tremblay <david.cote-tremblay@savoirfairelinux.com>

**Website :** https://www.savoirfairelinux.com/
