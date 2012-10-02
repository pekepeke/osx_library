'''
Paste lines
@author Justin Hileman <http://justinhileman.com>
'''

from AppKit import *
from Foundation import *

import cp_actions as cp

def act(controller, bundle, options):
    context = cp.get_context(controller)
    line_ending = cp.get_line_ending(context)

    direction = cp.get_option(options, 'direction', 'down')

    selection, current_range = cp.lines_and_range(context)

    if direction == 'down':
        target = select = cp.new_range(current_range.location + current_range.length, 0)
        if not selection.endswith(line_ending):
            select = cp.new_range(select.location + 1, 0)

    else:
        target = cp.new_range(max(current_range.location - 1, 0), 0)
        select = cp.new_range(current_range.location, 0)

    cp.insert_text_and_select(context, line_ending, target, select)