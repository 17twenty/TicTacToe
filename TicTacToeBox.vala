/************************************************************************
  TicTacToeBox.vala
  Copyright (C) 2011 Nick Glynn
 
  This header is free software; you can redistribute it and/or modify it
  under the terms of the GNU Lesser General Public License as published
  by the Free Software Foundation; either version 2.1 of the License,
  or (at your option) any later version.
 
  This header is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  Lesser General Public License for more details.
 
  You should have received a copy of the GNU Lesser General Public
  License along with this library; if not, write to the Free Software
  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301
  USA.
 ********************************************************************/

/// \file   TicTacToeBox
/// \brief  Simple TicTacToe Widget

using Gtk;
using Cairo;

// State isn't an enum as we use it for maths! ALGEBRAIC!
// 100 - no fill
// 2 - crosses
// 3 - naught

public class TicTacToeBox : Button {

    private static const int BORDER_WIDTH = 10;
    public int CurrentState { get; set ; default = 100; }
    private TicTacToeBoard m_Parent = null;

    construct {
        set_has_window (false);
    }
    public TicTacToeBox (TicTacToeBoard newParent) {
        m_Parent = newParent;
        // Enable the events you wish to be notified about.
        add_events (Gdk.EventMask.BUTTON_PRESS_MASK
                  | Gdk.EventMask.BUTTON_RELEASE_MASK);
        // Set preferred widget size
        set_size_request (50, 50);
    }

    /* Widget is asked to draw itself */
    public override bool draw (Cairo.Context cr) {
        int width = get_allocated_width ();
        int height = get_allocated_height ();

        cr.set_source_rgba (0.5,0.5,0.5, 1);
        cr.rectangle (BORDER_WIDTH, BORDER_WIDTH,
                      width  - 2 * BORDER_WIDTH,
                      height - 2 * BORDER_WIDTH);
                      
        cr.set_line_width (5.0);
        cr.set_line_join (LineJoin.ROUND);
        cr.stroke ();

        if (2 == CurrentState) {
            // Line top to bottom
            cr.move_to(BORDER_WIDTH, BORDER_WIDTH);
            cr.rel_line_to(width - 2 * BORDER_WIDTH, height - 2 * BORDER_WIDTH);
            cr.stroke();
            
            // Line bottom to top
            cr.move_to(width - BORDER_WIDTH, BORDER_WIDTH);
            cr.line_to(BORDER_WIDTH, height - BORDER_WIDTH);
            cr.stroke();
        } else if (3 == CurrentState) {
            var x = width / 2;
            var y = height / 2;
            var radius = double.min (x, y) - 2 * BORDER_WIDTH;
            cr.arc (x, y, radius, 0, 2 * Math.PI);
            cr.stroke();
        }
        return true;
    }
    
    public void reset() {
        CurrentState = 100;
        queue_draw();
    }

    public override bool button_press_event (Gdk.EventButton event) {        
        if (100 == CurrentState) {
            CurrentState = m_Parent.whoseGo();
            queue_draw();
        }        
        return false;
    }
    
    public override bool button_release_event (Gdk.EventButton event) {
        //stdout.printf("button_release_event\n");
        return false;
    }

    public override bool motion_notify_event (Gdk.EventMotion event) {
        //stdout.printf("motion_notify_event\n");
        return false;
    }
}

