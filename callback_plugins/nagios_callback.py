from __future__ import (absolute_import, division, print_function)
__metaclass__ = type

from ansible.plugins.callback import CallbackBase
from ansible import constants as C

class CallbackModule(CallbackBase):

    '''
    This is the default callback interface, which simply prints messages
    to stdout when new callback events are received.
    '''

    CALLBACK_VERSION = 2.0
    CALLBACK_TYPE = 'stdout'
    CALLBACK_NAME = 'nagios_callback'

    def __init__(self):
        super(CallbackModule, self).__init__()
        self.detailed_results = []

    def v2_runner_on_failed(self, result, ignore_errors=False):
        delegated_vars = result._result.get('_ansible_delegated_vars', None)
        if 'exception' in result._result:
            if self._display.verbosity < 3:
                # extract just the actual error message from the exception text
                error = result._result['exception'].strip().split('\n')[-1]
                msg = "    An exception occurred during task execution. To see the full traceback, use -vvv. The error was: %s" % error
            else:
                msg = "    An exception occurred during task execution. The full traceback is:\n" + result._result['exception']

            self.detailed_results.append(msg)

            # finally, remove the exception from the result so it's not shown every time
            del result._result['exception']

        if not result._task.ignore_errors:
            if result._task.loop and 'results' in result._result:
                self._process_items(result)

            else:
                if delegated_vars:
                    self.detailed_results.append("    FAILED: [%s -> %s]: %s" % (result._host.get_name(), delegated_vars['ansible_host'], self._dump_results(result._result)))
                else:
                    self.detailed_results.append("    FAILED: [%s]: %s" % (result._host.get_name(), self._dump_results(result._result)))

    def v2_runner_on_ok(self, result):
        return

    def v2_runner_on_skipped(self, result):
        return

    def v2_runner_on_unreachable(self, result):
        delegated_vars = result._result.get('_ansible_delegated_vars', None)

        if delegated_vars:
            self.detailed_results.append("    UNREACHABLE: [%s -> %s]: %s" % (result._host.get_name(), delegated_vars['ansible_host'], self._dump_results(result._result)))
        else:
            self.detailed_results.append("    UNREACHABLE: [%s]: %s" % (result._host.get_name(), self._dump_results(result._result)))


    def v2_playbook_on_stats(self, stats):
        num_unreachable = len(stats.dark)
        num_failures      = len(stats.failures)

        if num_unreachable > 0 or num_failures > 0:
            print("CRITICAL: Playbook run with [%s] failures, [%s] unreachables" % (num_failures, num_unreachable))
            print("Detailed results:")
            for result in self.detailed_results:
                print(result)
        else:
            print("OK: Playbook run ok")
