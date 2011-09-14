/************************************************************************
  TicTacToeWindow.vala
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

/// \file   TicTacToeBoard
/// \brief  Grid layout to encapsultate the game tiles

using Gtk;

public class TicTacToeBoard : Grid {
    private TicTacToeBox[,] m_BoxArray = new TicTacToeBox[3, 3];
    private bool m_CrossesGo = false; 
    public signal void game_over(string winnerString);
    
    public TicTacToeBoard () {
        row_spacing = 1;
        column_spacing = 1;
        row_homogeneous = true;
        column_homogeneous = true;
        
        
        set_size_request (380, 380);
        
        // Annoyingly, the docs for attach() say width and height
        // but actually refers to how many columns, rows they span
        // expect a lot of people to be confused by this
        for (int j = 0; j < 3; ++j) {
            for (int i = 0; i < 3; ++i) {
                m_BoxArray[i,j] = new TicTacToeBox(this);
                m_BoxArray[i,j].button_release_event.connect(checkGrid);
                attach(m_BoxArray[i,j], i, j, 1, 1);
            }
        }
    }
    
    public void resetGrid() {
        for (int j = 0; j < 3; ++j) {
            for (int i = 0; i < 3; ++i) {
                m_BoxArray[i,j].reset();
            }
        }
    }
    
    // Toggle between whose gos
    public int whoseGo () {
        m_CrossesGo = !m_CrossesGo;
        return m_CrossesGo ? 2 : 3;
    }
    
    protected bool checkGrid () {
        // Rows
        int total = 0;
        for (int i = 0; i < 3; ++i) {
            int value = m_BoxArray[0,i].CurrentState + m_BoxArray[1,i].CurrentState
                        + m_BoxArray[2,i].CurrentState;
            if (6 == value) {
                game_over ("Crosses win\n");
            } else if (9 == value) {
                game_over ("Naughts win\n");
            }
            total += value;
        }
        // Columns
        for (int i = 0; i < 3; ++i) {
            int value = m_BoxArray[i,0].CurrentState + m_BoxArray[i,1].CurrentState
                        + m_BoxArray[i,2].CurrentState;
            if (6 == value) {
                game_over ("Crosses win");
            } else if (9 == value) {
                game_over ("Naughts win");
            }
            total += value;
        }
        
        // Diagonals
        {
            int value = m_BoxArray[0,0].CurrentState + m_BoxArray[1,1].CurrentState
                            + m_BoxArray[2,2].CurrentState;

            if (6 == value) {
                game_over ("Crosses win");
            } else if (9 == value) {
                game_over ("Naughts win");
            }
        }
        {
            int value = m_BoxArray[0,2].CurrentState + m_BoxArray[1,1].CurrentState
                            + m_BoxArray[2,0].CurrentState;

            if (6 == value) {
                game_over ("Crosses win");
            } else if (9 == value) {
                game_over ("Naughts win");
            }
        }
        
        if (total < 100) {
            game_over ("It's a draw");
        }
        return false;
    }
}
